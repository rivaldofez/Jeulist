//
//  ProfilePresenter.swift
//  Jeulist
//
//  Created by Rivaldo Fernandes on 31/08/23.
//

import Foundation

protocol ProfilePresenterProtocol {
    var router: ProfileRouterProtocol? { get set}
    var profileView: ProfileViewProtocol? { get set }
    
}

class ProfilePresenter: ProfilePresenterProtocol {
    var router: ProfileRouterProtocol?
    
    var profileView: ProfileViewProtocol?
    
}
