//
//  DetailGamePresenter.swift
//  Jeulist
//
//  Created by Rivaldo Fernandes on 23/02/23.
//

import Foundation
import RxSwift

protocol DetailGamePresenterProtocol {
    var router: DetailGameRouterProtocol? { get set }
    var interactor: DetailGameUseCase? { get set }
    var view: DetailGameViewProtocol? { get set }
    
    var isLoadingdata: Bool { get set }
    func getGameDetail(id: Int)
    func setGameid(id: Int)
}

class DetailGamePresenter: DetailGamePresenterProtocol {
    
    var router: DetailGameRouterProtocol?
    
    var interactor: DetailGameUseCase?
    
    var view: DetailGameViewProtocol?
    var gameId: Int?
    
    private let disposeBag = DisposeBag()
    
    var isLoadingdata: Bool = false
    
    func setGameid(id: Int) {
        self.gameId = id
    }
    
    func getGameDetail(id: Int) {
        isLoadingdata = true
        
        interactor?.getGameDetail(id: id)
            .observe(on: MainScheduler.instance)
            .subscribe{ [weak self] gameDetailResult in
                self?.view?.updateGameDetail(with: gameDetailResult)
            } onError: { error in
                self.view?.updateGameDetail(with: error.localizedDescription)
            } onCompleted: {
                self.isLoadingdata = false
            }.disposed(by: disposeBag)
    }
}
