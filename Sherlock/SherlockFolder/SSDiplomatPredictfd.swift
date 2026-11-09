//
//  SSDiplomatPredictfd.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/29.
//

import UIKit
import KKUtilsKitSwift
import PureLayout
import IQKeyboardManagerSwift

class SSDiplomatPredictfd: UITextField, UITextFieldDelegate {
    
    var diplomatEvid: SSSherlockDiplomatEvidence = SSSherlockDiplomatEvidence() {
        didSet {
            text = diplomatEvid.diptant
            self.diplomatfind.isHidden = true
            if diplomatEvid.itemType == 1 {
                if diplomatEvid.itemCode?.contains("fsc") == true {
                    placeholder = "Please enter or choose"
                    self.diplomatfind.isHidden = false
                    keyboardType = .asciiCapable
                }else {
                    placeholder = "Please enter"
                    keyboardType = (diplomatEvid.itemCode ?? "").contains("email") ? .emailAddress : .numberPad
                }
                diplomatimv.isHidden = true
            }else {
                placeholder = "Please choose"
                diplomatimv.isHidden = false
            }
            placeholderColor(KKToolUtils.color_from_hex("#4DFFFFFF"))
        }
    }
    
    var diplomatchange: ((SSSherlockDiplomatEvidence) -> Void)?
    var diplomatff: (() -> Void)?
    var diplomatffind: (() -> Void)?

    weak var diplomatfind: UIButton!
    weak var diplomatimv: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        diplomat_stepui()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        diplomat_stepui()
    }
    
    func diplomat_stepui() {
        delegate = self
        textColor = .white
        font = KKToolUtils.ubuntu_font(size: 13)
        textPadding()
        ss_borderColor = KKToolUtils.color_from_hex("#FF3C3C3C")
        ss_borderWidth = 1
        ss_cornerRadius = 14

        let diplomatfind = UIButton(type: .custom, primaryAction: UIAction { _ in
            self.diplomatff?()
        })
        diplomatfind.setImage(.diplomatSf, for: .normal)
        diplomatfind.isHidden = true
        addSubview(diplomatfind)
        diplomatfind.autoPinEdge(toSuperviewEdge: .right, withInset: 8)
        diplomatfind.autoSetDimensions(to: CGSize(width: 89, height: 29))
        diplomatfind.autoAlignAxis(toSuperviewAxis: .horizontal)
        self.diplomatfind = diplomatfind
        
        let diplomatimv = UIImageView(image: .veteranChship)
        diplomatimv.isHidden = true
        addSubview(diplomatimv)
        diplomatimv.autoPinEdge(toSuperviewEdge: .right, withInset: 15)
        diplomatimv.autoSetDimensions(to: CGSize(width: 14, height: 14))
        diplomatimv.autoAlignAxis(toSuperviewAxis: .horizontal)
        self.diplomatimv = diplomatimv
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if diplomatEvid.itemType == 10 {
            self.diplomatffind?()
            return false
        }
        if diplomatEvid.itemType != 1 {
            IQKeyboardManager.shared.resignFirstResponder()
            let motives = diplomatEvid.buttonList?.compactMap { $0.buttonLabel } ?? []
            let motive = SSMotivePredict.motive_alert(motivetitl: diplomatEvid.itemName ?? "", motives)
            motive.motiveaction = { moindex in
                textField.text = motives[moindex]
                self.diplomatEvid.diptant = motives[moindex]
                self.diplomatEvid.dipkey = self.diplomatEvid.buttonList?[moindex].buttonKey
                self.diplomatchange?(self.diplomatEvid)
            }
            return false
        }
        return !(diplomatEvid.itemCode == "name")
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        var numtext = text
        switch diplomatEvid.itemCode {
        case "child_count":
            numtext = text.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
            numtext = String(numtext.prefix(3))
        case "whatsapp":
            numtext = text.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
            numtext = String(numtext.prefix(13))
        case "account_no", "account_no_verify":
            numtext = text.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
            numtext = String(numtext.prefix(18))
        case "credit_card":
            numtext = text.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
            numtext = String(numtext.prefix(32))
        case "email":
            numtext = String(numtext.prefix(128))
        default: break
        }
        textField.text = numtext
        self.diplomatEvid.diptant = numtext
        self.diplomatchange?(self.diplomatEvid)
    }
    
//    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
//        guard bounds.contains(point) else {
//            return nil
//        }
//        for subview in subviews.reversed() {
//            let subPoint = subview.convert(point, from: self)
//            if let target = subview.hitTest(subPoint, with: event) {
//                return target
//            }
//        }
//        return self
//    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if !diplomatfind.isHidden {
            let btnPoint = diplomatfind.convert(point, from: self)
            if diplomatfind.bounds.contains(btnPoint) {
                return diplomatfind
            }
        }
        for subview in subviews.reversed() {
            let subPoint = subview.convert(point, from: self)
            if let target = subview.hitTest(subPoint, with: event) {
                return target
            }
        }
        guard bounds.contains(point) else {
            return nil
        }
        return self
    }

}
