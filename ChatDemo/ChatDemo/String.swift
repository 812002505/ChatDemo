//
//  String.swift
//  ChatDemo
//
//  Created by zyc on 2017/11/24.
//  Copyright © 2017年 zyc. All rights reserved.
//

extension String{
    func sha1() -> String {
        let data = self.data(usingEncoding: String.Encoding.utf8)!
        var digest = [UInt8](repeating: 0, count:Int(CC_SHA1_DIGEST_LENGTH))
        CC_SHA1(data.bytes, CC_LONG(data.length), &digest)
        let hexBytes = map(digest) { String(format: "%02hhx", $0) }
        return "".join(hexBytes)
    }
}
