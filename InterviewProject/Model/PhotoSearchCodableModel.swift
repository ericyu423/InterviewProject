//
//  PhotoSearch.swift
//  InterviewProject
//
//  Created by eric yu on 12/10/21.
//

struct PhotoSearchCodableModel: Codable
{
    let photos: Photos
    let stat: String
}

struct Photos: Codable
{
    let page: Int
    let pages: Int
    let perpage: Int
    let total: Int
    let photo: [Photo]
}

struct Photo: Codable
{
    let id: String
    let owner: String
    let secret: String
    let server: String
    let farm: Int
    let title: String
    let ispublic: Int
    let isfriend: Int
    let isfamily: Int
}
