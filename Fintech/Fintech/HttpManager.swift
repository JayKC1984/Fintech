//
//  HttpManager.swift
//  Fintech
//
//  Created by User on 2022/3/19.
//

import Foundation
class HttpManager: NSObject {

    static let shared = HttpManager()

    func loadJson(fromURLString urlString: String,
                          completion: @escaping (Result<Data, Error>) -> Void) {
        if let url = URL(string: urlString) {
            let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                }
                
                if let data = data {
                    completion(.success(data))
                }
            }
            
            urlSession.resume()
        }
    }
    
    func loadPic(url:URL,completion: @escaping (Data) -> Void) {
        let data = (try? Data(contentsOf: url))!
        completion(data)
    }
    
}
