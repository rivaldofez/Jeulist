//
//  FavoriteGameTableViewCell.swift
//  Jeulist
//
//  Created by Rivaldo Fernandes on 02/09/23.
//

import UIKit

class FavoriteGameTableViewCell: UITableViewCell {
    static let identifier = "FavoriteGameTableViewCell"
    
    private let gameImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.alpha = 1
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let gameNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "Charizard"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .label
        return label
    }()
    
    private let gameReleaseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "Charizard"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .label
        return label
    }()
    
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
        label.text = "8.5"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 4
        
        stackView.addArrangedSubview(image)
        stackView.addArrangedSubview(label)
        
        return stackView
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(gameImageView)
        contentView.addSubview(ratingStackView)
        contentView.addSubview(gameNameLabel)
        contentView.addSubview(gameReleaseLabel)
        contentView.addSubview(gamePlatformStackView)
        
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraints() {
        
        let gameImageViewConstraints = [
            gameImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            gameImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            gameImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            gameImageView.widthAnchor.constraint(equalToConstant: 130),
            gameImageView.heightAnchor.constraint(equalToConstant: 100)
        ]
        
        let ratingStackViewConstraints = [
            ratingStackView.topAnchor.constraint(equalTo: gameImageView.topAnchor, constant: 8),
            ratingStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ]
        
        let gameNameLabelConstraints = [
            gameNameLabel.leadingAnchor.constraint(equalTo: gameImageView.trailingAnchor, constant: 8),
            gameNameLabel.topAnchor.constraint(equalTo: gameImageView.topAnchor, constant: 8),
            gameNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: ratingStackView.leadingAnchor)
        ]
        
        let gameReleaseLabelConstraints = [
            gameReleaseLabel.leadingAnchor.constraint(equalTo: gameNameLabel.leadingAnchor),
            gameReleaseLabel.topAnchor.constraint(equalTo: gameNameLabel.bottomAnchor, constant: 8)
        ]
        
        let gamePlatformStackViewConstraints = [
            gamePlatformStackView.leadingAnchor.constraint(equalTo: gameNameLabel.leadingAnchor),
            gamePlatformStackView.topAnchor.constraint(equalTo: gameReleaseLabel.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(gameImageViewConstraints)
        NSLayoutConstraint.activate(ratingStackViewConstraints)
        NSLayoutConstraint.activate(gameNameLabelConstraints)
        NSLayoutConstraint.activate(gameReleaseLabelConstraints)
        NSLayoutConstraint.activate(gamePlatformStackViewConstraints)
        
    }
    
    
    func configure(with model: GameDetail) {
        
    }
    
}
