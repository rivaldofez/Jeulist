//
//  HomeViewController.swift
//  Jeulist
//
//  Created by Rivaldo Fernandes on 18/02/23.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController {
    
    
    private lazy var gameCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: 60, height: 60)
        
        
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.register(GameCollectionViewCell.self, forCellWithReuseIdentifier: GameCollectionViewCell.identifier)
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        view.addSubview(gameCollectionView)
        
        configureConstraints()
        
        gameCollectionView.delegate = self
        gameCollectionView.dataSource = self
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


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCollectionViewCell.identifier, for: indexPath) as? GameCollectionViewCell else { return UICollectionViewCell()}
        
        return cell
    }
    
    
}
