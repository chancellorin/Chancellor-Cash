//
//  SSJournalistPredictfdv.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/29.
//

import UIKit
import PureLayout
import KKUtilsKitSwift

class SSJournalistPredictfdv: UIView, UITextFieldDelegate {
    
    weak var journalistanti: UILabel!
    weak var journalistantfd: UITextField!
    var islandlady = false {
        didSet {
            if islandlady {
                journalistanti.text = "PAN number"
                journalistantfd.isUserInteractionEnabled = false
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        journalist_stepui()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        journalist_stepui()
    }
    
    func journalist_stepui() {
        let journalistanti = UILabel()
        journalistanti.textColor = KKToolUtils.color_from_hex("#BBBBBB")
        journalistanti.text = "Aadhaar Number"
        journalistanti.font = KKToolUtils.ubuntu_font(size: 13, weight: .bold)
        addSubview(journalistanti)
        journalistanti.autoPinEdge(toSuperviewEdge: .top)
        journalistanti.autoPinEdge(toSuperviewEdge: .left)
        journalistanti.autoSetDimension(.height, toSize: 20)
        self.journalistanti = journalistanti
        
        let journalistantfd = UITextField()
        journalistantfd.ss_borderColor = KKToolUtils.color_from_hex("#30AAFF00")
        journalistantfd.ss_borderWidth = 1
        journalistantfd.ss_cornerRadius = 14
        journalistantfd.textPadding(left: 17, right: 17)
        journalistantfd.keyboardType = .numberPad
        journalistantfd.delegate = self
        journalistantfd.textColor = KKToolUtils.color_from_hex("#FFAAAAAA")
        journalistantfd.font = KKToolUtils.ubuntu_font(size: 15, weight: .bold)
        addSubview(journalistantfd)
        journalistantfd.autoPinEdge(.top, to: .bottom, of: journalistanti, withOffset: 15)
        journalistantfd.autoSetDimension(.height, toSize: 52)
        journalistantfd.autoPinEdge(toSuperviewEdge: .left)
        journalistantfd.autoPinEdge(toSuperviewEdge: .right)
        journalistantfd.autoPinEdge(toSuperviewEdge: .bottom)
        self.journalistantfd = journalistantfd
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if islandlady { return }
        guard let text = textField.text else { return }
        let numtext = text.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let resul = String(numtext.prefix(12))
        textField.text = resul
    }

}
