//
//  Injection.swift
//  Jeulist
//
//  Created by Rivaldo Fernandes on 22/02/23.
//

import Foundation

final class Injection: NSObject {
    private func provideRepository() -> GameRepositoryProtocol {
        let remote: RemoteDataSource = RemoteDataSource.sharedInstance
        let locale: LocaleDataSource = LocaleDataSource.shared
        
        return GameRepository.sharedInstance(remote, locale)
    }
    
    func provideHome() -> HomeUseCase {
        let repository = provideRepository()
        return HomeInteractor(repository: repository)
    }
    
    func provideDetail() -> DetailGameUseCase {
        let repository = provideRepository()
        return DetailGameInteractor(repository: repository)
    }
}
