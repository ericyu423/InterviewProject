//
//  APIError.swift
//  InterviewProject
//
//  Created by eric yu on 12/11/21.
//

enum APIError: Error {
    
    case image,
         load,
         parse,
         url
    
    var message: String {
        switch self {
        case .image:
            return "There was an image loading error."
        case .load:
            return "There was a loading error."
        case .parse:
            return "There was a parsing error."
        case .url:
            return "Invalid URL."
        }
    }
    
}

