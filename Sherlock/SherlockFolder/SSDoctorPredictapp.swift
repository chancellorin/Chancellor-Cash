//
//  SSDoctorPredictapp.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/27.
//

import UIKit
import KKUtilsKitSwift
import SnapKit

class SSDoctorPredictapp: UIView, UITextFieldDelegate {
    
    weak var doctorap: UITextField!

    override init(frame: CGRect) {
        super.init(frame: frame)
        doctor_stepui()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        doctor_stepui()
    }
    
    func doctor_stepui() {
        let doctorti = UILabel()
        doctorti.textColor = KKToolUtils.color_from_hex("#FFBBBBBB")
        doctorti.text = "Your WhatsApp account"
        doctorti.font = KKToolUtils.ubuntu_font(size: 13, weight: .bold)
        addSubview(doctorti)
        doctorti.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.height.equalTo(20)
        }
        
        let doctorap = UITextField()
        doctorap.delegate = self
        doctorap.textColor = .white
        doctorap.font = KKToolUtils.ubuntu_font(size: 13)
        doctorap.placeholder = "Please enter"
        doctorap.keyboardType = .numberPad
        doctorap.textPadding()
        doctorap.ss_borderColor = KKToolUtils.color_from_hex("#FF2A2A2A")
        doctorap.ss_borderWidth = 1
        doctorap.ss_cornerRadius = 14
        doctorap.placeholderColor(KKToolUtils.color_from_hex("#803A3A3A"))
        addSubview(doctorap)
        doctorap.snp.makeConstraints { make in
            make.top.equalTo(doctorti.snp.bottom).offset(7)
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
        self.doctorap = doctorap
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        let numtext = text.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        textField.text = String(numtext.prefix(13))
    }
}
