//
//  UserDataRepository.swift
//  Jeulist
//
//  Created by Rivaldo Fernandes on 08/09/23.
//

import Foundation
import RxSwift

protocol UserDataRepositoryProtocol {
    func getUserData() -> Observable<User?>
    func saveUserData(user: User) -> Observable<User?>
}

final class UserDataRepository: NSObject {
    typealias UserDataRepositoryInstance = (UserLocaleDataSource) -> UserDataRepository
    
    fileprivate let locale: UserLocaleDataSource
    
    private init(locale: UserLocaleDataSource) {
        self.locale = locale
    }
    
    static let sharedInstance: UserDataRepositoryInstance = { userDataLocale in
        return UserDataRepository(locale: userDataLocale)
    }
}

extension UserDataRepository: UserDataRepositoryProtocol {
    func getUserData() -> Observable<User?> {
        return self.locale.getUserData()
    }
    
    func saveUserData(user: User) -> Observable<User?> {
        return self.locale.saveUserData(user: user)
    }
    
}
