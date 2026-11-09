//
//  SSVeteranTableCelltact.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/29.
//

import UIKit
import KKUtilsKitSwift
import PureLayout

class SSVeteranTableCelltact: UIView {
    
    weak var veterandex: UILabel!
    weak var veteranti: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        veteran_stepui()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        veteran_stepui()
    }
    
    func veteran_stepui() {
        let veterandex = UILabel()
        veterandex.ss_borderColor = KKToolUtils.color_from_hex("#FF3C3C3C")
        veterandex.ss_borderWidth = 1
        veterandex.ss_cornerRadius = 7
        veterandex.font = KKToolUtils.ubuntu_font(size: 10, weight: .bold)
        veterandex.textColor = KKToolUtils.color_from_hex("#FF3A3A3A")
        veterandex.backgroundColor = KKToolUtils.color_from_hex("#FFDBDBDB")
        veterandex.textAlignment = .center
        addSubview(veterandex)
        veterandex.autoPinEdge(toSuperviewEdge: .left, withInset: 14)
        veterandex.autoPinEdge(toSuperviewEdge: .top, withInset: 12)
        veterandex.autoSetDimensions(to: CGSize(width: 22, height: 22))
        self.veterandex = veterandex
        
        let veteranti = UILabel()
        veteranti.font = KKToolUtils.ubuntu_font(size: 13, weight: .bold)
        veteranti.textColor = KKToolUtils.color_from_hex("#FF444444")
        addSubview(veteranti)
        veteranti.autoPinEdge(.left, to: .right, of: veterandex, withOffset: 8)
        veteranti.autoPinEdge(toSuperviewEdge: .top, withInset: 14)
        veteranti.autoSetDimension(.height, toSize: 20)
        self.veteranti = veteranti
    }

}
