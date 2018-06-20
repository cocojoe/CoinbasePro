//
//  Extensions.swift
//  CoinbasePro
//
//  Created by Martin Walsh on 06/06/2018.
//  Copyright © 2018 Martin Walsh. All rights reserved.
//

import Foundation
import CommonCrypto

extension String {

    func base64Decode() -> Data? {
        guard let result = Data(base64Encoded: self) else { return nil }
        return result
    }

    func HMAC256Base64(withKey key: Data) -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = Int(self.lengthOfBytes(using: String.Encoding.utf8))
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: Int(CC_SHA256_DIGEST_LENGTH))
        let keyPtr = (key as NSData).bytes
        CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA256), keyPtr, key.count, str!, strLen, result)
        let data = Data(bytes: result, count: Int(CC_SHA256_DIGEST_LENGTH))
        result.deallocate()
        return data.base64EncodedString()
    }
}
