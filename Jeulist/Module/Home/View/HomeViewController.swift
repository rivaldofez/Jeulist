//
//  HomeViewController.swift
//  Jeulist
//
//  Created by Rivaldo Fernandes on 18/02/23.
//

import UIKit
import RxSwift
import Lottie

protocol HomeViewProtocol {
    var presenter: HomePresenterProtocol? { get set}
    func updateGameList(with games: [Game])
    func updateGameList(with error: String)
    func isLoadingDataGameList(with state: Bool)
}

class HomeViewController: UIViewController, HomeViewProtocol {
    var presenter: HomePresenterProtocol?
    private let disposeBag = DisposeBag()
    
    private var gameDataPagination: [Game] = []
    private let searchController = UISearchController()
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
    
    // MARK: View Components
    // Game Collection View
    private lazy var gameCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: ((view.frame.size.width) / 2) - 21, height: (view.frame.size.width) / 2)
        
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.register(GameCollectionViewCell.self, forCellWithReuseIdentifier: GameCollectionViewCell.identifier)
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionview
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
    
    private lazy var retryButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        button.tintColor = .label
        button.addTarget(self, action: #selector(reloadData), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var errorStackView: UIStackView = {
        let stackview = UIStackView(arrangedSubviews: [errorAnimation, errorLabel, retryButton])
        stackview.axis = .vertical
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.alignment = .center
        stackview.spacing = 16
        stackview.isHidden = true
        return stackview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Explore Game"
        navigationController?.navigationBar.tintColor = .label
        view.backgroundColor = .systemBackground
        
        navigationItem.searchController = searchController
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.showsScopeBar = true
        searchController.automaticallyShowsCancelButton = true
        searchController.navigationItem.hidesSearchBarWhenScrolling = false
        
        searchController.searchBar.delegate = self
        
        view.addSubview(gameCollectionView)
        view.addSubview(errorStackView)
        view.addSubview(backdropLoading)
        view.addSubview(loadingAnimation)
        
        configureConstraints()
        
        gameCollectionView.delegate = self
        gameCollectionView.dataSource = self
    }
    
    private func configureConstraints() {
        let gameCollectionViewConstraints = [
            gameCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            gameCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            gameCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            gameCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
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
        NSLayoutConstraint.activate(gameCollectionViewConstraints)
        NSLayoutConstraint.activate(backdropLoadingConstraints)
    }
    
    func updateGameList(with games: [Game]) {
        DispatchQueue.main.async {
            if self.presenter!.page <= 1 {
                self.gameDataPagination.removeAll()
            }
            self.gameDataPagination.append(contentsOf: games)
            self.gameCollectionView.reloadData()
            self.showError(isError: false)
        }
    }
    
    func updateGameList(with error: String) {
        showError(isError: true)
    }
    
    func isLoadingDataGameList(with state: Bool) {
        showLoading(isLoading: state)
    }
    
    // MARK: Button Action
    
    @objc private func reloadData() {
        if let page = presenter?.page, let pageSize = presenter?.pageSize, let search = presenter?.searchQuery {
            presenter?.getGameDataPagination(pageSize: pageSize, page: page, search: search)
        }
    }
    
    private func showLoading(isLoading: Bool) {
        UIView.transition(with: loadingAnimation, duration: 0.4, options: .transitionCrossDissolve) {
            self.loadingAnimation.isHidden = !isLoading
        }
        
        UIView.transition(with: backdropLoading, duration: 0.4, options: .transitionCrossDissolve) {
            self.backdropLoading.isHidden = !isLoading
        }
    }
    
    private func showError(isError: Bool) {
        UIView.transition(with: errorStackView, duration: 0.4, options: .transitionCrossDissolve) {
            self.errorStackView.isHidden = !isError
        }
        
        UIView.transition(with: gameCollectionView, duration: 0.4, options: .transitionCrossDissolve) {
            self.gameCollectionView.isHidden = isError
        }
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.searchQuery = searchText
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameDataPagination.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCollectionViewCell.identifier, for: indexPath) as? GameCollectionViewCell else { return UICollectionViewCell()}
        
        let model = gameDataPagination[indexPath.row]
        cell.configure(with: model)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectGameItem(with: gameDataPagination[indexPath.item].id)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (gameCollectionView.contentSize.height - 100 - scrollView.frame.size.height) {
            
            guard let isLoadingData = presenter?.isLoadingData else { return }
            if !isLoadingData {
                guard var presenter = self.presenter else { return }
                presenter.page += 1
            }
        }
    }
    
}
