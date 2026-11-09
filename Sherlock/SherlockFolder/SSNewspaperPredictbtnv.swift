//
//  SSNewspaperPredictbtnv.swift
//  Sherlock
//
//  Created by Sherlock on 2026/7/2.
//

import UIKit
import KKUtilsKitSwift
import SnapKit

class SSNewspaperPredictbtnv: UIView {
    
    weak var newspaperlebtt: UIButton!
    weak var newspaperribtt: UIButton!
    
    var newspaperEvid = SSSherlockNewspaperEvidence() {
        didSet {
            switch newspaperEvid.orderDetail?.orderStatus {
            case 10, 36, 61:
                newspaperlebtt.snp.updateConstraints { make in
                    make.width.equalTo(0)
                }
                newspaperribtt.snp.updateConstraints { make in
                    make.left.equalTo(newspaperlebtt.snp.right).offset(0)
                }
                newspaperlebtt.isHidden = true
                newspaperribtt.isHidden  = false
            case 60:
                newspaperlebtt.snp.updateConstraints { make in
                    make.width.equalTo(114)
                }
                newspaperribtt.snp.updateConstraints { make in
                    make.left.equalTo(newspaperlebtt.snp.right).offset(12)
                }
                newspaperlebtt.isHidden = false
                newspaperribtt.isHidden  = false
            default:
                newspaperlebtt.isHidden = true
                newspaperribtt.isHidden  = true
            }
            switch newspaperEvid.orderDetail?.orderStatus {
            case 10:
                newspaperribtt.setTitle("Submit info", for: .normal)
            case 36:
                newspaperribtt.setTitle("Update bank account", for: .normal)
            case 60, 61:
                newspaperribtt.setTitle("Repay", for: .normal)
            default: break
            }
            SSSergeantNeed.sergeantColorstring(newspaperEvid.orderDetail?.orderStatus) { color, bgcolor in
                self.newspaperribtt.backgroundColor = KKToolUtils.color_from_hex(color)
                self.newspaperribtt.ss_layerShadow(shadowColor: KKToolUtils.color_from_hex("54\(color)"))
            }
        }
    }
    
    var lebttselect: (() -> Void)?
    var ribttselect: ((Int) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        newspaper_stepui()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        newspaper_stepui()
    }
    
    func newspaper_stepui() {
        let newspaperlebtt = UIButton(type: .custom, primaryAction: UIAction { _ in
            self.lebttselect?()
        })
        newspaperlebtt.titleLabel?.font = KKToolUtils.ubuntu_font(size: 15, weight: .bold)
        newspaperlebtt.setTitleColor(KKToolUtils.color_from_hex("#FF888888"), for: .normal)
        newspaperlebtt.setTitle("Defer", for: .normal)
        newspaperlebtt.ss_cornerRadius = 25
        newspaperlebtt.ss_borderColor = KKToolUtils.color_from_hex("#FF1E1E1E")
        newspaperlebtt.ss_borderWidth = 1
        addSubview(newspaperlebtt)
        newspaperlebtt.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(14)
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(50)
            make.width.equalTo(114)
        }
        self.newspaperlebtt = newspaperlebtt
        
        let newspaperribtt = UIButton(type: .custom, primaryAction: UIAction { _ in
            self.ribttselect?(self.newspaperEvid.orderDetail?.orderStatus ?? 0)
        })
        newspaperribtt.titleLabel?.font = KKToolUtils.ubuntu_font(size: 15, weight: .bold)
        newspaperribtt.setTitleColor(KKToolUtils.color_from_hex("#FF0A0A0A"), for: .normal)
        addSubview(newspaperribtt)
        newspaperribtt.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-14)
            make.top.bottom.equalTo(newspaperlebtt)
            make.left.equalTo(newspaperlebtt.snp.right).offset(12)
        }
        self.newspaperribtt = newspaperribtt
        
    }
}
