//
//  FavoriteGamePresenter.swift
//  Jeulist
//
//  Created by Rivaldo Fernandes on 01/09/23.
//

import Foundation
import RxSwift

protocol FavoriteGamePresenterProtocol {
    var router: FavoriteGameRouterProtocol? { get set }
    var interactor: FavoriteGameUseCase? { get set }
    var view: FavoriteGameViewProtocol? { get set }
    
    var isLoadingData: Bool { get set }
    func getFavoriteGameList()
    func didSelectGame(with gameDetail: GameDetail)
    func saveToggleFavorite(gameDetail: GameDetail)
}

class FavoriteGamePresenter: FavoriteGamePresenterProtocol {
    private let disposeBag = DisposeBag()
    
    var isLoadingData: Bool = false {
        didSet {
            view?.isLoadingData(with: isLoadingData)
        }
    }
    
    func getFavoriteGameList() {
        isLoadingData = true
        interactor?.getFavoriteGameList()
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] gameResults in
                self?.view?.updateGameFavoriteList(with: gameResults)
            } onError: { error in
                self.view?.updateGameFavoriteList(with: error.localizedDescription)
            } onCompleted: {
                self.isLoadingData = false
            }.disposed(by: disposeBag)
    }
    
    func didSelectGame(with gameDetail: GameDetail) {
        router?.gotoDetailGame(with: gameDetail.id)
    }
    
    func saveToggleFavorite(gameDetail: GameDetail) {
        interactor?.saveToggleFavoriteGame(gameDetail: gameDetail)
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] result in
                self?.view?.updateSaveToggleFavorite(with: result)
            } onError: { error in
                self.view?.updateSaveToggleFavorite(with: error.localizedDescription)
            } onCompleted: {
                self.isLoadingData = false
            }.disposed(by: disposeBag)
    }
    
    var router: FavoriteGameRouterProtocol?
    
    var interactor: FavoriteGameUseCase? {
        didSet {
            getFavoriteGameList()
        }
    }
    
    var view: FavoriteGameViewProtocol?
    
    
    
}
