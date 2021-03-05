//
//  URLSessionExtensions.swift
//  ShockExperiment
//
//  Created by Adil Hussain on 26/02/2021.
//

import Foundation

extension URLSession {
    func synchronousDataTask(with url: URL) throws -> (Data?, URLResponse?) {
        var data: Data?
        var urlResponse: URLResponse?
        var error: Error?
        
        let semaphore = DispatchSemaphore(value: 0)
        
        let dataTask = self.dataTask(with: url) {
            data = $0
            urlResponse = $1
            error = $2
            
            semaphore.signal()
        }
        dataTask.resume()
        
        _ = semaphore.wait(timeout: .distantFuture)
        
        if let error = error {
            throw error
        }
        
        return (data, urlResponse)
    }
}
