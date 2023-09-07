//
//  ProfileInteractor.swift
//  Jeulist
//
//  Created by Rivaldo Fernandes on 08/09/23.
//

import Foundation
import RxSwift

protocol ProfileUseCase {
    func getUserData() -> Observable<User?>
    func saveUserData(user: User) -> Observable<User?>
}

class ProfileInteractor: ProfileUseCase {
    
    private let userDataRepository: UserDataRepositoryProtocol
    
    required init(repository: UserDataRepositoryProtocol) {
        self.userDataRepository = repository
    }
    
    func getUserData() -> Observable<User?> {
        return userDataRepository.getUserData()
    }
    
    func saveUserData(user: User) -> Observable<User?> {
        return userDataRepository.saveUserData(user: user)
    }
}
