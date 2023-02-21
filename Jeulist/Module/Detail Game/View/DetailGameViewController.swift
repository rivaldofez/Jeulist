//
//  DetailGameViewController.swift
//  Jeulist
//
//  Created by Rivaldo Fernandes on 21/02/23.
//

import UIKit

class DetailGameViewController: UIViewController {

    
    var imgArr = [
        UIImage(named: "testimage"),
        UIImage(named: "testimage2")
    ]
    
    private lazy var imageSlidesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: view.frame.size.width, height: 150)
        
        
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.register(ImageSlidesCollectionViewCell.self, forCellWithReuseIdentifier: ImageSlidesCollectionViewCell.identifier)
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionview
    }()
    
    private let imageSlidesPageControl: UIPageControl = {
       let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        return pageControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        view.addSubview(imageSlidesCollectionView)
        view.addSubview(imageSlidesPageControl)
        
        configureConstraints()
    }
    
    private func configureConstraints(){
        let imageSlidesCollectionViewConstraints = [
            imageSlidesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageSlidesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageSlidesCollectionView.topAnchor.constraint(equalTo: view.topAnchor)
        ]
        
        let imageSlidesPageControlConstraints = [
            imageSlidesPageControl.bottomAnchor.constraint(equalTo: imageSlidesCollectionView.bottomAnchor, constant: -10),
            imageSlidesPageControl.centerXAnchor.constraint(equalTo: imageSlidesCollectionView.centerXAnchor)
        ]
        
        
        NSLayoutConstraint.activate(imageSlidesCollectionViewConstraints)
        NSLayoutConstraint.activate(imageSlidesPageControlConstraints)
    }

}
