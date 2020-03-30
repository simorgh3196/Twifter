//
//  HMAC.swift
//  Core
//
//  Created by Tomoya Hayakawa on 2020/03/26.
//  Copyright © 2020 simorgh3196. All rights reserved.
//

import CommonCrypto

struct HMAC {

    let base: String

    init(_ base: String) {
        self.base = base
    }

    func data(withKey key: String, algorithm: HMACAlgorithm) -> Data {
        let cKey = key.cString(using: .utf8)
        let cData = base.cString(using: .utf8)
        var result = [CUnsignedChar](repeating: 0, count: algorithm.digestLength)
        CCHmac(algorithm.hmacAlgorithm, cKey!, strlen(cKey!), cData!, strlen(cData!), &result)
        let hmacData = Data(bytes: result, count: algorithm.digestLength)

        return hmacData
    }
}

enum HMACAlgorithm {
    case md5, sha1, sha224, sha256, sha384, sha512

    fileprivate var digestLength: Int {
        switch self {
        case .md5:
            return Int(CC_MD5_DIGEST_LENGTH)
        case .sha1:
            return Int(CC_SHA1_DIGEST_LENGTH)
        case .sha224:
            return Int(CC_SHA224_DIGEST_LENGTH)
        case .sha256:
            return Int(CC_SHA256_DIGEST_LENGTH)
        case .sha384:
            return Int(CC_SHA384_DIGEST_LENGTH)
        case .sha512:
            return Int(CC_SHA512_DIGEST_LENGTH)
        }
    }

    fileprivate var hmacAlgorithm: CCHmacAlgorithm {
        switch self {
        case .md5:
            return CCHmacAlgorithm(kCCHmacAlgMD5)
        case .sha1:
            return CCHmacAlgorithm(kCCHmacAlgSHA1)
        case .sha224:
            return CCHmacAlgorithm(kCCHmacAlgSHA224)
        case .sha256:
            return CCHmacAlgorithm(kCCHmacAlgSHA256)
        case .sha384:
            return CCHmacAlgorithm(kCCHmacAlgSHA384)
        case .sha512:
            return CCHmacAlgorithm(kCCHmacAlgSHA512)
        }
    }
}
