//
//  APICaller.swift
//  InterviewProject
//
//  Created by eric yu on 12/9/21.
//

import Foundation

enum NetworkConstants
{
    static let host: String = "https://api.flickr.com/services/rest/"
    static let apiKey: String = "1508443e49213ff84d566777dc211f2a"
    static let photoSearchMethod: String = "flickr.photos.search"
    static let resultsPerPage: Int = 25
}

final class APICaller: APICallerProtocol
{
    private var urlSession: URLSession
    
    init(with urlSession: URLSession = .shared)
    {
        self.urlSession = urlSession
    }
    
    func searchPhotos<T: Codable>(with keyword: String,
                            perPage: Int = NetworkConstants.resultsPerPage,
                            page: Int = 1, completion: @escaping (Result<T, APIError>) -> Void)
    {
        let parameters: [String: Any] = [
            "method": NetworkConstants.photoSearchMethod,
            "api_key": NetworkConstants.apiKey,
            "text": keyword,
            "format": "json",
            "nojsoncallback": 1,
            "per_page": perPage,
            "page": page
        ]
                
        guard let host = URL(string: NetworkConstants.host) else {
            completion(.failure(.url))
            return
        }
        
        let request = URLRequest(url: host.attachingParameters(parameters))
        load(request, completion: completion)
    }
    
    private func load<T: Codable>(_ request: URLRequest, completion: @escaping (Result<T, APIError>) -> Void)
    {
  
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(.failure(.load))
                return
            }
            
            guard let decoded = try? JSONDecoder().decode(T.self, from: data) else {
                completion(.failure(.parse))
                return
            }
      
            completion(.success(decoded))
            
        }.resume()
    }
}

