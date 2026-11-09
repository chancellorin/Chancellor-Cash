//
//  SSFootprintPredictablev.swift
//  Sherlock
//
//  Created by Sherlock on 2026/7/1.
//

import UIKit
import KKUtilsKitSwift
import SnapKit

class SSFootprintPredictablev: UIView {
    
    var footpEvid = SSSherlockNewspaperEvidence() {
        didSet {
            SSSherlockAnalysis.ss_sherlockimgv(lock: footpEvid.product?.productLogo, on: footprintimv)
            footprintna.text = footpEvid.product?.productName
            SSSergeantNeed.sergeantColorstring(footpEvid.orderDetail?.orderStatus) { color, bgcolor in
                self.footprintsta.textColor = KKToolUtils.color_from_hex(color)
                self.footprintsta.backgroundColor = KKToolUtils.color_from_hex(bgcolor)
                self.footprintsta.ss_borderColor = KKToolUtils.color_from_hex("45\(color)")
            } staterult: { rult in
                self.footprintsta.text = rult
            }
            footprinttable.evids = SSSergeantNeed.sergeantEvidences(false, footpEvid.orderDetail, true)
            footprinttable.reloadData()
            footprinttable.snp.updateConstraints { make in
                make.height.equalTo(38*footprinttable.evids.count)
            }
        }
    }

    weak var footprintimv: UIImageView!
    weak var footprintna: UILabel!
    weak var footprintsta: SSLabel!
    weak var footprinttable: SSLaboratoryTable!

    override init(frame: CGRect) {
        super.init(frame: frame)
        footprint_stepui()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        footprint_stepui()
    }
    
    func footprint_stepui() {
        backgroundColor = KKToolUtils.color_from_hex("#FF161616")
        ss_cornerRadius = 18
        ss_borderWidth = 1
        ss_borderColor = KKToolUtils.color_from_hex("#FF1E1E1E")
        
        let footprintimv = UIImageView()
        footprintimv.ss_cornerRadius = 10
        footprintimv.contentMode = .scaleAspectFill
        addSubview(footprintimv)
        footprintimv.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(13)
            make.left.equalToSuperview().offset(15)
            make.size.equalTo(CGSize(width: 34, height: 34))
        }
        self.footprintimv = footprintimv
        
        let footprintna = UILabel()
        footprintna.textColor = .white
        footprintna.font = KKToolUtils.ubuntu_font(size: 14, weight: .bold)
        addSubview(footprintna)
        footprintna.snp.makeConstraints { make in
            make.left.equalTo(footprintimv.snp.right).offset(10)
            make.top.bottom.equalTo(footprintimv)
        }
        self.footprintna = footprintna
        
        let footprintsta = SSLabel()
        footprintsta.textInsets = UIEdgeInsets(top: 8, left: 11, bottom: 8, right: 11)
        footprintsta.font = KKToolUtils.ubuntu_font(size: 12, weight: .bold)
        footprintsta.ss_borderWidth = 1
        footprintsta.ss_cornerRadius = 8
        addSubview(footprintsta)
        footprintsta.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-14)
            make.height.equalTo(34)
            make.centerY.equalTo(footprintimv)
        }
        self.footprintsta = footprintsta
        
        let footprinttable = SSLaboratoryTable()
        addSubview(footprinttable)
        footprinttable.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(14)
            make.right.equalToSuperview().offset(-14)
            make.bottom.equalToSuperview()
            make.top.equalTo(footprintimv.snp.bottom).offset(14)
            make.height.equalTo(0)
        }
        self.footprinttable = footprinttable
    }

}
