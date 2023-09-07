//
//  UserLocaleDataSource.swift
//  Jeulist
//
//  Created by Rivaldo Fernandes on 08/09/23.
//

import UIKit
import RxSwift

protocol UserLocaleDataSourceProtocol: AnyObject {
    func getUserData() -> Observable<User?>
    func saveUserData(user: User) -> Observable<User?>
}

final class UserLocaleDataSource: NSObject, UserLocaleDataSourceProtocol {
    static let shared = UserLocaleDataSource()
    
    private let keyName = "Name"
    private let keyEmail = "Email"
    private let keyAvatar = "Avatar"
    
    let userdefault = UserDefaults.standard
    
    private func writeImage(image: UIImage) {
        let imagesDefaultUrl = URL(fileURLWithPath: "/images/")
        let imagesFolderUrl = try! FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: imagesDefaultUrl, create: true)
        
        let imageData = image.jpegData(compressionQuality: 0.5)
        let imageName = "user_image"
        let imageLocalUrl = imagesFolderUrl.appendingPathComponent(imageName)
        
        if let imageData = imageData {
            do {
                try imageData.write(to: imageLocalUrl)
            } catch {
                return
            }
        }
    }
    
    func getImage(imageName: String) -> UIImage {
        let imagesDefaultURL = URL(fileURLWithPath: "/images/")
        let imagesFolderUrl = try! FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: imagesDefaultURL, create: true)
        let imageUrl = imagesFolderUrl.appendingPathComponent(imageName)
        
        do {
            let imageData = try Data(contentsOf: imageUrl)
            if let imageResult = UIImage(data: imageData) {
                return imageResult
            }
        } catch {
            print("Not able to load image")
        }
        return UIImage(named: "profile")!
    }
    
    func getUserData() -> RxSwift.Observable<User?> {
        
        return Observable<User?>.create { observer in
            if let name = self.userdefault.string(forKey: self.keyName),
               let email = self.userdefault.string(forKey: self.keyEmail) {
                observer.onNext(User(name: name, email: email, avatar: self.getImage(imageName: "user_image")))
                observer.onCompleted()
            } else {
                observer.onNext(nil)
                observer.onCompleted()
            }
            
            return Disposables.create()
        }
    }
    
    func saveUserData(user: User) -> RxSwift.Observable<User?> {
        userdefault.set(user.name, forKey: keyName)
        userdefault.set(user.email, forKey: keyEmail)
        self.writeImage(image: user.avatar)
        
        return getUserData()
    }
}
