//
//  PhotoCell.swift
//  InterviewProject
//
//  Created by eric yu on 12/12/21.
//

import UIKit

final class PhotoCell: UITableViewCell
{
    static let identifier = "PhotoCell"
    
    @IBOutlet weak fileprivate var titleLabel: UILabel!
    @IBOutlet weak fileprivate var photoImage: UIImageView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse()
    {
        super.prepareForReuse()
        
        self.titleLabel.text = ""
        self.photoImage.image = nil
    }
}

extension PhotoCell
{
    func configureCell(_ viewModel: PhotoSearchCellViewModel)
    {
        self.titleLabel.text = viewModel.photoTitle()
        self.photoImage.loadImageFromUrl(viewModel.thumbnailPath())
    }
}
