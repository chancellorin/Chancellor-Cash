//
//  SSSherlockAnalysis.swift
//  Sherlock
//
//  Created by Sherlock on 2026/7/3.
//

import UIKit
import Alamofire
import KKDeviceInsightKitSwift
import KKImageCompressKitSwift
import KakaJSON
import KKUtilsKitSwift

struct SSSherlockAnalysis {
    
    static var upgmand = false
    
    static func ss_sherlockurl(_ url: String) -> String {
        return "https://api.chancellorcashin.com" + url
    }
    
    static var sherlock_header: HTTPHeaders = {
        [
            "Content-Type": "application/json",
            "User-Agent": "\(sherlockid)/\(KKApplicationInfo.application_version)(Apple;Mobile;\(KKDeviceSystemInfo.system_device_type_formatted_name);iOS \(KKDeviceSystemInfo.system_version);)"
        ]
    }()
    
    static func ss_sherlock(lock: String, silogic: SSSherlockEvidence? = nil, logic: SSSherlockEvidence? = nil, logicdic: [String: Any]? = nil, resultsucc: @escaping ([String: Any]?) -> Void, resultfail: @escaping (SSSherlockAnalysisError) -> Void) {
        if upgmand {
            return
        }
        let logicpara = SSSherlockLogic.sherlock_logic(silogic, logic, logicdic)
        AF.request(
            ss_sherlockurl(lock),
            method: .post,
            parameters: logicpara,
            encoding: JSONEncoding.default,
            headers: sherlock_header,
            requestModifier: { $0.timeoutInterval = 60 }
        )
        .responseData { response in
            switch response.result {
            case .success(let data):
                DispatchQueue.main.async {
                    if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                        let envelope = json.kj.model(SSSherlockAnalysisEvidence.self)
                        switch true {
                        case SSSherlockAnalysisResultcode.analysisOutResultcode.contains(envelope.resultCode): sherlockout()
                        case SSSherlockAnalysisResultcode.analysisUpgResultcode.contains(envelope.resultCode):
                            SSSherlockAnalysisPublic.ss_publicupg {}
                            upgmand = true
                        case SSSherlockAnalysisResultcode.analysisResultcode.contains(envelope.resultCode): resultsucc(envelope.data)
                        default:
                            resultfail(SSSherlockAnalysisError.sherlock_error(envelope.resultCode, envelope.resultMsg))
                        }
//                        print("====url===\(lock)  request=====\(logicpara)  response.result === \(json)")
                    } else {
                        resultfail(SSSherlockAnalysisError.sherlock_error(-1, nil))
                    }
                }
            case .failure(_):
                DispatchQueue.main.async {
                    resultfail(SSSherlockAnalysisError.sherlock_error(-1, nil))
                }
            }
        }
    }
    
    static func ss_sherlockimgv(
        lock: String?,
        on imgv: UIImageView,
    ) {
        DispatchQueue.main.async {
            imgv.image = UIImage(named: "Chancellor_icon")
        }
        guard let sherlock = lock, !sherlock.isEmpty else { return }
        AF.request(sherlock)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    let image = UIImage(data: data)
                    DispatchQueue.main.async { imgv.image = image }
                case .failure:
                    break
                }
            }
    }
    
    static func ss_sherlockUppic(_ sherpic: UIImage, resultsucc: @escaping (String?) -> Void) {
        guard let upurl = URL(string: ss_sherlockurl("/app/v3/sys/upload")) else { return }
        guard let picdata = KKImageCompressUtils.compress_image_data(sherpic) else { return }
        AF.upload(
            multipartFormData: { formdata in
                formdata.append(picdata, withName: "file", fileName: "sherlock\(KKDeviceSystemInfo.system_current_time).jpg", mimeType: "image/jpeg")
                for (sherk, sherv) in SSSherlockLogic.sherlock_logic() {
                    if let shervd = "\(sherv)".data(using: .utf8) {
                        formdata.append(shervd, withName: sherk)
                    }
                }
            },
            to: upurl,
            headers: sherlock_header
        )
        .validate()
        .responseData { response in
            switch response.result {
            case .success(let data):
                DispatchQueue.main.async {
                    if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                        let envelope = json.kj.model(SSSherlockpicEvidence.self)
                        switch true {
                        case SSSherlockAnalysisResultcode.analysisOutResultcode.contains(envelope.resultCode): sherlockout()
                        case SSSherlockAnalysisResultcode.analysisUpgResultcode.contains(envelope.resultCode):
                            SSSherlockAnalysisPublic.ss_publicupg {}
                            upgmand = true
                        case SSSherlockAnalysisResultcode.analysisResultcode.contains(envelope.resultCode):
                            if let evid = envelope.data, let picurl = evid["src"] as? String {
                                resultsucc(picurl)
                            }
                        default:
                            resultsucc(nil)
                        }
                    } else {
                        resultsucc(nil)
                    }
                }
            case .failure(_):
                DispatchQueue.main.async {
                    resultsucc(nil)
                }
            }
        }
    }
    
    static func sherlockout() {
        KKToolUtils.clear_local_namespace()
        KKToolUtils.key_window?.rootViewController = SherlockNavigationController(rootViewController: SSDetectiveViewController())
    }
    
}

struct SSSherlockpicEvidence: Convertible {
    var resultCode: Int = -1
    var resultMsg: String?
    var data: [String: Any]?
}
