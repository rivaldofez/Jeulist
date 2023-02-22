//
//  HomeViewController.swift
//  Jeulist
//
//  Created by Rivaldo Fernandes on 18/02/23.
//

import UIKit
import RxSwift

protocol HomeViewProtocol {
    var presenter: HomePresenterProtocol? { get set}
    
    func updateGameList(with games: [Game])
    func updateGameList(with error: String)
    func isLoadingDataGameList(with state: Bool)
}

class HomeViewController: UIViewController, HomeViewProtocol {
    var presenter: HomePresenterProtocol?
    
    func updateGameList(with games: [Game]) {
        print(games)
    }
    
    func updateGameList(with error: String) {
        print(error)
    }
    
    func isLoadingDataGameList(with state: Bool) {
        print(state)
    }
    
    
    private let disposeBag = DisposeBag()
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }

    let searchController = UISearchController()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Explore Game"
        navigationController?.navigationBar.tintColor = .label
        view.backgroundColor = .systemBackground
        
        
        navigationItem.searchController = searchController
//        searchController.searchBar.delegate = self
        searchController.searchBar.showsBookmarkButton = true
        searchController.searchBar.setImage(UIImage(systemName: "line.3.horizontal.decrease.circle"), for: .bookmark, state: .normal)
        
        searchController.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.showsScopeBar = true
        searchController.automaticallyShowsCancelButton = true
        searchController.navigationItem.hidesSearchBarWhenScrolling = false
        searchController.ignoresSearchSuggestionsForSearchBarPlacementStacked = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        
        view.addSubview(gameCollectionView)
        
        configureConstraints()
        
        gameCollectionView.delegate = self
        gameCollectionView.dataSource = self
    }
    
    @objc private func addTapped(){
        print("Hello")
    }
    
    private func configureConstraints() {
        let gameCollectionViewConstraints = [
            gameCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            gameCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            gameCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            gameCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(gameCollectionViewConstraints)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCollectionViewCell.identifier, for: indexPath) as? GameCollectionViewCell else { return UICollectionViewCell()}
        
        return cell
    }
    
    
}
