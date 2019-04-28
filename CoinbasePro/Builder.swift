//
//  Builder.swifr
//  CoinbasePro.iOS
//
//  Created by Martin Walsh on 14/06/2018.
//  Copyright © 2018 Martin Walsh. All rights reserved.
//

import Foundation

public class Builder {

    let request: Request

    // MARK: Builder
    let path: String
    var params: [String: String] = [:]

    init(path: String, request: Request) {
        self.path = path
        self.request = request
    }
}

extension Builder: Paginator {

    public func limit(_ limit: Int) -> Self {
        self.params["limit"] = String(limit)
        return self
    }

    public func nextPage(_ next: String) -> Self {
        self.params["after"] = next
        return self
    }

    public func previousPage(_ prev: String) -> Self {
        self.params["before"] = prev
        return self
    }
}
