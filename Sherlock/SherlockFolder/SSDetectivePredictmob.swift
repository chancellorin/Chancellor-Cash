//
//  SSDetectivePredictmob.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/24.
//

import UIKit
import KKUtilsKitSwift
import PureLayout

class SSDetectivePredictmob: UIView, UITextFieldDelegate {
    
    weak var dettextfd: UITextField!

    override init(frame: CGRect) {
        super.init(frame: frame)
        detective_stepui()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        detective_stepui()
    }

    func detective_stepui() {
        self.backgroundColor = KKToolUtils.color_from_hex("#1C1C1C")
        self.ss_cornerRadius = 14
        self.ss_borderWidth = 1
        self.ss_borderColor = KKToolUtils.color_from_hex("#2A2A2A")
        
        let detpref = UILabel()
        detpref.font = KKToolUtils.ubuntu_font(size: 14, weight: .bold)
        detpref.textColor = .white
        detpref.text = "🇮🇳 +91"
        detpref.textAlignment = .center
        self.addSubview(detpref)
        detpref.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), excludingEdge: .right)
        detpref.autoSetDimension(.width, toSize: 75)
        detpref.autoSetDimension(.height, toSize: 50)

        let detline = UIView()
        detline.backgroundColor = KKToolUtils.color_from_hex("#2A2A2A")
        self.addSubview(detline)
        detline.autoPinEdge(.left, to: .right, of: detpref)
        detline.autoPinEdge(toSuperviewEdge: .top)
        detline.autoPinEdge(toSuperviewEdge: .bottom)
        detline.autoSetDimension(.width, toSize: 1)

        let dettextfd = UITextField()
        dettextfd.delegate = self
        dettextfd.textColor = .white
        dettextfd.font = KKToolUtils.ubuntu_font(size: 14)
        dettextfd.placeholder = "Please enter mobile number"
        dettextfd.placeholderColor(KKToolUtils.color_from_hex("#80444444"))
        dettextfd.keyboardType = .numberPad
        self.addSubview(dettextfd)
        dettextfd.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 12), excludingEdge: .left)
        dettextfd.autoPinEdge(.left, to: .right, of: detline, withOffset: 12)
        self.dettextfd = dettextfd
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        let numtext = text.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let resul = String(numtext.prefix(text.hasPrefix("0") ? 11 : 10))
        textField.text = resul
    }
    
}
