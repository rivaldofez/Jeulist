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

    var pageSize: Int { get set }
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
            getGameDataDebounce.call()
        }
    }
    
    var pageSize: Int = 50
    
    private lazy var getGameDataDebounce = Debouncer(delay: 0.3) {
        self.getGameDataPagination(pageSize: self.pageSize, page: self.page, search: self.searchQuery)
    }

    func getGameDataPagination(pageSize: Int, page: Int, search: String){
        isLoadingData = true
        
        interactor?.getGameDataPagination(pageSize: pageSize, page: page, search: search)
            .observe(on: MainScheduler.instance)
            .subscribe{ [weak self] gameResult in
                self?.view?.updateGameList(with: gameResult)
            } onError: { error in
                self.view?.updateGameList(with: error.localizedDescription)
                self.isLoadingData = false
            } onCompleted: {
                self.isLoadingData = false
            }.disposed(by: disposeBag)
    }
    
    func didSelectGameItem(with gameId: Int) {
        router?.goToDetailGame(with: gameId)
    }
   
}
