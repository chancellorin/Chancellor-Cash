//
//  SSMoriartyPredict+.swift
//  Sherlock
//
//  Created by Sherlock on 2026/7/7.
//

import UIKit
import KKUtilsKitSwift

extension SSMoriartyPredict {
    func moriartyrefrash(_ moriartype: MoriartyType) {
        switch moriartype {
        case .moriartycam:
            moriartyimv.image = .alertCamimg
            moriartyti.text = "Camera"
            moriartytip.text = "You need to turn on camera access for Chancellor Cash in Settings before taking photos."
        case .moriartyloa:
            moriartyimv.image = .alertLocaimg
            moriartyti.text = "Location"
            moriartytip.text = "You need to authorize Chancellor Cash to access location data within Settings before proceeding with the loan application."
        case .moriartycon:
            moriartyimv.image = .alertContimg
            moriartyti.text = "Contacts"
            moriartytip.text = "Chancellor Cash requires access to your contacts for fraud detection. This enables us to verify your identity and safeguard your account security. Please choose \"Allow Full Access\" during authorization to prevent disruption to the review process. Your privacy matters to us. Your contact data will be transmitted to our server and will neither be retained nor disclosed to any third parties. You may modify this permission anytime in Settings."
        }
    }
    
    func moriartylebttapd() {
        switch moriartype {
        case .moriartycon: moriarselect?()
        default: break
        }
        self.removeFromSuperview()
    }
    
    func moriartyribttapd() {
        if UIApplication.shared.canOpenURL(URL(string: UIApplication.openSettingsURLString)!) {
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        }
        switch moriartype {
        case .moriartycon: moriarselect?()
        default: break
        }
        self.removeFromSuperview()

    }
}
