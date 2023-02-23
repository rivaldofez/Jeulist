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
        layout.itemSize = CGSize(width: view.frame.size.width, height: (view.frame.size.height / 3))
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
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var gamePlatformStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let aboutLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Lorem ipsum dolor sit amet que more la porte lu to senodo sique ament"
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var tagsStackView: UIStackView = {
        let stackView = createItemInformation(title: "Tags", content: "Multiplayer, SinglePlayer, Partial Support")
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()
    
    private lazy var websiteStackView: UIStackView = {
        let stackView = createItemInformation(title: "Website", content: "www.google.com")
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()
    
    private func createItemInformation(title: String, content: String) -> UIStackView {
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = .secondaryLabel
        titleLabel.font = .systemFont(ofSize: 14)
        
        let contentLabel = UILabel()
        contentLabel.text = content
        contentLabel.sizeToFit()
        contentLabel.font = .systemFont(ofSize: 16)
        contentLabel.textColor = .label
        contentLabel.numberOfLines = 0
        contentLabel.textAlignment = .left
        
        
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.addArrangedSubview(titleLabel)
        stackview.addArrangedSubview(contentLabel)
        stackview.spacing = 2
        stackview.distribution = .fillEqually
        stackview.alignment = .top
        
        return stackview
    }
    
    private func createRowInformation(firstTitle: String, firstContent: String, secondTitle: String, secondContent: String) -> UIStackView{
        
        let firstItem = createItemInformation(title: firstTitle, content: firstContent)
        let secondItem = createItemInformation(title: secondTitle, content: secondContent)
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(firstItem)
        stackView.addArrangedSubview(secondItem)
        
        return stackView
        
    }
    
    private lazy var informationStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .vertical
        stackview.distribution = .fillEqually
        stackview.spacing = 10
        
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
        view.addSubview(gamePlatformStackView)
        view.addSubview(tagsStackView)
        view.addSubview(aboutLabel)
        view.addSubview(websiteStackView)
        
        setParentPlatformIcon(parentPlatforms: ["PC", "Android"])
        
        imageSlidesCollectionView.delegate = self
        imageSlidesCollectionView.dataSource = self
        
        configureConstraints()
        self.navigationController?.isNavigationBarHidden = false
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
        
        informationStackView.addArrangedSubview(createRowInformation(firstTitle: "Platform", firstContent: "PC, Android, Mac, Windows", secondTitle: "Genre", secondContent: "Rock, Horro, RPG, Single"))
        
        informationStackView.addArrangedSubview(createRowInformation(firstTitle: "Release Data", firstContent: "11 Januari 2022", secondTitle: "Developer", secondContent: "Nexon Company, Nexon Korea"))
    }
    
    func setParentPlatformIcon(parentPlatforms: [String]){
        if gamePlatformStackView.subviews.isEmpty {
            parentPlatforms.forEach{ name in
                let image = UIImageView(image: UIImage(named: GameConverter.platformToIconName(input: name)))
                image.widthAnchor.constraint(equalToConstant: 30).isActive = true
                image.heightAnchor.constraint(equalToConstant: 30).isActive = true
                image.tintColor = .secondaryLabel
                gamePlatformStackView.addArrangedSubview(image)
            }
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
            
            self.imageSlidesCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            self.imageSlidesPageControl.currentPage = counter
        }
    }
    
    private func configureConstraints(){
        let imageSlidesCollectionViewConstraints = [
            imageSlidesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageSlidesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageSlidesCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            imageSlidesCollectionView.heightAnchor.constraint(equalToConstant: view.frame.size.height / 3)
        ]
        
        let imageSlidesPageControlConstraints = [
            imageSlidesPageControl.bottomAnchor.constraint(equalTo: imageSlidesCollectionView.bottomAnchor, constant: -10),
            imageSlidesPageControl.centerXAnchor.constraint(equalTo: imageSlidesCollectionView.centerXAnchor)
        ]
        
        let nameLabelConstraints = [
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nameLabel.topAnchor.constraint(equalTo: imageSlidesCollectionView.bottomAnchor, constant: 16)
        ]
        
        let gamePlatformStackViewConstraints = [
            gamePlatformStackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            gamePlatformStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        
        let tagsStackViewConstraints = [
            tagsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tagsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tagsStackView.topAnchor.constraint(equalTo: informationStackView.bottomAnchor, constant: 10)
        ]
        
        let aboutLabelConstraints = [
            aboutLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            aboutLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            aboutLabel.topAnchor.constraint(equalTo: gamePlatformStackView.bottomAnchor, constant:  16)
        ]
        
        let informationStackViewConstraints = [
            informationStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            informationStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            informationStackView.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor, constant: 8)
        ]
        
        let websiteStackViewConstraints = [
            websiteStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            websiteStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            websiteStackView.topAnchor.constraint(equalTo: tagsStackView.bottomAnchor, constant: 10)
        ]
        
        NSLayoutConstraint.activate(imageSlidesCollectionViewConstraints)
        NSLayoutConstraint.activate(imageSlidesPageControlConstraints)
        NSLayoutConstraint.activate(nameLabelConstraints)
        NSLayoutConstraint.activate(informationStackViewConstraints)
        NSLayoutConstraint.activate(gamePlatformStackViewConstraints)
        NSLayoutConstraint.activate(tagsStackViewConstraints)
        NSLayoutConstraint.activate(aboutLabelConstraints)
        NSLayoutConstraint.activate(websiteStackViewConstraints)
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
