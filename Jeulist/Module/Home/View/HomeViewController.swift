//
//  HomeViewController.swift
//  Jeulist
//
//  Created by Rivaldo Fernandes on 18/02/23.
//

import UIKit
import RxSwift


class SearchTest: UISearchController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    }
    
    @objc private func addTapped(){
        print("Hello")
    }
    
}


class PopoverViewController: UIViewController {
    
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("Change", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        self.view.backgroundColor = .systemGray
        self.preferredContentSize = CGSize(width: 100, height: 100)
        
        
        view.addSubview(button)
        let buttonConstraints = [
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        
        ]
        
        button.addTarget(self, action: #selector(changeValue), for: .touchUpInside)
        
        
        
        NSLayoutConstraint.activate(buttonConstraints)
        
    }
    
    @objc private func changeValue(){
        print("ini dari popover: Ini sudah diganti")
        
        dismiss(animated: true)
    }
}

extension HomeViewController: UISearchControllerDelegate {
    func searchController(_ searchController: UISearchController, willChangeTo newPlacement: UINavigationItem.SearchBarPlacement) {
        print("will change to")
    }
    
    func searchController(_ searchController: UISearchController, didChangeFrom previousPlacement: UINavigationItem.SearchBarPlacement) {
        print("did change from")
    }
}

class HomeViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
    
    
    let searchController = SearchTest()
    
    private lazy var gameCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: ((view.frame.size.width) / 2) - 5, height: (view.frame.size.width) / 2)
        
        
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.register(GameCollectionViewCell.self, forCellWithReuseIdentifier: GameCollectionViewCell.identifier)
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionview
    }()
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        let popoverVC = PopoverViewController()
        popoverVC.modalPresentationStyle = .popover
        popoverVC.popoverPresentationController?.sourceView = searchBar
        popoverVC.popoverPresentationController?.permittedArrowDirections = .any
        popoverVC.popoverPresentationController?.delegate = self
        self.present(popoverVC, animated: true, completion: nil)
        print("clicked")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Pokémon"
        navigationController?.navigationBar.tintColor = .label
        view.backgroundColor = .systemBackground
        
        
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        searchController.searchBar.showsBookmarkButton = true
        searchController.searchBar.setImage(UIImage(systemName: "line.3.horizontal.decrease.circle"), for: .bookmark, state: .normal)
        
        searchController.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.showsScopeBar = true
        searchController.automaticallyShowsCancelButton = true
        searchController.navigationItem.hidesSearchBarWhenScrolling = false
        searchController.ignoresSearchSuggestionsForSearchBarPlacementStacked = true
//        searchController.searchBar.scopeButtonTitles = [
//            "Hello",
//            "World"
//        ]
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        
//        navigationItem.hidesSearchBarWhenScrolling = false
        
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))
        
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
            gameCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gameCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gameCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            gameCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(gameCollectionViewConstraints)
    }
}

extension HomeViewController: UISearchBarDelegate {
    
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
