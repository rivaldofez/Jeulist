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
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private let gameNameLabel: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        return label
    }()
    
    private let gameReleaseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 13)
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
    
    private var ratingStackView: UIStackView = {
        
        let image = UIImageView(image: UIImage(named: "icon_rating"))
        image.widthAnchor.constraint(equalToConstant: 15).isActive = true
        image.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .white
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 3
        stackView.addArrangedSubview(image)
        stackView.addArrangedSubview(label)
        stackView.backgroundColor = .gray.withAlphaComponent(0.7)
        stackView.layoutMargins = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layer.cornerRadius = 3
        
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
        contentView.addSubview(gameReleaseLabel)
        contentView.addSubview(ratingStackView)
        
        configureConstraints()
    }
    
    private func configureConstraints() {
        let gameImageViewConstraints = [
            gameImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            gameImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            gameImageView.bottomAnchor.constraint(equalTo: gamePlatformStackView.topAnchor, constant: -5 ),
            gameImageView.topAnchor.constraint(equalTo: contentView.topAnchor)
        ]
        
        let gameNameLabelConstraints = [
            gameNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            gameNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            gameNameLabel.bottomAnchor.constraint(equalTo: gameReleaseLabel.topAnchor),
            gameNameLabel.heightAnchor.constraint(equalToConstant: 20)
        ]
        
        let gameReleaseLabelConstraints = [
            gameReleaseLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            gameReleaseLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -5),
            gameReleaseLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            gameReleaseLabel.heightAnchor.constraint(equalToConstant: 15)
        ]
        
        let ratingStackViewConstraints = [
            ratingStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            ratingStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5)
        ]
        
        let gamePlatformStackViewConstraints = [
            gamePlatformStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            gamePlatformStackView.bottomAnchor.constraint(equalTo: gameNameLabel.topAnchor)
        ]
        
        NSLayoutConstraint.activate(gameImageViewConstraints)
        NSLayoutConstraint.activate(gameNameLabelConstraints)
        NSLayoutConstraint.activate(gameReleaseLabelConstraints)
        NSLayoutConstraint.activate(gamePlatformStackViewConstraints)
        NSLayoutConstraint.activate(ratingStackViewConstraints)
    }
    
    func configure(with model: Game) {
        gameNameLabel.text = model.name
        
        guard let imageUrl = URL(string: model.backgroundImage) else { return }
        gameImageView.sd_setImage(with: imageUrl)
        gameReleaseLabel.text = model.released

        setParentPlatformIcon(parentPlatforms: model.parentPlatforms)
        guard let ratingLabel = ratingStackView.subviews[1] as? UILabel else { return }
        ratingLabel.text = "\(model.rating)"
    }
    
    func setParentPlatformIcon(parentPlatforms: [String]) {
        if gamePlatformStackView.subviews.isEmpty {
            parentPlatforms.forEach { name in
                let image = UIImageView(image: UIImage(named: GameConverter.platformToIconName(input: name)))
                image.widthAnchor.constraint(equalToConstant: 20).isActive = true
                image.heightAnchor.constraint(equalToConstant: 20).isActive = true
                image.tintColor = .secondaryLabel
                gamePlatformStackView.addArrangedSubview(image)
            }
        }
    }
    
    override func prepareForReuse() {
        for itemView in gamePlatformStackView.arrangedSubviews {
            itemView.removeFromSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
