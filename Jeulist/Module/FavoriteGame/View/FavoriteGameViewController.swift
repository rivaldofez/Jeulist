//
//  FavoriteGameViewController.swift
//  Jeulist
//
//  Created by Rivaldo Fernandes on 31/08/23.
//

import UIKit
import Lottie

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
    
    private lazy var favoriteGameTableView: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.register(FavoriteGameTableViewCell.self, forCellReuseIdentifier: FavoriteGameTableViewCell.identifier)
        return tableview
    }()
    
    // Loading View
    private lazy var loadingAnimation: LottieAnimationView = {
        let lottie = LottieAnimationView(name: "loading")
        lottie.translatesAutoresizingMaskIntoConstraints = false
        lottie.play()
        lottie.loopMode = .loop
        return lottie
    }()
    
    private lazy var backdropLoading: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray.withAlphaComponent(0.3)
        return view
    }()
    
    // Error View
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.text = "Error occured while load game data"
        label.textColor = .label
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var errorAnimation: LottieAnimationView = {
        let lottie = LottieAnimationView(name: "error")
        lottie.translatesAutoresizingMaskIntoConstraints = false
        lottie.heightAnchor.constraint(equalToConstant: 200).isActive = true
        lottie.play()
        lottie.loopMode = .loop
        return lottie
    }()
    
    private lazy var errorStackView: UIStackView = {
        let stackview = UIStackView(arrangedSubviews: [errorAnimation, errorLabel])
        stackview.axis = .vertical
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.alignment = .center
        stackview.spacing = 16
        stackview.isHidden = true
        return stackview
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
        view.addSubview(errorStackView)
        view.addSubview(backdropLoading)
        view.addSubview(loadingAnimation)
        
        configureConstraints()
    }
    
    private func configureConstraints() {
        let favoriteGameTableViewConstraints = [
            favoriteGameTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            favoriteGameTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            favoriteGameTableView.topAnchor.constraint(equalTo: view.topAnchor),
            favoriteGameTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        let errorStackViewConstraints = [
            errorStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        
        let loadingAnimationConstraints = [
            loadingAnimation.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingAnimation.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingAnimation.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingAnimation.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingAnimation.heightAnchor.constraint(equalToConstant: 200)
            
        ]
        
        let backdropLoadingConstraints = [
            backdropLoading.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backdropLoading.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backdropLoading.topAnchor.constraint(equalTo: view.topAnchor),
            backdropLoading.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(errorStackViewConstraints)
        NSLayoutConstraint.activate(loadingAnimationConstraints)
        NSLayoutConstraint.activate(backdropLoadingConstraints)
        NSLayoutConstraint.activate(favoriteGameTableViewConstraints)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.getFavoriteGameList()
    }
    
    func updateGameFavoriteList(with games: [GameDetail]) {
        if games.isEmpty {
            DispatchQueue.main.async {
                self.gameList.removeAll()
                self.favoriteGameTableView.reloadData()
                self.showError(isError: true, message: "There is no game added to favorite")
            }
        } else {
            DispatchQueue.main.async {
                self.gameList.removeAll()
                self.gameList.append(contentsOf: games)
                self.favoriteGameTableView.reloadData()
                self.showError(isError: false)
            }
        }
    }
    
    func updateGameFavoriteList(with error: String) {
        showError(isError: true, message: "Error occured while load game data")
    }
    
    func updateSaveToggleFavorite(with state: Bool) {
        if state {
            showToggleFavoriteAlert(title: "Added To Favorite", message: "This game successfully added to your favorite list")
        } else {
            showToggleFavoriteAlert(title: "Removed From Favorite", message: "This game successfully removed from your favorite list")
        }
    }
    
    func updateSaveToggleFavorite(with error: String) {
        showError(isError: true, message: "Error occured while load game data")
    }
    
    func isLoadingData(with state: Bool) {
        showLoading(isLoading: state)
    }
    
    private func showLoading(isLoading: Bool) {
        UIView.transition(with: loadingAnimation, duration: 0.4, options: .transitionCrossDissolve) {
            self.loadingAnimation.isHidden = !isLoading
        }
        
        UIView.transition(with: backdropLoading, duration: 0.4, options: .transitionCrossDissolve) {
            self.backdropLoading.isHidden = !isLoading
        }
    }
    
    private func showError(isError: Bool, message: String? = nil) {
        if let message = message {
            errorLabel.text = message
        }
        
        UIView.transition(with: errorStackView, duration: 0.4, options: .transitionCrossDissolve) {
            self.errorStackView.isHidden = !isError
        }
        
        UIView.transition(with: favoriteGameTableView, duration: 0.4, options: .transitionCrossDissolve) {
            self.favoriteGameTableView.isHidden = isError
        }
    }
    
    private func showToggleFavoriteAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(okButton)
        
        self.present(alert, animated: true)
    }
}

extension FavoriteGameViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if gameList.count == 0 {
            self.showError(isError: true, message: "There is no game added to favorite")
        }
        
        return gameList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteGameTableViewCell.identifier, for: indexPath) as? FavoriteGameTableViewCell else { return UITableViewCell() }
        
        let model = gameList[indexPath.row]
        cell.configure(with: model)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectGame(with: gameList[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            tableView.beginUpdates()
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            var model = gameList[indexPath.row]
            model.isFavorite = false
            
            presenter?.saveToggleFavorite(gameDetail: model)
            gameList.remove(at: indexPath.row)
            
            tableView.endUpdates()
        }
    }
}
