//
//  LanguageTableViewCell.swift
//  SeSACNetwork
//
//  Created by cho on 1/17/24.
//

import UIKit

class LanguageTableViewCell: UITableViewCell {
    
    @IBOutlet var languageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        languageLabel.font = .systemFont(ofSize: 16)
        languageLabel.textColor = .black
    }
    
    
    
}
