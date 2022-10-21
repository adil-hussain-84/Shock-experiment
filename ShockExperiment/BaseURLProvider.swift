//
//  NetworkConstants.swift
//  ShockExperiment
//
//  Created by Adil Hussain on 26/02/2021.
//

import Foundation

class BaseURLProvider {
    
    private static var baseURLString: String {
        if CommandLine.arguments.contains("-mockServer") {
            return "http://localhost:6789/"
        } else {
            return "https://swapi.dev/api/"
        }
    }
    
    static func baseURL() throws -> URL {
        guard let url = URL(string: baseURLString) else {
            throw BaseURLError.FailedInitialisingURL(urlString: baseURLString)
        }
        
        return url
    }
}

fileprivate enum BaseURLError: Error {
    case FailedInitialisingURL(urlString: String)
}
