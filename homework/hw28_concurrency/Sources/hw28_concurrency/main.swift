// HW28: Concurrency 
//=================================================================================================================
// import Foundation
// print("=============== Async & Await ===============")

// func getResponse(within seconds: Double) async -> String {
//     print("b4")
//     await Task.sleep(UInt64(seconds * 1_000_000))
//     print("Sleep completed in \(seconds)")
//     let response = "This request is complete within \(seconds) seconds.";
//     return response;
// }

// // let a = await getResponse(within: 0.2);
// func listPhotos(inGallery name: String) async -> [String] {
//     await Task.sleep(10 * 1_000_000_000)  // Two seconds
//     return ["IMG001", "IMG99", "IMG0404"]
// }

// func plsWork() {
//     Task { 
//         await listPhotos(inGallery: "Summer") 
//     }
// }
// print(plsWork())

// import Foundation
// import FoundationNetworking
// import Swift
// public extension URLSession {
//     enum URLSessionError: Error {
//         case unknownError
//     }
//     func data(from url: URL) async throws -> (Data, URLResponse) {
//         try await withCheckedThrowingContinuation { continuation in 
//             dataTask(with: url) { data, response, error in
//                if let error = error {
//                    continuation.resume(throwing: error)
//                } else if let data = data, let response = response {
//                    continuation.resume(returning: (data, response))
//                } else {
//                    continuation.resume(throwing: URLSessionError.unknownError)
//                }
//             }.resume()
//         }
//     }
// }

// struct Score: Decodable {
//     let name: String
//     let score: Int
// }

// func fetch() async throws -> Data {
//     let url = URL(string: "https://hws.dev/scores.json")!
//     let (data1, _) = try await URLSession.shared.data(from: url)
//     print(data1)
//     return data1
// }

// Task{ try await fetch() }

// PROBLEM: async-await cannot be start within `Task {}`