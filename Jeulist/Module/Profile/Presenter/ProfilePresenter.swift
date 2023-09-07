//
//  ProfilePresenter.swift
//  Jeulist
//
//  Created by Rivaldo Fernandes on 31/08/23.
//

import Foundation
import RxSwift

protocol ProfilePresenterProtocol {
    var router: ProfileRouterProtocol? { get set}
    var view: ProfileViewProtocol? { get set }
    var interactor: ProfileUseCase? { get set }
    var isLoadingData: Bool { get set }
    func getUserData()
    func saveUserData(user: User)
    
}

class ProfilePresenter: ProfilePresenterProtocol {
    var isLoadingData: Bool = false
    private let disposeBag = DisposeBag()
    var interactor: ProfileUseCase?
    var router: ProfileRouterProtocol?
    var view: ProfileViewProtocol?
    
    func getUserData() {
        isLoadingData = true
        interactor?.getUserData()
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] userData in
                self?.view?.updateUserData(with: userData)
            } onError: { error in
                self.view?.updateUserData(with: error.localizedDescription)
                self.isLoadingData = false
            } onCompleted: {
                self.isLoadingData = false
            }.disposed(by: disposeBag)
    }
    
    func saveUserData(user: User) {
        interactor?.saveUserData(user: user)
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] userData in
                self?.view?.updateUserData(with: userData)
            } onError: { error in
                self.view?.updateUserData(with: error.localizedDescription)
                self.isLoadingData = false
            } onCompleted: {
                self.isLoadingData = false
            }.disposed(by: disposeBag)
    }
}
