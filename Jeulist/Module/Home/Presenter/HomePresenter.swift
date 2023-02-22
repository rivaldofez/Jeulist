//
//  HomePresenter.swift
//  Jeulist
//
//  Created by Rivaldo Fernandes on 20/02/23.
//

import UIKit
import RxSwift

protocol HomePresenterProtocol {
    var router: HomeRouterProtocol? { get set }
    var interactor: HomeUseCase? { get set }
    var view: HomeViewProtocol? { get set }

    var page: Int? { get set }
    var isLoadingData: Bool { get set }
    
    func getGameDataPagination(page: Int)
}

class HomePresenter: HomePresenterProtocol {
    var router: HomeRouterProtocol?
    
    var interactor: HomeUseCase?
    
    var view: HomeViewProtocol?
    
    private let disposeBag = DisposeBag()
    
    var page: Int?
    
    var isLoadingData = false {
        didSet {
            view?.isLoadingDataGameList(with: isLoadingData)
        }
    }
    
    func getGameDataPagination(page: Int){
        isLoadingData = true
        
        interactor?.getGameDataPagination(page: page)
            .observe(on: MainScheduler.instance)
            .subscribe{ [weak self] gameResult in
                self?.view?.updateGameList(with: gameResult)
            } onError: { error in
                self.view?.updateGameList(with: error.localizedDescription)
            } onCompleted: {
                self.isLoadingData = false
            }.disposed(by: disposeBag)
    }
   
}
