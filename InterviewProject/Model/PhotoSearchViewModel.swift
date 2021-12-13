//
//  ViewModel.swift
//  InterviewProject
//
//  Created by eric yu on 12/10/21.
//

final class PhotoSearchViewModel
{
    fileprivate var service: APICallerProtocol
    fileprivate var photoObjects: [Photo] = []
    fileprivate var isFetching = false
    fileprivate var isLastFetch = false
    fileprivate var page = 1
    fileprivate let searchString: String
    
    init(_ service: APICallerProtocol = APICaller(), search: String)
    {
        self.service = service
        self.searchString = search
    }
    
    private func fetchPhotos(completion: @escaping (APIError?) -> Void)
    {
        guard isFetching == false else { return }
        isFetching = true
   
        service.searchPhotos(with: searchString, perPage: NetworkConstants.resultsPerPage, page: page)
        {
            [weak self] (result: Result<PhotoSearchCodableModel, APIError>) in
            
            guard let self = self else { return }
            
            switch result
            {
            case .success(let data):
                self.handleSuccess(data: data)
                completion(.none)
            case .failure(let error):
                completion(error)
            }
            self.isFetching = false
        }
    }
    
    private func handleSuccess(data: PhotoSearchCodableModel?)
    {
        guard let data = data?.photos.photo  else { return }
        
        if data.isEmpty
        {
            self.isLastFetch = true
        }
        else
        {
            self.photoObjects.append(contentsOf: data)
            self.page = self.page + 1
        }
    }
}

//MARK: public functions
extension PhotoSearchViewModel
{
    func initialLoad(completion: @escaping (APIError?) -> Void)
    {
        page = 1
        photoObjects.removeAll()
        isLastFetch = false
        fetchPhotos(completion: completion)
    }
    
    func getNextPhotos(completion: @escaping (APIError?) -> Void)
    {
        fetchPhotos(completion: completion)
    }
    
    func getPhoto(at index: Int) -> PhotoSearchCellViewModel?
    {
        if photoObjects.count > index
        {
            let item = photoObjects[index]
            return PhotoSearchCellViewModel(photo: item)
        }
        return nil
    }
    
    func photoCount() -> Int
    {
        return photoObjects.count
    }
    
    func lastFetch() -> Bool
    {
        return isLastFetch
    }
}
