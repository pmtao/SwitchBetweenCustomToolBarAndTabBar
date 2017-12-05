//
//  URLSessionClient.swift
//  SwitchBetweenCustomToolBarAndTabBar
//
//  Created by 阿涛 on 17-12-4.
//  Copyright © 2017年 SinkingSoul. All rights reserved.
//

import Foundation

/// 网络客户端模型
struct URLSessionClient: Client {
    let host: String
    
    func send<T: Request>(_ requestInfo: T, handler: @escaping (Data?) -> Void) {
        let url = URL(string: host.appending(requestInfo.path))!
        var request = URLRequest(url: url)
        request.httpMethod = requestInfo.method.rawValue
        
        let task = URLSession.shared.dataTask(with: request) {
            data, _, error in
            if let data = data {
                DispatchQueue.main.async { handler(data) }
            } else {
                DispatchQueue.main.async { handler(nil) }
            }
        }
        task.resume()
    }
}
