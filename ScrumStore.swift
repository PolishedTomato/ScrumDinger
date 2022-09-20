import Foundation
import SwiftUI

//API calls to FileManager, JSON.ecode decode
class ScrumStore: ObservableObject {
    @Published var scrums: [DailyScrum] = []
    
    /* use the fileManager to locate the document directory(.documentDirectory) in user's home directory(.userDomainMask)
     
     return the URL with scrums.data(it doesn't matter what name this is) appended to it
     */
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("scrums.data")
    }
    /*Embeded old load function with await syntax in swift 5.5
     withCheckedThrowingContnuation call the supply closure with continuation instance which have method to throw a error or return a value to stop the suspansion on task
     */
    static func load() async throws -> [DailyScrum] {
        try await withCheckedThrowingContinuation { continuation in
            load { result in
                switch result {
                case .failure(let error):
                    continuation.resume(throwing: error)
                case .success(let scrums):
                    continuation.resume(returning: scrums)
                }
            }
        }
    }
    
    /* Creating an asynchrous task that submit to dispatchQueue(FIFO) in lowest priority(.background)
     
     the task call completion handler with decoded scrumdata or error message on condition
     */
    static func load(completion: @escaping (Result<[DailyScrum], Error>)->Void) {
        DispatchQueue.global(qos: .background).async{
            do{
                let fileURL = try fileURL()
                /*
                print(FileManager.default.fileExists(atPath: fileURL.path))
                print("from load")
                 */
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
     async call to old save function with same trick
     */
    @discardableResult
    static func save(scrums: [DailyScrum]) async throws -> Int {
        try await withCheckedThrowingContinuation { continuation in
            save(scrums: scrums) { result in
                switch result {
                case .failure(let error):
                    continuation.resume(throwing: error)
                case .success(let scrumsSaved):
                    continuation.resume(returning: scrumsSaved)
                }
            }
        }
    }
    
    /*
     encode an array of scrum and save it into document directory in user's home directory
     Notice scrum.data in document directory(URL) doesn't exit before the data.write(), and data.write create the file on first run and write to it. This function was trigged by lifecycle modifier of onChange{} which can be trigger by coming back to home screen. Thus, returning to home screen save the data in scrum.data 
     */
    static func save(scrums: [DailyScrum], completion: @escaping (Result<Int, Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(scrums)
                let outfile = try fileURL()
                /*
                print(FileManager.default.fileExists(atPath: outfile.path))
                print("from save before write")
                */
                try data.write(to: outfile)
                /*
                print(FileManager.default.fileExists(atPath: outfile.path))
                print("from save after write")
                */
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
