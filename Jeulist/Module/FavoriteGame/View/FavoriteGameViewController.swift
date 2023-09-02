//
//  FavoriteGameViewController.swift
//  Jeulist
//
//  Created by Rivaldo Fernandes on 31/08/23.
//

import UIKit

protocol FavoriteGameViewProtocol {
    var presenter: FavoriteGamePresenterProtocol? { get set }
    func updateGameFavoriteList(with games: [GameDetail])
    func updateGameFavoriteList(with error: String)
    func updateSaveToggleFavorite(with state: Bool)
    func updateSaveToggleFavorite(with error: String)
    func isLoadingData(with state: Bool)
}


class FavoriteGameViewController: UIViewController, FavoriteGameViewProtocol {
    var presenter: FavoriteGamePresenterProtocol?
    
    private var gameList: [GameDetail] = []
    
    func updateGameFavoriteList(with games: [GameDetail]) {
        if games.isEmpty {
            DispatchQueue.main.async {
                self.gameList.removeAll()
                self.favoriteGameTableView.reloadData()
//                self.showError(isError: true, message: "There is no game added to favorite", animation: "empty")
            }
        } else {
            DispatchQueue.main.async {
                self.gameList.removeAll()
                self.gameList.append(contentsOf: games)
                self.favoriteGameTableView.reloadData()
            }
        }
    }
    
    func updateGameFavoriteList(with error: String) {
        
    }
    
    func updateSaveToggleFavorite(with state: Bool) {
        
    }
    
    func updateSaveToggleFavorite(with error: String) {
        
    }
    
    func isLoadingData(with state: Bool) {
        
    }
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.getFavoriteGameList()
    }
}

extension FavoriteGameViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteGameTableViewCell.identifier, for: indexPath) as? FavoriteGameTableViewCell else { return UITableViewCell() }
        
        let model = gameList[indexPath.row]
        cell.configure(with: model)
        
        return cell
    }
    
    
}
