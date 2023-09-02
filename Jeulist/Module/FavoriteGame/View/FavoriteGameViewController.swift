//
//  FavoriteGameViewController.swift
//  Jeulist
//
//  Created by Rivaldo Fernandes on 31/08/23.
//

import UIKit

protocol FavoriteGameViewProtocol {
    var presenter: FavoriteGameViewProtocol? { get set }
}


class FavoriteGameViewController: UIViewController, FavoriteGameViewProtocol {
    var presenter: FavoriteGameViewProtocol?

    
    private lazy var favoriteGameTableView: UITableView = {
       let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.register(FavoriteGameTableViewCell.self, forCellReuseIdentifier: FavoriteGameTableViewCell.identifier)
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Favorite"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .label
        view.backgroundColor = .systemBackground
        
        favoriteGameTableView.delegate = self
        favoriteGameTableView.dataSource = self
        
        view.addSubview(favoriteGameTableView)
        
        configureConstraints()
    }
    
    private func configureConstraints() {
        let favoriteGameTableViewConstraints = [
            favoriteGameTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            favoriteGameTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            favoriteGameTableView.topAnchor.constraint(equalTo: view.topAnchor),
            favoriteGameTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(favoriteGameTableViewConstraints)
    }
}

extension FavoriteGameViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteGameTableViewCell.identifier, for: indexPath) as? FavoriteGameTableViewCell else { return UITableViewCell() }
        
        return cell
    }
    
    
}
