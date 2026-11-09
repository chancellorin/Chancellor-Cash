//
//  SSSoldierPredictsli.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/27.
//

import UIKit
import KKUtilsKitSwift
import PureLayout

class SSSoldierPredictsli: UIView {
    
    var soldierult: ((Int) -> Void)?
    
    weak var soldiersli: UISlider!
    weak var soldierve: SSLabel!
    weak var soldiermax: UILabel!

    var slivel: Float = 0.0 {
        didSet {
            soldiersli.value = slivel
            soldierve.text = "\(Int(round(soldiersli.value)))"
        }
    }
    var slimax: Float = 0.0 {
        didSet {
            soldiersli.maximumValue = slimax
            soldiermax.text = "\(Int(slimax))"
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        soldier_stepui()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        soldier_stepui()
    }
    
    func soldier_stepui() {
        let soldierti = UILabel()
        soldierti.textColor = KKToolUtils.color_from_hex("#FFBBBBBB")
        soldierti.font = KKToolUtils.ubuntu_font(size: 13, weight: .bold)
        addSubview(soldierti)
        soldierti.autoPinEdge(toSuperviewEdge: .top, withInset: 6)
        soldierti.autoPinEdge(toSuperviewEdge: .left)
        soldierti.autoSetDimension(.height, toSize: 20)
        
        let soldierve = SSLabel()
        soldierve.textColor = KKToolUtils.color_from_hex("#FFAAFF00")
        soldierve.font = KKToolUtils.ubuntu_font(size: 15, weight: .bold)
        soldierve.textAlignment = .center
        soldierve.ss_borderColor = KKToolUtils.color_from_hex("#30AAFF00")
        soldierve.ss_borderWidth = 1
        soldierve.ss_cornerRadius = 10
        soldierve.backgroundColor = KKToolUtils.color_from_hex("#12AAFF00")
        addSubview(soldierve)
        soldierve.autoPinEdge(.top, to: .bottom, of: soldierti, withOffset: 9)
        soldierve.autoPinEdge(toSuperviewEdge: .left)
        soldierve.autoPinEdge(toSuperviewEdge: .bottom, withInset: 5)
        soldierve.autoSetDimensions(to: CGSize(width: 64, height: 40))
        self.soldierve = soldierve
        
        let soldiersli = UISlider()
        soldiersli.minimumTrackTintColor = KKToolUtils.color_from_hex("#FFAAFF00")
        soldiersli.maximumTrackTintColor = KKToolUtils.color_from_hex("#FFAAFF00")
        soldiersli.thumbTintColor = KKToolUtils.color_from_hex("#FFAAFF00")
        soldiersli.minimumValue = 1
        let thumbImage = drawCircleThumb(size: CGSize(width: 18, height: 18), color: KKToolUtils.color_from_hex("#FFAAFF00"))
        soldiersli.setThumbImage(thumbImage, for: .normal)
        soldiersli.setThumbImage(thumbImage, for: .highlighted)
        soldiersli.addTarget(self, action: #selector(soldierslichange(_:)), for: .valueChanged)
        addSubview(soldiersli)
        soldiersli.autoPinEdge(.left, to: .right, of: soldierve, withOffset: 12)
        soldiersli.autoPinEdge(toSuperviewEdge: .right)
        soldiersli.autoSetDimension(.height, toSize: 20)
        soldiersli.autoAlignAxis(.horizontal, toSameAxisOf: soldierve)
        self.soldiersli = soldiersli
        
        let soldiermin = UILabel()
        soldiermin.textColor = KKToolUtils.color_from_hex("#FF444444")
        soldiermin.font = KKToolUtils.ubuntu_font(size: 10, weight: .bold)
        soldiermin.text = "1"
        addSubview(soldiermin)
        soldiermin.autoPinEdge(toSuperviewEdge: .bottom, withInset: 2)
        soldiermin.autoSetDimension(.height, toSize: 14)
        soldiermin.autoPinEdge(.left, to: .left, of: soldiersli)
        
        let soldiermax = UILabel()
        soldiermax.textColor = KKToolUtils.color_from_hex("#FF444444")
        soldiermax.font = KKToolUtils.ubuntu_font(size: 10, weight: .bold)
        addSubview(soldiermax)
        soldiermax.autoPinEdge(toSuperviewEdge: .bottom, withInset: 2)
        soldiermax.autoSetDimension(.height, toSize: 14)
        soldiermax.autoPinEdge(.right, to: .right, of: soldiersli)
        self.soldiermax = soldiermax
    }
    
    func drawCircleThumb(size: CGSize, color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        color.setFill()
        UIBezierPath(ovalIn: CGRect(origin: .zero, size: size)).fill()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    @objc private func soldierslichange(_ soldiersli: UISlider) {
        soldierve.text = "\(Int(round(soldiersli.value)))"
        soldierult?(Int(round(soldiersli.value)))
    }

}
