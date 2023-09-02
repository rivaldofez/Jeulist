//
//  FavoriteGameViewController.swift
//  Jeulist
//
//  Created by Rivaldo Fernandes on 31/08/23.
//

import UIKit

protocol FavoriteGameViewProtocol {
    var presenter: FavoriteGameViewProtocol? { get set }
}


class FavoriteGameViewController: UIViewController, FavoriteGameViewProtocol {
    var presenter: FavoriteGameViewProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .cyan
    }
}
