//
//  ProfileViewController.swift
//  Jeulist
//
//  Created by Rivaldo Fernandes on 31/08/23.
//

import UIKit

protocol ProfileViewProtocol {
    var presenter: ProfilePresenterProtocol? { get set }
}

class ProfileViewController: UIViewController, ProfileViewProtocol {
    var presenter: ProfilePresenterProtocol?
    
    private let profileImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "profile")
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.widthAnchor.constraint(equalToConstant: 200).isActive = true
        imageview.heightAnchor.constraint(equalToConstant: 200).isActive = true
        imageview.contentMode = .scaleAspectFill
        imageview.layer.cornerRadius = 200/2
        imageview.layer.masksToBounds = false
        imageview.clipsToBounds = true
        return imageview
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Rivaldo Fernandes"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .label
        
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "rivaldofez@gmail.com"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    private lazy var profileStackView: UIStackView = {
        let stackview = UIStackView(arrangedSubviews: [ profileImageView, nameLabel, emailLabel])
        stackview.axis = .vertical
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.alignment = .center
        stackview.spacing = 16
        return stackview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        title = "Profile"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .label
        
        view.addSubview(profileStackView)
        configureConstraints()
        
    }
    
    private func configureConstraints() {
        let profileStackViewConstraints = [
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            
        ]
        
        NSLayoutConstraint.activate(profileStackViewConstraints)
    }
}
