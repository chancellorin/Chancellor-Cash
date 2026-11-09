//
//  SSWatsonPredictbtnv.swift
//  Sherlock
//
//  Created by Sherlock on 2026/7/1.
//

import UIKit
import PureLayout
import KKUtilsKitSwift

class SSWatsonPredictbtnv: UIView {

    weak var watsontake: UIButton!

    weak var watsonfrim: UIButton!
    weak var watsonres: UIButton!
    
    var watsonselect: ((Int) -> Void)?
    
    var watsontype = 0 {
        didSet {
            switch watsontype {
            case 0:
                watsontake.isHidden = false
                watsonfrim.isHidden = true
                watsonres.isHidden = true
            default:
                watsontake.isHidden = true
                watsonfrim.isHidden = false
                watsonres.isHidden = false
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        watson_stepui()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        watson_stepui()
    }
    
    func watson_stepui() {

        let watsontake = UIButton(type: .custom)
        watsontake.isHidden = false
        watsontake.setImage(.watsonTakeimg, for: .normal)
        addSubview(watsontake)
        watsontake.autoSetDimensions(to: CGSize(width: 52, height: 52))
        watsontake.autoCenterInSuperview()
        watsontake.addTarget(self, action: #selector(watsontaketap), for: .touchUpInside)

        let watsonfrim = UIButton(type: .custom)
        watsonfrim.isHidden = true
        addSubview(watsonfrim)
        var watsonfrimfig = UIButton.Configuration.plain()
        watsonfrimfig.imagePlacement = .top
        watsonfrimfig.imagePadding = 6
        watsonfrimfig.image = .holmesDuiimg
        watsonfrimfig.title = "Confirm"
        watsonfrimfig.baseForegroundColor = KKToolUtils.color_from_hex("#FFAAFF00")
        watsonfrimfig.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { attr in
            var newAttr = attr
            newAttr.font = KKToolUtils.ubuntu_font(size: 12, weight: .bold)
            return newAttr
        }
        watsonfrimfig.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        watsonfrim.configuration = watsonfrimfig
        watsonfrim.autoSetDimensions(to: CGSize(width: 62, height: 80))
        watsonfrim.autoAlignAxis(.vertical, toSameAxisOf: self, withOffset: 50)
        watsonfrim.autoAlignAxis(toSuperviewAxis: .horizontal)
        watsonfrim.addTarget(self, action: #selector(watsonfrimtap), for: .touchUpInside)
        
        let watsonres = UIButton(type: .custom)
        watsonres.isHidden = true
        addSubview(watsonres)
        var watsonresfig = UIButton.Configuration.plain()
        watsonresfig.imagePlacement = .top
        watsonresfig.imagePadding = 6
        watsonresfig.image = .holmesRestimg
        watsonresfig.title = "Restart"
        watsonresfig.baseForegroundColor = KKToolUtils.color_from_hex("#FF666666")
        watsonresfig.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { attr in
            var newAttr = attr
            newAttr.font = KKToolUtils.ubuntu_font(size: 12)
            return newAttr
        }
        watsonresfig.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        watsonres.configuration = watsonresfig
        watsonres.autoSetDimensions(to: CGSize(width: 62, height: 80))
        watsonres.autoAlignAxis(.vertical, toSameAxisOf: self, withOffset: -50)
        watsonres.autoAlignAxis(toSuperviewAxis: .horizontal)
        watsonres.addTarget(self, action: #selector(watsonrestap), for: .touchUpInside)
        
        rotateRight90(watsontake)
        rotateRight90(watsonfrim)
        rotateRight90(watsonres)

        self.watsontake = watsontake
        self.watsonfrim = watsonfrim
        self.watsonres = watsonres
    }
    
    func rotateRight90(_ watsonbtt: UIButton) {
        watsonbtt.layer.transform = CATransform3DMakeRotation(.pi / 2, 0, 0, 1)
    }
    
    @objc func watsontaketap() {
        watsonselect?(0)
    }
    
    @objc func watsonfrimtap() {
        watsonselect?(2)
    }
    
    @objc func watsonrestap() {
        watsonselect?(1)
    }

}
