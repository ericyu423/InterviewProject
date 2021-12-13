//
//  APICallerProtocol.swift
//  InterviewProject
//
//  Created by eric yu on 12/11/21.
//


protocol APICallerProtocol
{
    func searchPhotos<T: Codable>(with keyword: String, perPage: Int, page: Int, completion: @escaping (Result<T, APIError>) -> Void)
}
