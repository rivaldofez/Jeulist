//
//  RemoteDataSource.swift
//  Jeulist
//
//  Created by Rivaldo Fernandes on 20/02/23.
//

import Foundation
import RxSwift
import Alamofire


protocol RemoteDataSourceProtocol: AnyObject {
    func getGameDataPagination(page: Int) -> Observable<[GameItem]>
}

final class RemoteDataSource: NSObject {
    static let sharedInstance: RemoteDataSource = RemoteDataSource()
}

extension RemoteDataSource: RemoteDataSourceProtocol {
    func getGameDataPagination(page: Int) -> RxSwift.Observable<[GameItem]> {
        return Observable<[GameItem]>.create { observer in
            if let url = URL(string: "\(Endpoints.Gets.gamePagination.url)\(page)"){
                AF.request(url)
                    .responseDecodable(of: GameResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            observer.onNext(value.results)
                            observer.onCompleted()
                        case .failure:
                            observer.onError(URLError.invalidResponse)
                        }
                    }
            }
            
            return Disposables.create()
        }
    }
}
