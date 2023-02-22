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
        
        return GameRepository.sharedInstance(remote)
    }
    
    func provideHome() -> HomeUseCase {
        let repository = provideRepository()
        return HomeInteractor(repository: repository)
    }
}
