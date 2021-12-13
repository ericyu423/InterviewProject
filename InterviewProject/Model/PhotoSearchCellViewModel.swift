//
//  PhotoCellViewModel.swift
//  InterviewProject
//
//  Created by eric yu on 12/11/21.
//

struct PhotoSearchCellViewModel
{
    private let id: String
    private let secret: String
    private let server: String
    private let farm: Int
    private let title: String
        
    init(photo: Photo)
    {
        self.title = photo.title
        self.secret = photo.secret
        self.server = photo.server
        self.farm = photo.farm
        self.id = photo.id
    }
    
    func photoTitle() -> String
    {
        return title
    }
   
    func thumbnailPath() -> String
    {
        return "https://farm\(farm).static.flickr.com/\(server)/\(id)_\(secret)_t.jpg"
    }
    
    func fullImagePath() -> String
    {
        return "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_b.jpg"
    }
}
