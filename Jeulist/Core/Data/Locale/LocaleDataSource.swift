//
//  LocaleDataSource.swift
//  Jeulist
//
//  Created by Rivaldo Fernandes on 01/09/23.
//

import Foundation
import CoreData
import RxSwift
import UIKit


protocol LocaleDataSourceProtocol: AnyObject {
    func getFavoriteGameList() -> Observable<[GameDetailEntity]>
    func saveToggleFavoriteGame(gameDetail: GameDetailEntity) -> Observable<Bool>
    func getFavoriteGameById(id: Int) -> Observable<GameDetailEntity?>
}

final class LocaleDataSource: NSObject {
    static let shared = LocaleDataSource()
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
}

extension LocaleDataSource: LocaleDataSourceProtocol {
    func getFavoriteGameList() -> Observable<[GameDetailEntity]> {
        return Observable<[GameDetailEntity]>.create { observer in
            if let context = self.appDelegate?.persistentContainer.viewContext {
                
                let request = GameDetailEntity.fetchRequest()
                
                do {
                    let gameDetailList = try context.fetch(request)
                    observer.onNext(gameDetailList)
                    observer.onCompleted()
                } catch {
                    observer.onError(DatabaseError.requestFailed)
                }
                
                
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            
            return Disposables.create()
        }
    }
    
    func saveToggleFavoriteGame(gameDetail: GameDetailEntity) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            if let context = self.appDelegate?.persistentContainer.viewContext {
                
                do {
                    try context.save()
                    observer.onNext(true)
                    observer.onCompleted()
                } catch {
                    observer.onError(DatabaseError.requestFailed)
                }
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            
            return Disposables.create()
        }
    }
    
    func getFavoriteGameById(id: Int) -> Observable<GameDetailEntity?> {
        return Observable<GameDetailEntity?>.create { observer in
            if let context = self.appDelegate?.persistentContainer.viewContext {
                let request = GameDetailEntity.fetchRequest()
                request.predicate = NSPredicate(format: "id == %@", id)
                
                do {
                    let result = try context.fetch(request).first
                    observer.onNext(result)
                    observer.onCompleted()
                } catch {
                    observer.onError(DatabaseError.requestFailed)
                }
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            
            return Disposables.create()
        }
    }
    
    
}
