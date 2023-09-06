//
//  DetailGameViewController.swift
//  Jeulist
//
//  Created by Rivaldo Fernandes on 21/02/23.
//

import UIKit
import Lottie

protocol DetailGameViewProtocol {
    var presenter: DetailGamePresenterProtocol? { get set }
    func updateGameDetail(with gameDetail: GameDetail)
    func updateGameDetail(with error: String)
    
    func updateGameScreenshot(with screenshots: [String])
    func updateGameScreenshot(with error: String)
    
    func isLoadingData(with state: Bool)
    
    func updateSaveToggleFavorite(with error: String)
    func updateSaveToggleFavorite(with state: Bool)
}

class DetailGameViewController: UIViewController, DetailGameViewProtocol {
    var presenter: DetailGamePresenterProtocol?
    var gameDetail: GameDetail?
    private var screenshotImages: [String] = []
    
    var timer = Timer()
    var counter = 0
    
    // MARK: View Components
    // Main Scroll View
    private var mainScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    // Main Stack View
    private var mainScrollStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .center
        return stackView
    }()
    
    // Image Slide View
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
        
        return collectionview
    }()
    
    // Image Slide Page Control
    private let imageSlidesPageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = .red
        pageControl.pageIndicatorTintColor = .gray
        return pageControl
    }()
    
    // Name Label
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "High on Life"
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textAlignment = .center
        
        return label
    }()
    
    // Game Platform
    private lazy var gamePlatformStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // Detail Information View
    private lazy var aboutStackView: UIStackView = {
        let stackView = createItemInformation(title: "About", content: "Lorem ipsum dolor sit amet")
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var tagsStackView: UIStackView = {
        let stackView = createItemInformation(title: "Tags", content: "Lorem ipsum dolor sit amet")
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var websiteStackView: UIStackView = {
        let stackView = createItemInformation(title: "Website", content: "Lorem ipsum dolor sit amet")
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var informationStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .vertical
        stackview.distribution = .fillProportionally
        stackview.spacing = 16
        
        return stackview
    }()
    
    // Rating View
    private var ratingStackView: UIStackView = {
        
        let image = UIImageView(image: UIImage(named: "icon_rating"))
        image.widthAnchor.constraint(equalToConstant: 22).isActive = true
        image.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "10/10"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 4
        
        stackView.addArrangedSubview(image)
        stackView.addArrangedSubview(label)
        
        return stackView
        
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
        label.text = "Error occured while load pokemon data"
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
    
    func updateGameDetail(with gameDetail: GameDetail) {
        self.gameDetail = gameDetail
        nameLabel.text = gameDetail.name
        setParentPlatformIcon(parentPlatforms: gameDetail.parentPlatforms)
        
        informationStackView.addArrangedSubview(createRowInformation(firstTitle: "Platform", firstContent: gameDetail.parentPlatforms.joined(separator: ", "), secondTitle: "Genre", secondContent: gameDetail.genres))
        
        informationStackView.addArrangedSubview(createRowInformation(firstTitle: "Release Date", firstContent: gameDetail.released, secondTitle: "Developer", secondContent: gameDetail.developers))
        
        guard let aboutLabel = aboutStackView.subviews[1] as? UILabel else { return }
        aboutLabel.text = gameDetail.descriptionRaw
        
        guard let tagsLabel = tagsStackView.subviews[1] as? UILabel else { return }
        tagsLabel.text = gameDetail.tags
        
        guard let webLabel = websiteStackView.subviews[1] as? UILabel else { return }
        webLabel.text = gameDetail.website
        
        guard let ratingLabel = ratingStackView.subviews[1] as? UILabel else { return }
        ratingLabel.text = "\(gameDetail.rating) / 5.0"
        
        showFavoriteButton(isFavorite: gameDetail.isFavorite)
    }
    
    func updateGameScreenshot(with screenshots: [String]) {
        screenshotImages.append(contentsOf: screenshots)
        self.imageSlidesPageControl.numberOfPages = screenshots.count
        DispatchQueue.main.async {
            self.imageSlidesCollectionView.reloadData()
        }
    }
    
    func updateGameScreenshot(with error: String) {
        showError(isError: true)
    }
    
    func updateGameDetail(with error: String) {
        showError(isError: true)
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
    
    private func showError(isError: Bool) {
        UIView.transition(with: errorStackView, duration: 0.4, options: .transitionCrossDissolve) {
            self.errorStackView.isHidden = !isError
        }
        
        UIView.transition(with: mainScrollView, duration: 0.4, options: .transitionCrossDissolve) {
            self.mainScrollView.isHidden = isError
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = false
        
        view.addSubview(mainScrollView)
        view.addSubview(errorStackView)
        view.addSubview(backdropLoading)
        view.addSubview(loadingAnimation)
        mainScrollView.addSubview(mainScrollStackView)
        
        mainScrollStackView.addArrangedSubview(imageSlidesCollectionView)
        mainScrollStackView.addArrangedSubview(imageSlidesPageControl)
        mainScrollStackView.addArrangedSubview(nameLabel)
        mainScrollStackView.addArrangedSubview(gamePlatformStackView)
        mainScrollStackView.addArrangedSubview(ratingStackView)
        mainScrollStackView.addArrangedSubview(aboutStackView)
        mainScrollStackView.addArrangedSubview(informationStackView)
        mainScrollStackView.addArrangedSubview(tagsStackView)
        mainScrollStackView.addArrangedSubview(websiteStackView)
        
        imageSlidesCollectionView.delegate = self
        imageSlidesCollectionView.dataSource = self
        
        configureConstraints()
        self.navigationController?.isNavigationBarHidden = false
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
    }
    
    func setParentPlatformIcon(parentPlatforms: [String]) {
        if gamePlatformStackView.subviews.isEmpty {
            parentPlatforms.forEach { name in
                let image = UIImageView(image: UIImage(named: GameConverter.platformToIconName(input: name)))
                image.widthAnchor.constraint(equalToConstant: 30).isActive = true
                image.heightAnchor.constraint(equalToConstant: 30).isActive = true
                image.tintColor = .secondaryLabel
                gamePlatformStackView.addArrangedSubview(image)
            }
        }
    }
    
    @objc private func changeImage() {
        if !screenshotImages.isEmpty {
            if counter < screenshotImages.count {
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
    }
    
    private func configureConstraints() {
        
        let mainScrollViewConstraints = [
            mainScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainScrollView.topAnchor.constraint(equalTo: view.topAnchor),
            mainScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        let mainScrollStackViewConstraints = [
            mainScrollStackView.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor),
            mainScrollStackView.trailingAnchor.constraint(equalTo: mainScrollView.trailingAnchor),
            mainScrollStackView.topAnchor.constraint(equalTo: mainScrollView.topAnchor),
            mainScrollStackView.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor),
            mainScrollStackView.widthAnchor.constraint(equalTo: mainScrollView.widthAnchor)
        ]
        
        let imageSlidesCollectionViewConstraints = [
            imageSlidesCollectionView.leadingAnchor.constraint(equalTo: mainScrollStackView.leadingAnchor),
            imageSlidesCollectionView.trailingAnchor.constraint(equalTo: mainScrollStackView.trailingAnchor),
            imageSlidesCollectionView.topAnchor.constraint(equalTo: mainScrollStackView.safeAreaLayoutGuide.topAnchor),
            imageSlidesCollectionView.heightAnchor.constraint(equalToConstant: view.frame.size.height / 3)
        ]
        
        let imageSlidesPageControlConstraints = [
            imageSlidesPageControl.bottomAnchor.constraint(equalTo: imageSlidesCollectionView.bottomAnchor, constant: -10),
            imageSlidesPageControl.centerXAnchor.constraint(equalTo: imageSlidesCollectionView.centerXAnchor)
        ]
        
        let nameLabelConstraints = [
            nameLabel.leadingAnchor.constraint(equalTo: mainScrollStackView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: mainScrollStackView.trailingAnchor)
        ]
        
        let gamePlatformStackViewConstraints = [
            gamePlatformStackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4)
        ]
        
        let ratingStackViewConstraints = [
            ratingStackView.topAnchor.constraint(equalTo: gamePlatformStackView.bottomAnchor, constant: 4)
        ]
        
        let tagsStackViewConstraints = [
            tagsStackView.leadingAnchor.constraint(equalTo: mainScrollStackView.leadingAnchor, constant: 8),
            tagsStackView.trailingAnchor.constraint(equalTo: mainScrollStackView.trailingAnchor, constant: -8)
        ]
        
        let aboutLabelConstraints = [
            aboutStackView.leadingAnchor.constraint(equalTo: mainScrollStackView.leadingAnchor, constant: 8),
            aboutStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        ]
        
        let informationStackViewConstraints = [
            informationStackView.leadingAnchor.constraint(equalTo: mainScrollStackView.leadingAnchor, constant: 8),
            informationStackView.trailingAnchor.constraint(equalTo: mainScrollStackView.trailingAnchor, constant: -8)
        ]
        
        let websiteStackViewConstraints = [
            websiteStackView.leadingAnchor.constraint(equalTo: mainScrollStackView.leadingAnchor, constant: 8),
            websiteStackView.trailingAnchor.constraint(equalTo: mainScrollStackView.trailingAnchor, constant: -8)
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
        NSLayoutConstraint.activate(mainScrollStackViewConstraints)
        NSLayoutConstraint.activate(mainScrollViewConstraints)
        NSLayoutConstraint.activate(imageSlidesCollectionViewConstraints)
        NSLayoutConstraint.activate(imageSlidesPageControlConstraints)
        NSLayoutConstraint.activate(nameLabelConstraints)
        NSLayoutConstraint.activate(gamePlatformStackViewConstraints)
        NSLayoutConstraint.activate(ratingStackViewConstraints)
        NSLayoutConstraint.activate(informationStackViewConstraints)
        NSLayoutConstraint.activate(tagsStackViewConstraints)
        NSLayoutConstraint.activate(aboutLabelConstraints)
        NSLayoutConstraint.activate(websiteStackViewConstraints)
    }
    
    private func showFavoriteButton(isFavorite: Bool) {
        if self.navigationItem.rightBarButtonItem == nil {
            let button = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(favoriteAction))
            
            if isFavorite {
                button.image = UIImage(systemName: "heart.fill")
                button.tintColor = UIColor.red
            } else {
                button.image = UIImage(systemName: "heart")
                button.tintColor = UIColor.gray
            }
            
            navigationItem.rightBarButtonItem = button
            
        } else {
            if isFavorite {
                self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart.fill")
                self.navigationItem.rightBarButtonItem?.tintColor = UIColor.red
            } else {
                self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart")
                self.navigationItem.rightBarButtonItem?.tintColor = UIColor.gray
            }
        }
    }
    
    @objc private func favoriteAction() {
        gameDetail?.isFavorite.toggle()
        if let gameDetail = self.gameDetail {
            showFavoriteButton(isFavorite: gameDetail.isFavorite)
            presenter?.saveToggleFavorite(gameDetail: gameDetail)
        }
    }
    
    private func showToggleFavoriteAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
    func updateSaveToggleFavorite(with error: String) {
        showToggleFavoriteAlert(title: "An Error Occured", message: "Oops, cannot process your due to system error, please try again")
    }
    
    func updateSaveToggleFavorite(with state: Bool) {
        if state {
            showToggleFavoriteAlert(title: "Added To Favorite", message: "This game successfully added to your favorite list")
        } else {
            showToggleFavoriteAlert(title: "Removed From Favorite", message: "This game successfully removed from your favorite list")
        }
    }
    
    private func createItemInformation(title: String, content: String) -> UIStackView {
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = .secondaryLabel
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        
        let contentLabel = UILabel()
        contentLabel.text = content
        contentLabel.sizeToFit()
        contentLabel.font = .systemFont(ofSize: 16)
        contentLabel.textColor = .label
        contentLabel.numberOfLines = 0
        contentLabel.textAlignment = .justified
        
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.addArrangedSubview(titleLabel)
        stackview.addArrangedSubview(contentLabel)
        stackview.distribution = .equalSpacing
        stackview.alignment = .leading
        stackview.spacing = 4
        
        return stackview
    }
    
    private func createRowInformation(firstTitle: String, firstContent: String, secondTitle: String, secondContent: String) -> UIStackView {
        
        let firstItem = createItemInformation(title: firstTitle, content: firstContent)
        let secondItem = createItemInformation(title: secondTitle, content: secondContent)
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .top
        stackView.spacing = 8
        stackView.addArrangedSubview(firstItem)
        stackView.addArrangedSubview(secondItem)
        
        return stackView
    }
    
}

extension DetailGameViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return screenshotImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageSlidesCollectionViewCell.identifier, for: indexPath) as? ImageSlidesCollectionViewCell else { return UICollectionViewCell()}
        
        cell.configure(with: screenshotImages[indexPath.item])
        
        return cell
    }
}
