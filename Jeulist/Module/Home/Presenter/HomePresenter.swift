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

    var page: Int { get set }
    var searchQuery: String { get set }
    var isLoadingData: Bool { get set }
    
    func getGameDataPagination(pageSize: Int, page: Int, search: String)
    func didSelectGameItem(with gameId: Int)
}

class HomePresenter: HomePresenterProtocol {
    var router: HomeRouterProtocol?
    
    var view: HomeViewProtocol?
    
    var interactor: HomeUseCase? {
        didSet {
            page = 1
        }
    }
    
    private let disposeBag = DisposeBag()
    
    var page: Int = 1 {
        didSet {
            getGameDataPagination(pageSize: pageSize, page: page, search: searchQuery)
        }
    }
    
    var isLoadingData = false {
        didSet {
            view?.isLoadingDataGameList(with: isLoadingData)
        }
    }
    
    var searchQuery: String = "" {
        didSet {
            page = 1
//            getGameDataPagination(pageSize: pageSize, page: page, search: searchQuery)
        }
    }
    
    var pageSize: Int = 50
    
    func getGameDataPagination(pageSize: Int, page: Int, search: String){
        isLoadingData = true
        
        interactor?.getGameDataPagination(pageSize: pageSize, page: page, search: search)
            .observe(on: MainScheduler.instance)
            .subscribe{ [weak self] gameResult in
                self?.view?.updateGameList(with: gameResult)
            } onError: { error in
                self.view?.updateGameList(with: error.localizedDescription)
            } onCompleted: {
                self.isLoadingData = false
            }.disposed(by: disposeBag)
    }
    
    func didSelectGameItem(with gameId: Int) {
        router?.goToDetailGame(with: gameId)
    }
   
}
