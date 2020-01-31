//
//  MockAFSession.swift
//  Rosters App
//
//  Created by Mantas Svedas on 1/23/20.
//  Copyright © 2020 Mantas Svedas. All rights reserved.
//

import Foundation

class MockURLSession: URLSession {
    var url: URL?
    
    override func dataTask(with url: URL, completionHandler: @escaping(Data?, URLResponse?, Error?) -> Void ) -> URLSessionDataTask {
        self.url = url
        return URLSessionDataTask()
    }
}
