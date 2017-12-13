//
//  ReviewRepository.swift
//  SwitchBetweenCustomToolBarAndTabBar
//
//  Created by 阿涛 on 17-12-12.
//  Copyright © 2017年 SinkingSoul. All rights reserved.
//

import Foundation
import RxSwift

/// 书籍评论数据源
class ReviewRepository {
    static func reviews(bookID: String) ->  Observable<BookReview> {
        return Observable.create({ observer in
            let request = BookReviewRequest(bookID: bookID,
                                            start: 0,
                                            count: 3)
            request.send { data in
                guard let dataModel = data else { return }
                observer.on(.next(dataModel))
                observer.on(.completed)
            }
            
            return Disposables.create()
        }).share(replay: 1)
    }
    
    static func comments(bookID: String) ->  Observable<BookComment> {
        return Observable.create({ observer in
            let request = BookCommentRequest(bookID: bookID,
                                            start: 0,
                                            count: 3)
            request.send { data in
                guard let dataModel = data else { return }
                observer.on(.next(dataModel))
                observer.on(.completed)
            }
            
            return Disposables.create()
        })
    }
}
