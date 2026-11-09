//
//  SSSoldierPredictField.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/27.
//

import UIKit
import KKUtilsKitSwift
import SnapKit

class SSSoldierPredictField: UITextField, UITextFieldDelegate {
    
    var soldierult: ((String) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        soldier_stepui()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        soldier_stepui()
    }
    
    func soldier_stepui() {
        textPadding(left: 29)
        textColor = .white
        font = KKToolUtils.ubuntu_font(size: 15, weight: .bold)
        placeholder = "Please enter (1~10000000)"
        placeholderColor(KKToolUtils.color_from_hex("#80444444"))
        ss_borderColor = KKToolUtils.color_from_hex("#36AAFF00")
        ss_borderWidth = 1
        ss_cornerRadius = 12
        delegate = self
        
        let soldieramti = UILabel()
        soldieramti.textColor = KKToolUtils.color_from_hex("#FFAAFF00")
        soldieramti.text = "₹"
        soldieramti.font = KKToolUtils.ubuntu_font(size: 14, weight: .bold)
        addSubview(soldieramti)
        soldieramti.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(12)
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        var numtext = text.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        if numtext == "0" {
            numtext = "1"
        }
        if Int(numtext) ?? 0 > 10000000 {
            numtext = "10000000"
        }
        textField.text = numtext
        soldierult?(numtext)
    }

}
