//
//  SSSherlockLogic.swift
//  Sherlock
//
//  Created by Sherlock on 2026/7/3.
//

import UIKit
import KKDeviceInsightKitSwift
import KKUtilsKitSwift

let sherlockid = "chancellorcash"
let sherlocksign = "Rekp5vvbo0gpEGuQ"
let sherlockhandler = "iosHandler"

struct SSSherlockLogicFree {
    var appId: String = sherlockid
    var salt: String = sherlocksign
    var baseUrl: String = SSSherlockAnalysis.ss_sherlockurl("")
    var userId: String = KKToolUtils.user_id ?? ""
    var token: String = KKToolUtils.token ?? ""
    var mobile: String = KKToolUtils.mobile ?? ""
    
    func toDict() -> [String: Any] {
        var result: [String: Any] = [:]
        let mirror = Mirror(reflecting: self)
        for child in mirror.children {
            guard let key = child.label else { continue }
            result[key] = child.value
        }
        return result
    }
}

struct SSSherlockLogicTrace {
    
    var appId: String = sherlockid
    var deviceId: String = KKDeviceIdInfo.device_id
    var channel: String = "app_store"
    var version: String = "2.0"
    var os: String = "2"
    var clientLanguage: String = "en"
    var nonce: String = KKDeviceBaseInfo.number_random
    var clientTime: String = KKDeviceSystemInfo.system_current_time
    var clientVersion: String = KKApplicationInfo.application_version
    var userId: String = KKToolUtils.user_id ?? ""
    var token: String = KKToolUtils.token ?? ""
    var sign: String = ""
    var data: [String: Any] = [:]

    func toDict() -> [String: Any] {
        var result: [String: Any] = [:]
        let mirror = Mirror(reflecting: self)
        for child in mirror.children {
            guard let key = child.label else { continue }
            result[key] = child.value
        }
        return result
    }
    
}

struct SSSherlockLogic {
        
    static func sherlock_logic(_ silogic: SSSherlockEvidence? = nil, _ logic: SSSherlockEvidence? = nil, _ logicdic: [String: Any]? = nil) -> [String: Any] {
        var trace = SSSherlockLogicTrace()
        
        var signlist: [String] = [
            trace.appId,
            trace.deviceId,
            trace.os,
            trace.channel,
            trace.version,
            trace.clientTime,
            trace.nonce
        ]
        
        if let evidence = silogic {
            let mirror = Mirror(reflecting: evidence)
            for child in mirror.children {
                if let strvalue = child.value as? String, !strvalue.isEmpty {
                    signlist.append(strvalue)
                }
            }
        }
        
        signlist.sort()
        let mdfirst = KKToolUtils.MD5_string(signlist.joined(separator: "&")) + sherlocksign
        let mdult = KKToolUtils.MD5_string(mdfirst)
        trace.sign = mdult
        trace.data = logicdic ?? logic?.toDict() ?? silogic?.toDict() ?? [:]
        return trace.toDict()
    }

}
