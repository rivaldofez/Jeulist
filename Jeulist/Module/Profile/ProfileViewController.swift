//
//  ProfileViewController.swift
//  Jeulist
//
//  Created by Rivaldo Fernandes on 31/08/23.
//

import UIKit

protocol ProfileViewProtocol {
    var presenter: ProfilePresenterProtocol? { get set }
    func updateUserData(with user: User?)
    func updateUserData(with error: String)
}

class ProfileViewController: UIViewController, ProfileViewProtocol {
    
    func updateUserData(with user: User?) {
        if let user = user {
            nameField.text = user.name
            emailField.text = user.email
            profileImageView.image = user.avatar
        }
    }
    
    func updateUserData(with error: String) {}
    var presenter: ProfilePresenterProtocol?
    
    private let profileImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "profile")
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.widthAnchor.constraint(equalToConstant: 200).isActive = true
        imageview.heightAnchor.constraint(equalToConstant: 200).isActive = true
        imageview.contentMode = .scaleAspectFill
        imageview.layer.cornerRadius = 200/2
        imageview.layer.masksToBounds = false
        imageview.clipsToBounds = true
        imageview.isUserInteractionEnabled = true
        return imageview
    }()
    
    private let nameField: UITextField = {
        let label = UITextField()
        label.text = "Rivaldo Fernandes"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .label
        
        return label
    }()
    
    private let emailField: UITextField = {
        let label = UITextField()
        label.text = "rivaldofez@gmail.com"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    private lazy var profileStackView: UIStackView = {
        let stackview = UIStackView(arrangedSubviews: [ profileImageView, nameField, emailField])
        stackview.axis = .vertical
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.alignment = .center
        stackview.spacing = 16
        return stackview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        showEditButton(isEditing: false)
        
        title = "Profile"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .label
        
        view.addSubview(profileStackView)
        configureConstraints()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        profileImageView.addGestureRecognizer(gesture)
        
    }
    
    private func configureConstraints() {
        let profileStackViewConstraints = [
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            
        ]
        NSLayoutConstraint.activate(profileStackViewConstraints)
    }
    
    private func showEditButton(isEditing: Bool) {
        if self.navigationItem.rightBarButtonItem == nil {
            let button = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"), style: .plain, target: self, action: #selector(editProfile))
            navigationItem.rightBarButtonItem = button
        }
        if isEditing {
            self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "checkmark")
            self.navigationItem.rightBarButtonItem?.tintColor = UIColor.blue
        } else {
            self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "square.and.pencil")
            self.navigationItem.rightBarButtonItem?.tintColor = UIColor.gray
        }
        nameField.isUserInteractionEnabled = isEditing
        emailField.isUserInteractionEnabled = isEditing
        profileImageView.isUserInteractionEnabled = isEditing
    }
    
    @objc private func editProfile() {
        if isEditing {
            if let name = nameField.text, let email = emailField.text, let avatar = profileImageView.image {
                presenter?.saveUserData(user: User(name: name, email: email, avatar: avatar))
            }
        }
        isEditing.toggle()
        showEditButton(isEditing: isEditing)
    }
    
    @objc private func selectImage(sender: UITapGestureRecognizer) {
        showImagePicker()
    }
    
    func showImagePicker() {
        let alertVC = UIAlertController(title: "Pick a Photo", message: "Choose Picture from Gallery", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { [weak self] _ in
            guard let self = self else { return }
            let cameraImagePicker = self.imagePicker(sourceType: .camera)
            cameraImagePicker.delegate = self
            self.present(cameraImagePicker, animated: true)
        }
        
        let libraryAction = UIAlertAction(title: "Library", style: .default) { [weak self] _ in
            guard let self = self else { return }
            let libraryImagePicker = self.imagePicker(sourceType: .photoLibrary)
            libraryImagePicker.delegate = self
            self.present(libraryImagePicker, animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertVC.addAction(cameraAction)
        alertVC.addAction(libraryAction)
        alertVC.addAction(cancelAction)
        self.present(alertVC, animated: true)
    }
    
    func imagePicker(sourceType: UIImagePickerController.SourceType) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        return imagePicker
    }
    
    func getImage(imageUrl: String) -> UIImage {
        let imagesDefaultURL = URL(fileURLWithPath: "/images/")
        let imagesFolderUrl = try! FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: imagesDefaultURL, create: true)
        let imageUrl = imagesFolderUrl.appendingPathComponent(imageUrl)
        
        do {
            let imageData = try Data(contentsOf: imageUrl)
            
            if let imageResult = UIImage(data: imageData) {
                return imageResult
            }
        } catch {
            print("Not able to load image")
        }
        return UIImage(systemName: "exclamationmark.triangle.fill")!
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        presenter?.getUserData()
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        self.profileImageView.image = image
        self.dismiss(animated: true)
    }
}
