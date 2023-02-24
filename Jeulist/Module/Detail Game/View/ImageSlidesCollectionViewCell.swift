//
//  ImageSlidesCollectionViewCell.swift
//  Jeulist
//
//  Created by Rivaldo Fernandes on 21/02/23.
//

import UIKit
import SDWebImage

class ImageSlidesCollectionViewCell: UICollectionViewCell {
    static let identifier = "ImageSlidesCollectionViewCell"
    
    private let gameImageView: UIImageView = {
       let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "testimage")
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(gameImageView)
        
        configureConstraints()
    }
    
    private func configureConstraints(){
        let gameImageViewConstraints = [
            gameImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            gameImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            gameImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            gameImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(gameImageViewConstraints)
    }
    
    func configure(with screenshot: String){
        guard let url = URL(string: screenshot) else { return }
        gameImageView.sd_setImage(with: url)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
