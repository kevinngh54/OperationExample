//
//  BaseRequest.swift
//  Examination1
//
//  Created by NHK on 10/4/20.
//  Copyright © 2020 NHK. All rights reserved.
//

import Foundation
import ObjectMapper

class BaseRequest {
    let baseUrl = "https://my-json-server.typicode.com/congeovi/"
    static let shared = BaseRequest()
    
    func request<T: BaseBO>(path: String,
                                   successCompletion: @escaping (T) -> Void,
                                   failCompletion: (() -> Void)? = nil) {
        guard let url = URL(string: "\(baseUrl)\(path)") else {
            failCompletion?()
            return
        }
        URLSession.shared.dataTask(with: url,
                                   completionHandler:
            { (data, response, error) in
                guard let data = data,
                    error == nil,
                    let jsonDict = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                    let object = Mapper<T>().map(JSON: jsonDict) else {
                    failCompletion?()
                    return
                }
                successCompletion(object)
        }).resume()
    }
    
    func downloadImage(from url: String, completion: @escaping (Data) -> Void) -> URLSessionDataTask? {
        guard let url = URL(string: url) else { return nil }
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            guard let data = data, error == nil else { return }
            completion(data)
        })
        return task
    }
}
