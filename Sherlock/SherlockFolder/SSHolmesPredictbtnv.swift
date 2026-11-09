//
//  SSHolmesPredictbtnv.swift
//  Sherlock
//
//  Created by Sherlock on 2026/7/1.
//

import UIKit
import PureLayout
import KKUtilsKitSwift

class SSHolmesPredictbtnv: UIView {
    
    weak var holmestart: UIButton!
    weak var holmestake: UIButton!

    weak var holmesfrim: UIButton!
    weak var holmesres: UIButton!
    
    var holmeselect: ((Int) -> Void)?
    
    var holmestype = 0 {
        didSet {
            switch holmestype {
            case 0:
                holmestart.isHidden = false
                holmestake.isHidden = true
                holmesfrim.isHidden = true
                holmesres.isHidden = true
            case 1:
                holmestart.isHidden = true
                holmestake.isHidden = false
                holmesfrim.isHidden = true
                holmesres.isHidden = true
            case 2:
                holmestart.isHidden = true
                holmestake.isHidden = true
                holmesfrim.isHidden = false
                holmesres.isHidden = false
            default: break
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        holmes_stepui()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        holmes_stepui()
    }
    
    func holmes_stepui() {
        let holmestart = UIButton(type: .custom, primaryAction: UIAction { _ in
            self.holmeselect?(0)
        })
        holmestart.isHidden = false
        holmestart.setTitle("Start", for: .normal)
        holmestart.setTitleColor(KKToolUtils.color_from_hex("#FF0A0A0A"), for: .normal)
        holmestart.backgroundColor = KKToolUtils.color_from_hex("#FFAAFF00")
        holmestart.ss_cornerRadius = 25
        holmestart.titleLabel?.font = KKToolUtils.ubuntu_font(size: 16, weight: .bold)
        addSubview(holmestart)
        holmestart.autoPinEdge(toSuperviewEdge: .left)
        holmestart.autoPinEdge(toSuperviewEdge: .right)
        holmestart.autoSetDimension(.height, toSize: 50)
        holmestart.autoPinEdge(toSuperviewEdge: .top, withInset: 15)
        
        let holmestake = UIButton(type: .custom)
        holmestake.isHidden = true
        addSubview(holmestake)
        var holmestakefig = UIButton.Configuration.plain()
        holmestakefig.imagePlacement = .leading
        holmestakefig.imagePadding = 9
        holmestakefig.image = .holmesCarimg
        holmestakefig.title = "Take a photo"
        holmestakefig.baseForegroundColor = KKToolUtils.color_from_hex("#FF0A0A0A")
        holmestakefig.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { attr in
            var newAttr = attr
            newAttr.font = KKToolUtils.ubuntu_font(size: 16, weight: .bold)
            return newAttr
        }
        holmestakefig.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        holmestake.configuration = holmestakefig
        holmestake.ss_cornerRadius = 25
        holmestake.backgroundColor = KKToolUtils.color_from_hex("#FFAAFF00")
        holmestake.autoPinEdge(toSuperviewEdge: .left)
        holmestake.autoPinEdge(toSuperviewEdge: .right)
        holmestake.autoSetDimension(.height, toSize: 50)
        holmestake.autoPinEdge(toSuperviewEdge: .top, withInset: 15)
        holmestake.addTarget(self, action: #selector(holmestaketap), for: .touchUpInside)
        

        let holmesfrim = UIButton(type: .custom)
        holmesfrim.isHidden = true
        addSubview(holmesfrim)
        var holmesfrimfig = UIButton.Configuration.plain()
        holmesfrimfig.imagePlacement = .top
        holmesfrimfig.imagePadding = 9
        holmesfrimfig.image = .holmesDuiimg
        holmesfrimfig.title = "Confirm"
        holmesfrimfig.baseForegroundColor = KKToolUtils.color_from_hex("#FFAAFF00")
        holmesfrimfig.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { attr in
            var newAttr = attr
            newAttr.font = KKToolUtils.ubuntu_font(size: 12, weight: .bold)
            return newAttr
        }
        holmesfrimfig.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        holmesfrim.configuration = holmesfrimfig
        holmesfrim.autoSetDimensions(to: CGSize(width: 62, height: 80))
        holmesfrim.autoAlignAxis(.vertical, toSameAxisOf: self, withOffset: 45)
        holmesfrim.autoAlignAxis(toSuperviewAxis: .horizontal)
        holmesfrim.addTarget(self, action: #selector(holmesfrimtap), for: .touchUpInside)
        
        let holmesres = UIButton(type: .custom)
        holmesres.isHidden = true
        addSubview(holmesres)
        var holmesresfig = UIButton.Configuration.plain()
        holmesresfig.imagePlacement = .top
        holmesresfig.imagePadding = 9
        holmesresfig.image = .holmesRestimg
        holmesresfig.title = "Restart"
        holmesresfig.baseForegroundColor = KKToolUtils.color_from_hex("#FF666666")
        holmesresfig.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { attr in
            var newAttr = attr
            newAttr.font = KKToolUtils.ubuntu_font(size: 12)
            return newAttr
        }
        holmesresfig.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        holmesres.configuration = holmesresfig
        holmesres.autoSetDimensions(to: CGSize(width: 62, height: 80))
        holmesres.autoAlignAxis(.vertical, toSameAxisOf: self, withOffset: -45)
        holmesres.autoAlignAxis(toSuperviewAxis: .horizontal)
        holmesres.addTarget(self, action: #selector(holmesrestap), for: .touchUpInside)
        
        self.holmestart = holmestart
        self.holmestake = holmestake
        self.holmesfrim = holmesfrim
        self.holmesres = holmesres
        
    }

    @objc func holmestaketap() {
        self.holmeselect?(1)

    }
    
    @objc func holmesfrimtap() {
        self.holmeselect?(3)
    }
    
    @objc func holmesrestap() {
        self.holmeselect?(2)
    }
}
