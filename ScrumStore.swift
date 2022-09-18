import Foundation
import SwiftUI

//API calls to FileManager, JSON.ecode decode
class ScrumStore: ObservableObject {
    @Published var scrums: [DailyScrum] = []
    
    /* use the fileManager to locate the document directory(.documentDirectory) in user's home directory(.userDomainMask)
     
     return the URL with scrums.data appended to it
     */
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("scrums.data")
    }
    /* Creating an asynchrous task that submit to dispatchQueue(FIFO) in lowest priority(.background)
     
     the task call completion handler with decoded scrumdata or error message on condition
     */
    static func load(completion: @escaping (Result<[DailyScrum], Error>)->Void) {
        DispatchQueue.global(qos: .background).async{
            do{
                let fileURL = try fileURL()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else{
                    DispatchQueue.main.async{
                        completion(.success([]))
                    }
                    return
                }
                let dailyScrums = try JSONDecoder().decode([DailyScrum].self, from: file.availableData)
                
                DispatchQueue.main.async{
                    completion(.success(dailyScrums))
                }
            }
            catch{
                DispatchQueue.main.async{
                    completion(.failure(error))
                }
            }
        }
    }
    
    /*
     encode an array of scrum and save it into document directory in user's home directory
     */
    static func save(scrums: [DailyScrum], completion: @escaping (Result<Int, Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(scrums)
                let outfile = try fileURL()
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(scrums.count))
                }
                //print(data) it works
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
