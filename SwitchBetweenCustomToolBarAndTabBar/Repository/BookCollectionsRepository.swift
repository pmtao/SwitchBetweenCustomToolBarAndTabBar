//
//  BookCollectionsRepository.swift
//  SwitchBetweenCustomToolBarAndTabBar
//
//  Created by 阿涛 on 17-12-12.
//  Copyright © 2017年 SinkingSoul. All rights reserved.
//

import Foundation
import RxSwift  

/// 书籍收藏数据源
class BookCollectionsRepository {
    static func collections() ->  Observable<BookCollections> {
        return Observable.create({ observer in
            let request = BookRequest(userName: "pmtao", status: "", start: 0, count: 40)
            request.send { data in
                guard let dataModel = data else { return }
                observer.on(.next(dataModel))
                observer.on(.completed)
            }
            
            return Disposables.create()
        }).share(replay: 1)
    }
}
