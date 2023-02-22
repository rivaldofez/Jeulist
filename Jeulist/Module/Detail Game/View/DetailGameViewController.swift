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
        collectionview.layer.cornerRadius = 10
        
        
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
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "High on Life"
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center
        
        return label
    }()
    
    private let platformItem: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Windows, Apple"
        
        return label
    }()
    
    private let aboutLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Lorem ipsum dolor sit amet que more la porte lu to senodo sique ament"
        
        return label
    }()
    
    private let tagLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Single Player dll"
        
        return label
    }()
    
    private let informationStackView: UIStackView = {
        let labelplatform = UILabel()
        labelplatform.text = "Platforms"
        let labelcontentplatform = UILabel()
        labelcontentplatform.text = "PS1, PS2, PS3, PS4, XBOX, Mac, PC"
        labelcontentplatform.numberOfLines = 0
        let stackviewplatform = UIStackView()
        stackviewplatform.axis = .vertical
        stackviewplatform.addArrangedSubview(labelplatform)
        stackviewplatform.addArrangedSubview(labelcontentplatform)
        
        let labelgenre = UILabel()
        labelgenre.text = "Genre"
        let labelcontentgenre = UILabel()
        labelcontentgenre.text = "Action, RPG, Fantasy, Horror"
        let stackviewgenre = UIStackView()
        stackviewgenre.axis = .vertical
        stackviewgenre.addArrangedSubview(labelgenre)
        stackviewgenre.addArrangedSubview(labelcontentgenre)
        
        
        let stackviewrow1 = UIStackView()
        stackviewrow1.addArrangedSubview(stackviewplatform)
        stackviewrow1.addArrangedSubview(stackviewgenre)
        stackviewrow1.axis = .horizontal
        stackviewrow1.distribution = .fillEqually
        
        
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.addArrangedSubview(stackviewrow1)
        stackview.axis = .vertical
        
        return stackview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
//        navigationController?.navigationBar.prefersLargeTitles = true
//        title = "GTA V"
//        navigationController?.navigationBar.tintColor = .label
//        view.backgroundColor = .systemBackground
        
//        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(imageSlidesCollectionView)
        view.addSubview(imageSlidesPageControl)
        view.addSubview(nameLabel)
        view.addSubview(informationStackView)
        view.addSubview(platformItem)
        view.addSubview(tagLabel)
        view.addSubview(aboutLabel)
        
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
            self.imageSlidesPageControl.currentPage = counter
            counter += 1
        } else {
            counter = 0
            let index = IndexPath(item: counter, section: 0)
            
            self.imageSlidesCollectionView.scrollToItem(at: index, at: .centeredVertically, animated: true)
            self.imageSlidesPageControl.currentPage = counter

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
        
        let nameLabelConstraints = [
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nameLabel.topAnchor.constraint(equalTo: imageSlidesCollectionView.bottomAnchor)
        ]
        
        let informationStackViewConstraints = [
            informationStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            informationStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            informationStackView.topAnchor.constraint(equalTo: platformItem.bottomAnchor)
        ]
        
        let platformItemConstraints = [
            platformItem.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            platformItem.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            platformItem.topAnchor.constraint(equalTo: nameLabel.bottomAnchor)
        ]
        
        let tagLabelConstraints = [
            tagLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tagLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tagLabel.topAnchor.constraint(equalTo: informationStackView.bottomAnchor)
        ]
        
        let aboutLabelConstraints = [
            aboutLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            aboutLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            aboutLabel.topAnchor.constraint(equalTo: tagLabel.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(imageSlidesCollectionViewConstraints)
        NSLayoutConstraint.activate(imageSlidesPageControlConstraints)
        NSLayoutConstraint.activate(nameLabelConstraints)
        NSLayoutConstraint.activate(informationStackViewConstraints)
        NSLayoutConstraint.activate(platformItemConstraints)
        NSLayoutConstraint.activate(tagLabelConstraints)
        NSLayoutConstraint.activate(aboutLabelConstraints)
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
