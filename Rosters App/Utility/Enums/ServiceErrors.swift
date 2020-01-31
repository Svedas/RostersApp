//
//  ServiceErrors.swift
//  Rosters App
//
//  Created by Mantas Svedas on 1/28/20.
//  Copyright © 2020 Mantas Svedas. All rights reserved.
//

import Foundation

enum APIServiceError: Error {
    case noData
    case timedOut
    case almofireFailure
}

enum UserDefaultsError: Error {
    case notInitialized
}
