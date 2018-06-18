//
//  Builder.swifr
//  CoinbasePro.iOS
//
//  Created by Martin on 14/06/2018.
//  Copyright © 2018 Martin. All rights reserved.
//

import Foundation

protocol Builder {
    var path: String { get }
    var params: [String: String] { get set }
}

extension Builder {
    public mutating func limit(_ limit: Int) -> Self {
        self.params["limit"] = String(limit)
        return self
    }
}
