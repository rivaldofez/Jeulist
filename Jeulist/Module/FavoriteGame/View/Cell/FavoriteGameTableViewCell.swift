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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(gameImageView)
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
        
        let gameNameLabelConstraints = [
            gameNameLabel.leadingAnchor.constraint(equalTo: gameImageView.trailingAnchor, constant: 8),
            gameNameLabel.topAnchor.constraint(equalTo: gameImageView.topAnchor, constant: 8)
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
        NSLayoutConstraint.activate(gameNameLabelConstraints)
        NSLayoutConstraint.activate(gameReleaseLabelConstraints)
        NSLayoutConstraint.activate(gamePlatformStackViewConstraints)
        
    }
    
    
    func configure(with model: GameDetail) {
        
    }
    
}
