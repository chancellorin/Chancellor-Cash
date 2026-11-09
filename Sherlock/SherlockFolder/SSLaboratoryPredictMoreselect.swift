//
//  SSLaboratoryPredictMoreselect.swift
//  Sherlock
//
//  Created by Sherlock on 2026/7/2.
//

import UIKit
import KKUtilsKitSwift
import SnapKit

class SSLaboratoryPredictMoreselect: UIView {
    
    weak var laboratorytip: UILabel!
    weak var laboratorycoll: SSLaboratoryPredictMoreselectColl!
    
    var laborRecomEvid = SSSherlockSergeantEvidence() {
        didSet {
            guard let recomEvid = laborRecomEvid.productTermV3Response else { return }
            laboratorytip.textColor = .white

            if recomEvid.amountDetailList?[recomEvid.amindex].termDetailList?.first?.EMIs ?? 0 > 1 {
                laboratorytip.text = "Select EMIs"
            }else {
                laboratorytip.text = "Select the loan tenure"
            }
            laboratorycoll.laborcollWidth = (UIScreen.main.bounds.width - 28 - 28 - 16)/3
            laboratorycoll.laborEvid = recomEvid.amountDetailList?[recomEvid.amindex] ?? SSSherlockSergeantEvidence()
            if let laborters = recomEvid.amountDetailList?[recomEvid.amindex].termDetailList {
                laboratorycoll.snp.updateConstraints { make in
                    make.height.equalTo((laborters.count + 2) / 3 * 42 + 4 * ((laborters.count + 2) / 3 - 1))
                }
            }
        }
    }
    
    var laborEvid = SSSherlocklistEvidence() {
        didSet {
            if laborEvid.amountDetailList?[laborEvid.amindex].termDetailList?.first?.EMIs ?? 0 > 1 {
                laboratorytip.text = "Select EMIs"
            }else {
                laboratorytip.text = "Select the loan tenure"
            }
            laboratorycoll.laborEvid = laborEvid.amountDetailList?[laborEvid.amindex] ?? SSSherlockSergeantEvidence()
            if let laborters = laborEvid.amountDetailList?[laborEvid.amindex].termDetailList {
                laboratorycoll.snp.updateConstraints { make in
                    make.height.equalTo((laborters.count + 2) / 3 * 42 + 4 * ((laborters.count + 2) / 3 - 1))
                }
            }
        }
    }
    
    var isLaborawithd = false {
        didSet {
            if isLaborawithd {
                laboratorytip.textColor = laboratorywithdColor
            }else {
                laboratorytip.textColor = laboratoryColor
            }
            laboratorycoll.isLaborawithd = isLaborawithd
        }
    }
    
    var laboratoryterselect: ((SSSherlocklistEvidence) -> Void)?
    var laboratoryRecomterselect: ((SSSherlockSergeantEvidence) -> Void)?


    override init(frame: CGRect) {
        super.init(frame: frame)
        laboratory_stepui()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        laboratory_stepui()
    }
    
    func laboratory_stepui() {
        
        let laboratorytip = UILabel()
        laboratorytip.textAlignment = .center
        laboratorytip.font = KKToolUtils.ubuntu_font(size: 11, weight: .bold)
        addSubview(laboratorytip)
        laboratorytip.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(11)
        }
        self.laboratorytip = laboratorytip
        
        let laboratorycoll = SSLaboratoryPredictMoreselectColl()
        addSubview(laboratorycoll)
        laboratorycoll.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(42)
            make.top.equalTo(laboratorytip.snp.bottom).offset(9)
        }
        self.laboratorycoll = laboratorycoll
        laboratorycoll.laboratoryamoselect = { [weak self] evids in
            guard let self = self else { return }
            if var labors = laborEvid.amountDetailList, laborEvid.amindex < labors.count {
                labors[laborEvid.amindex] = evids
                laborEvid.amountDetailList = labors
                self.laboratoryterselect?(self.laborEvid)
            }else if var labors = laborRecomEvid.productTermV3Response?.amountDetailList, let laborindex = laborRecomEvid.productTermV3Response?.amindex, laborindex < labors.count {
                labors[laborindex] = evids
                laborRecomEvid.productTermV3Response?.amountDetailList = labors
                self.laboratoryRecomterselect?(self.laborRecomEvid)
            }
        }
    }
        
}
