//
//  BookCollectionViewCell.swift
//  SeSACNetwork
//
//  Created by cho on 1/17/24.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet var thumbnailView: UIImageView!
    @IBOutlet var bookTitleLabel: UILabel!
    @IBOutlet var bookAuthorsLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var bookContentsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.borderWidth = 1
        
        thumbnailView.contentMode = .scaleAspectFit
        thumbnailView.backgroundColor = .red
        
        bookTitleLabel.text = "책이름"
        bookTitleLabel.font = .systemFont(ofSize: 14)
        
        bookAuthorsLabel.text = "작가이름"
        bookAuthorsLabel.font = .systemFont(ofSize: 14)
        
        priceLabel.text = "₩5,600"
        priceLabel.font = .systemFont(ofSize: 13)
        
        bookContentsLabel.text = "책설명책설명책설명책설명책설명책설명책설명책설명책설명책설명책설명책설명책설명책설명책설명책설명책설명책설명책설명책설명"
        bookContentsLabel.numberOfLines = 0
        bookContentsLabel.font = .systemFont(ofSize: 11)
    }
    
    
    

}
