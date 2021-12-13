//
//  PhotoCell.swift
//  InterviewProject
//
//  Created by eric yu on 12/11/21.
//

import UIKit

class PhotoCellOld: UITableViewCell
{
    static let identifier = "PhotoCell"
    
    private let imgView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func addSubviews() {
        contentView.addSubview(imgView)
        contentView.addSubview(titleLabel)
    }
    
    private func setConstraints()
    {
        imgView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        imgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 8).isActive = true
        imgView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8).isActive = true
        imgView.widthAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        
        titleLabel.leftAnchor.constraint(equalTo: imgView.rightAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
    }
    
    
    func configure(_ viewModel: PhotoSearchCellViewModel) {
        titleLabel.text = viewModel.title
        imgView.loadImageFromUrl(viewModel.imagePath)
    }
}
