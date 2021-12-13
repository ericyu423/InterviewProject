//
//  PhotoDetailViewController.swift
//  InterviewProject
//
//  Created by eric yu on 12/12/21.
//

import UIKit

final class PhotoDetailViewController: UIViewController
{
    private let viewModel: PhotoSearchCellViewModel
    
    lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    init(viewModel: PhotoSearchCellViewModel)
    {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupUI()
        title = viewModel.photoTitle()
        photoImageView.loadImageFromUrl(viewModel.fullImagePath())
    }
    
    private func setupUI()
    {
        view.backgroundColor = .white
        view.addSubview(photoImageView)
        photoImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        photoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        photoImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        photoImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}
