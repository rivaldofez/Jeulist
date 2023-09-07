//
//  Injection.swift
//  Jeulist
//
//  Created by Rivaldo Fernandes on 22/02/23.
//

import Foundation

final class Injection: NSObject {
    private func provideRepository() -> GameRepositoryProtocol {
        let remote: RemoteDataSource = RemoteDataSource.shared
        let locale: LocaleDataSource = LocaleDataSource.shared
        
        return GameRepository.sharedInstance(remote, locale)
    }
    
    private func provideUserDataRepository() -> UserDataRepositoryProtocol {
        let userLocale: UserLocaleDataSource = UserLocaleDataSource.shared
        return UserDataRepository.sharedInstance(userLocale)
    }
    
    func provideProfile() -> ProfileUseCase {
        let repository = provideUserDataRepository()
        return ProfileInteractor(repository: repository)
    }
    
    func provideHome() -> HomeUseCase {
        let repository = provideRepository()
        return HomeInteractor(repository: repository)
    }
    
    func provideDetail() -> DetailGameUseCase {
        let repository = provideRepository()
        return DetailGameInteractor(repository: repository)
    }
    
    func provideFavorite() -> FavoriteGameUseCase {
        let repository = provideRepository()
        return FavoriteGameInteractor(repository: repository)
    }
}
