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
    func getGameDataPagination(pageSize: Int, page: Int, search: String) -> Observable<[GameItem]>
    
    func getGameDetail(id: Int) -> Observable<GameDetailResponse>
    
    func getGameScreenshot(id: Int) -> Observable<[ScreenshotItem]>
}

final class RemoteDataSource: NSObject {
    static let sharedInstance: RemoteDataSource = RemoteDataSource()
}

extension RemoteDataSource: RemoteDataSourceProtocol {
    func getGameScreenshot(id: Int) -> RxSwift.Observable<[ScreenshotItem]> {
        return Observable<[ScreenshotItem]>.create { observer in
            if let url = URL(string: Endpoints.Gets.gameScreenshot(id).url) {
                AF.request(url)
                    .responseDecodable(of: ScreenshotResponse.self) { response in
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
    
    func getGameDetail(id: Int) -> RxSwift.Observable<GameDetailResponse> {
        return Observable<GameDetailResponse>.create { observer in
            if let url = URL(string: Endpoints.Gets.gameDetail(id).url) {
                AF.request(url)
                    .responseDecodable(of: GameDetailResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            observer.onNext(value)
                            observer.onCompleted()
                        case .failure:
                            observer.onError(URLError.invalidResponse)
                        }
                    }
            }
            return Disposables.create()
        }
    }
    
    func getGameDataPagination(pageSize: Int, page: Int, search: String) -> RxSwift.Observable<[GameItem]> {
        return Observable<[GameItem]>.create { observer in
            if let url = URL(string: Endpoints.Gets.gamePagination(pageSize: pageSize, page: page, search: search).url) {
                
                AF.request(url)
                    .responseDecodable(of: GameResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            observer.onNext(value.results ?? [])
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
