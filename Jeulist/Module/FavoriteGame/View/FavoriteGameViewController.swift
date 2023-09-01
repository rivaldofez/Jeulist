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

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
