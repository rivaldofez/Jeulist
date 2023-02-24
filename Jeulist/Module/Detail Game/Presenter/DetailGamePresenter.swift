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
    var isLoadingScreenshot: Bool { get set }
    func getGameDetail(id: Int)
    func setGameid(id: Int)
}

class DetailGamePresenter: DetailGamePresenterProtocol {
    
    var router: DetailGameRouterProtocol?
    
    var interactor: DetailGameUseCase?
    
    var view: DetailGameViewProtocol?
    private var gameId: Int? {
        didSet {
            guard let gameId = gameId else { return }
            getGameDetail(id: gameId)
            getGameScreenshot(id: gameId)
        }
    }
    
    private let disposeBag = DisposeBag()
    
    var isLoadingdata: Bool = false
    var isLoadingScreenshot: Bool = false
    
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
    
    func getGameScreenshot(id: Int) {
        isLoadingScreenshot = true
        
        interactor?.getGameScreenshot(id: id)
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] screenshots in
                self?.view?.updateGameScreenshot(with: screenshots)
            } onError: { error in
                self.view?.updateGameScreenshot(with: error.localizedDescription)
            } onCompleted: {
                self.isLoadingScreenshot = false
            }.disposed(by: disposeBag)
        
    }
}
