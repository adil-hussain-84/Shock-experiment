//
//  NetworkConstants.swift
//  ShockExperiment
//
//  Created by Adil Hussain on 26/02/2021.
//

import Foundation

class NetworkConstants {
    
    private static var baseURLString: String {
        if CommandLine.arguments.contains("-mockServer") {
            return "http://localhost:9999/swapi.dev/api/"
        } else {
            return "https://swapi.dev/api/"
        }
    }
    
    static func baseURL() throws -> URL {
        guard let url = URL(string: baseURLString) else {
            throw NetworkConstantsError.FailedInitialisingURL(urlString: baseURLString)
        }
        
        return url
    }
}

fileprivate enum NetworkConstantsError: Error {
    case FailedInitialisingURL(urlString: String)
}
