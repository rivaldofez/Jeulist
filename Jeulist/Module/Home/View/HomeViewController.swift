//
//  HomeViewController.swift
//  Jeulist
//
//  Created by Rivaldo Fernandes on 18/02/23.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        let remote = RemoteDataSource.sharedInstance
        
        let gameRepository = GameRepository.sharedInstance(remote)
        
        gameRepository.getGameDataPagination(page: 1)
            .subscribe { game in
                print(game)
            } onError: { error in
                print("error")
            } onCompleted: {
                
            }.disposed(by: self.disposeBag)
        
    }

}
