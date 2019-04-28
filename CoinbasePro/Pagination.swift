//
//  Pagination.swift
//  CoinbasePro
//
//  Created by Martin Walsh on 19/06/2018.
//  Copyright © 2018 Martin Walsh. All rights reserved.
//

public protocol Paginator {
    func limit(_ limit: Int) -> Self
    func nextPage(_ next: String) -> Self
    func previousPage(_ prev: String) -> Self
}

public struct Pagination {
    public let next: String?
    public let previous: String?
}
