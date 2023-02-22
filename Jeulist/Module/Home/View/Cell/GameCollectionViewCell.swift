//
//  GameCollectionViewCell.swift
//  Jeulist
//
//  Created by Rivaldo Fernandes on 20/02/23.
//

import UIKit

class GameCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "GameCollectionViewCell"
    
    private let gameImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "testimage")
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private let gameNameLabel: UILabel = {
       let label = UILabel()
        label.text = "Harvest Moon Back To Nature"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        return label
    }()
    
    private lazy var gamePlatformStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        for i in 0...4 {
            let image = UIImageView(image: UIImage(systemName: "apple.logo"))
            image.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
            stackView.addArrangedSubview(image)
        }
        
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .gray.withAlphaComponent(0.2)
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 8
        
        contentView.addSubview(gameImageView)
        contentView.addSubview(gameNameLabel)
        contentView.addSubview(gamePlatformStackView)
        
        configureConstraints()
    }
    
    private func configureConstraints(){
        let gameImageViewConstraints = [
            gameImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            gameImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            gameImageView.bottomAnchor.constraint(equalTo: gamePlatformStackView.topAnchor, constant: -5 ),
            gameImageView.topAnchor.constraint(equalTo: contentView.topAnchor)
        ]
        
        let gameNameLabelConstraints = [
            gameNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            gameNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            gameNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            gameNameLabel.heightAnchor.constraint(equalToConstant: 20)
        ]
        
        let gamePlatformStackViewConstraints = [
            gamePlatformStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            gamePlatformStackView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -5),
            gamePlatformStackView.bottomAnchor.constraint(equalTo: gameNameLabel.topAnchor)
        ]
        
        NSLayoutConstraint.activate(gameImageViewConstraints)
        NSLayoutConstraint.activate(gameNameLabelConstraints)
        NSLayoutConstraint.activate(gamePlatformStackViewConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
