//
//  SSNewspaperPredict.swift
//  Sherlock
//
//  Created by Sherlock on 2026/7/2.
//

import UIKit
import KKUtilsKitSwift
import SnapKit

class SSNewspaperPredict: UIScrollView {

    let newspaperonce = SSLaboratoryPredictonce()
    let newspapertable = SSLaboratoryTable()
    let newspaperupi = SSLaboratoryLabel()
    let newspapertip = SSLabel()

    var newspaperEvid = SSSherlockNewspaperEvidence() {
        didSet {
            newspaperonce.newspaperEvid = newspaperEvid
            SSSergeantNeed.sergeantColorstring(newspaperEvid.orderDetail?.orderStatus) { color, bgcolor in
                self.newspapertip.backgroundColor = KKToolUtils.color_from_hex("0D\(color)")
                self.newspapertip.ss_borderColor = KKToolUtils.color_from_hex("30\(color)")
            } tiprult: { rult in
                self.newspapertip.text = rult
            }
            newspapertable.evids = SSSergeantNeed.sergeantEvidences(false, newspaperEvid.orderDetail)
            newspapertable.reloadData()
            newspapertable.snp.updateConstraints { make in
                make.height.equalTo(38*newspapertable.evids.count)
            }
            newspaperupi.newspaperEvid = newspaperEvid
            if newspaperEvid.orderDetail?.orderStatus != 60, newspaperEvid.orderDetail?.orderStatus != 61 {
                newspapertip.snp.updateConstraints { make in
                    make.top.equalTo(newspaperupi.snp.bottom).offset(-22)
                }
            }else {
                newspapertip.snp.updateConstraints { make in
                    make.top.equalTo(newspaperupi.snp.bottom).offset(10)
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        newspaper_stepui()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        newspaper_stepui()
    }
    
    func newspaper_stepui() {

        addSubview(newspaperonce)
        newspaperonce.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        addSubview(newspapertable)
        newspapertable.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(14)
            make.right.equalToSuperview().offset(-14)
            make.top.equalTo(newspaperonce.snp.bottom).offset(10)
            make.height.equalTo(0)
        }
        
        addSubview(newspaperupi)
        newspaperupi.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(14)
            make.right.equalToSuperview().offset(-14)
            make.top.equalTo(newspapertable.snp.bottom).offset(10)
        }
        
        newspapertip.font = KKToolUtils.ubuntu_font(size: 12)
        newspapertip.numberOfLines = 0
        newspapertip.textColor = KKToolUtils.color_from_hex("#FF666666")
        newspapertip.ss_borderWidth = 1
        newspapertip.ss_cornerRadius = 12
        newspapertip.textInsets = UIEdgeInsets(top: 11, left: 13, bottom: 11, right: 13)
        addSubview(newspapertip)
        newspapertip.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(14)
            make.right.equalToSuperview().offset(-14)
            make.top.equalTo(newspaperupi.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-20)
        }

    }
}
