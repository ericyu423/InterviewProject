//
//  ViewController.swift
//  InterviewProject
//
//  Created by eric yu on 12/8/21.
//

import UIKit

final class SearchTableViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak fileprivate var searchBar: UISearchBar!
    @IBOutlet weak fileprivate var tableView: UITableView!

    fileprivate var photoSearchViewModel: PhotoSearchViewModel?
    
    private let emptyTableLabel: UILabel = {
        let label = UILabel()
        label.text = "No Images Found"
        return label
    }()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupUI()
        searchBar.becomeFirstResponder()
    }

    private func setupUI()
    {
        self.title = "Flicker Search"
        
        let nib = UINib(nibName:PhotoCell.identifier, bundle: Bundle(for: PhotoCell.self))
        tableView.register(nib, forCellReuseIdentifier: PhotoCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    }
    
    private func showLoadingIndicator()
    {
        DispatchQueue.main.async
        {
            let activityView = UIActivityIndicatorView(style: .large)
            activityView.color = .blue
            activityView.startAnimating()
            self.tableView.backgroundView = activityView
        }
    }
    
    private func hideLoadingIndicator()
    {
        DispatchQueue.main.async
        {
            self.tableView.backgroundView = nil
        }
    }

    private func showEmptyView()
    {
        DispatchQueue.main.async
        {
            self.tableView.backgroundView = self.emptyTableLabel
        }
    }
    
    private func initialLoad()
    {
        self.showLoadingIndicator()
        
        photoSearchViewModel?.initialLoad { [weak self] error  in
            
            self?.hideLoadingIndicator()
            
            if let _ = error
            {
                //we can do something if there is an error here
            }
            else
            {
                if self?.photoSearchViewModel?.photoCount() == 0
                {
                    self?.showEmptyView()
                }
                
                DispatchQueue.main.async
                {
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    private func search(text: String)
    {
        let photoSearchViewModel = PhotoSearchViewModel(search: text)
        self.photoSearchViewModel = photoSearchViewModel
        initialLoad()
    }
}

//MARK: scrollView Delegates and related method
extension SearchTableViewController
{
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        if isLastCell(scrollView)
        {
            loadNextPhotos()
        }
    }
    
    func scrollViewDidScrollToBottom()
    {
        loadNextPhotos()
    }
    
    private func isLastCell(_ scrollView: UIScrollView) -> Bool
    {
        let currentOffset = scrollView.contentOffset.y
        let contentSizeHeight = scrollView.contentSize.height
        let scrollViewHeight = scrollView.frame.size.height
        let maximumOffset = contentSizeHeight - scrollViewHeight
        return currentOffset >= 0 && currentOffset >= maximumOffset
    }
    
    
    private func loadNextPhotos()
    {
        guard let photoSearchViewModel = photoSearchViewModel,
              !photoSearchViewModel.lastFetch()
        else { return }
        
        photoSearchViewModel.getNextPhotos
        { [weak self] error in
            
            if let _ = error
            {
                //we can do something if there is an error here
            }
            else
            {
                DispatchQueue.main.async
                {
                    self?.tableView.reloadData()
                }
            }
        }
    }
}




//MARK: tableview Delegate methods
extension SearchTableViewController
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return photoSearchViewModel?.photoCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: PhotoCell.identifier, for: indexPath) as? PhotoCell,
                  let cellViewModel = photoSearchViewModel?.getPhoto(at: indexPath.item)
        else { return UITableViewCell() }
            
        cell.configureCell(cellViewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if let cellViewModel = photoSearchViewModel?.getPhoto(at: indexPath.item)
        {
            let photoDetailViewController = PhotoDetailViewController(viewModel: cellViewModel)
            navigationController?.pushViewController(photoDetailViewController, animated: true)
        }
    }
}

//MARK: Search Delegate methods
extension SearchTableViewController
{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        if let fieldText = searchBar.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines), fieldText.isEmpty == false
        {
            search(text: fieldText)
        }
    }
}
