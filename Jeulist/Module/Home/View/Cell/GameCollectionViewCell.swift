//
//  GameCollectionViewCell.swift
//  Jeulist
//
//  Created by Rivaldo Fernandes on 20/02/23.
//

import UIKit
import SDWebImage

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
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        return label
    }()
    
    private var nameImageArr = [
        "icon_ios",
        "icon_android",
        "icon_linux",
        "icon_apple",
        "icon_xbox",
        "icon_playstations",
        "icon_windows",
        "icon_nintendo"
    ]
    
    private lazy var gamePlatformStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 2
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
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
//            gamePlatformStackView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -5),
            gamePlatformStackView.bottomAnchor.constraint(equalTo: gameNameLabel.topAnchor)
        ]
        
        NSLayoutConstraint.activate(gameImageViewConstraints)
        NSLayoutConstraint.activate(gameNameLabelConstraints)
        NSLayoutConstraint.activate(gamePlatformStackViewConstraints)
    }
    
    func configure(with model: Game){
        gameNameLabel.text = model.name
        
        guard let imageUrl = URL(string: model.backgroundImage) else { return }
        gameImageView.sd_setImage(with: imageUrl)
        
        setParentPlatformIcon(parentPlatforms: model.parentPlatforms)
    }
    
    func setParentPlatformIcon(parentPlatforms: [String]){
        if gamePlatformStackView.subviews.isEmpty {
            parentPlatforms.forEach{ name in
                let image = UIImageView(image: UIImage(named: GameConverter.platformToIconName(input: name)))
                image.widthAnchor.constraint(equalToConstant: 20).isActive = true
                image.heightAnchor.constraint(equalToConstant: 20).isActive = true
                image.tintColor = .secondaryLabel
                gamePlatformStackView.addArrangedSubview(image)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
