//
//  GameCollectionViewCell.swift
//  Jeulist
//
//  Created by Rivaldo Fernandes on 20/02/23.
//

import UIKit

class GameCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "GameCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
