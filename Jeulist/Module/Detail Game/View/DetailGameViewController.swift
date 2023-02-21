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
    
    var timer = Timer()
    var counter = 0
    
    private lazy var imageSlidesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: view.frame.size.width, height: 300)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        
        
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.register(ImageSlidesCollectionViewCell.self, forCellWithReuseIdentifier: ImageSlidesCollectionViewCell.identifier)
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        collectionview.isPagingEnabled = true
        collectionview.showsVerticalScrollIndicator = false
        collectionview.showsHorizontalScrollIndicator = false
        collectionview.alwaysBounceVertical = false
        collectionview.alwaysBounceHorizontal = false
        collectionview.clipsToBounds = true
        collectionview.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionview.automaticallyAdjustsScrollIndicatorInsets = false
        
        collectionview.contentInsetAdjustmentBehavior = .never
        
        
        return collectionview
    }()
    
    private let imageSlidesPageControl: UIPageControl = {
       let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPage = 0
        pageControl.numberOfPages = 2
        pageControl.currentPageIndicatorTintColor = .red
        pageControl.pageIndicatorTintColor = .gray
        return pageControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
//        navigationController?.navigationBar.prefersLargeTitles = true
//        title = "GTA V"
//        navigationController?.navigationBar.tintColor = .label
//        view.backgroundColor = .systemBackground
        
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(imageSlidesCollectionView)
        view.addSubview(imageSlidesPageControl)
        
        imageSlidesCollectionView.delegate = self
        imageSlidesCollectionView.dataSource = self
//        self.navigationController?.hidesBarsOnSwipe = true
//        self.navigationController?.hidesBarsOnTap = true
        
        configureConstraints()
        self.navigationController?.isNavigationBarHidden = false
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
        
        
    }
    
    @objc private func changeImage(){
        if counter < imgArr.count {
            let index = IndexPath(item: counter, section: 0)
            
            self.imageSlidesCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            counter += 1
            
            print(counter)
        } else {
            counter = 0
            let index = IndexPath(item: counter, section: 0)
            
            self.imageSlidesCollectionView.scrollToItem(at: index, at: .centeredVertically, animated: true)
            
            print(counter)
        }
    }
    
    private func configureConstraints(){
        let imageSlidesCollectionViewConstraints = [
            imageSlidesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageSlidesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageSlidesCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            imageSlidesCollectionView.heightAnchor.constraint(equalToConstant: 300)
        ]
        
        let imageSlidesPageControlConstraints = [
            imageSlidesPageControl.bottomAnchor.constraint(equalTo: imageSlidesCollectionView.bottomAnchor, constant: -10),
            imageSlidesPageControl.centerXAnchor.constraint(equalTo: imageSlidesCollectionView.centerXAnchor)
        ]
        
        
        NSLayoutConstraint.activate(imageSlidesCollectionViewConstraints)
        NSLayoutConstraint.activate(imageSlidesPageControlConstraints)
    }

}

extension DetailGameViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageSlidesCollectionViewCell.identifier, for: indexPath) as? ImageSlidesCollectionViewCell else { return UICollectionViewCell()}
        
        return cell
    }
    
    
}
