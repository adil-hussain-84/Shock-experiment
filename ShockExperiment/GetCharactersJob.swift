//
//  GetPeopleJob.swift
//  ShockExperiment
//
//  Created by Adil Hussain on 26/02/2021.
//

import Foundation

class GetCharactersJob {
    
    private let urlSession = URLSession(configuration: .default)
    
    func getCharacters() async throws -> GetCharactersResponse {
        
        let url = try BaseURLProvider.baseURL().appendingPathComponent("people")
        
        let (data, urlResponse) = try await urlSession.data(from: url)
        
        guard let httpURLResponse = urlResponse as? HTTPURLResponse else {
            throw GetCharactersJobError.URLResponseIsWrongType
        }
        
        let statusCode = httpURLResponse.statusCode
        
        if (statusCode != 200) {
            throw GetCharactersJobError.BadStatusCode(statusCode: statusCode)
        }
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let getCharactersResponse = try jsonDecoder.decode(GetCharactersResponse.self, from: data)
        
        return getCharactersResponse
    }
}

fileprivate enum GetCharactersJobError: Error {
    case URLResponseIsWrongType
    case BadStatusCode(statusCode: Int)
}
