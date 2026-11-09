//
//  SSLaboratoryPredict.swift
//  Sherlock
//
//  Created by Sherlock on 2026/7/1.
//

import UIKit
import SnapKit
import KKUtilsKitSwift

class SSLaboratoryPredict: UIScrollView {
    
    var laborEvid = SSSherlocklistEvidence()
    
    weak var laboratoryonce: SSLaboratoryPredictonce?
    weak var laboratorymore: SSLaboratoryPredictmore?
    
    weak var laboratoryrecom: SSLaboratoryPredictRecom?

    let laboratorytable = SSLaboratoryTable()
    let laboratorytip = SSLabel()
    
    var isLaborawithd = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func laboratory_stepui() {
        if isLaborawithd {
            if laborEvid.amountDetailList?.count ?? 0 > 1 || laborEvid.amountDetailList?.first?.termDetailList?.count ?? 0 > 1 {
                let laboratorymore = SSLaboratoryPredictmore()
                laboratorymore.laborEvid = laborEvid
                laboratorymore.laboratoryAddmoreinfo()
                addSubview(laboratorymore)
                laboratorymore.snp.makeConstraints { make in
                    make.top.left.right.equalToSuperview()
                    make.centerX.equalToSuperview()
                }
                self.laboratorymore = laboratorymore
                laboratorymore.laboratoryamoselect = { [weak self] evid in
                    guard let self = self else { return }
                    laborEvid = evid
                    if let termdex = laborEvid.amountDetailList?[laborEvid.amindex].terindex, let eviditem = laborEvid.amountDetailList?[laborEvid.amindex].termDetailList?[termdex] {
                        laboratorytable.evids = SSSergeantNeed.sergeantEvidences(true, eviditem)
                        laboratorytable.reloadData()
                    }
                    laboratorytable.snp.updateConstraints { make in
                        make.height.equalTo(self.laboratorytable.evids.count * 38)
                    }
                }
            }else {
                let laboratoryonce = SSLaboratoryPredictonce()
                laboratoryonce.laborEvid = laborEvid
                addSubview(laboratoryonce)
                laboratoryonce.snp.makeConstraints { make in
                    make.top.left.right.equalToSuperview()
                    make.centerX.equalToSuperview()
                }
                self.laboratoryonce = laboratoryonce
            }
            
            
            laboratorymore?.isLaborawithd = isLaborawithd
            laboratoryonce?.isLaborawithd = isLaborawithd
            
            if let termdex = laborEvid.amountDetailList?[laborEvid.amindex].terindex, let evid = laborEvid.amountDetailList?[laborEvid.amindex].termDetailList?[termdex] {
                laboratorytable.evids = SSSergeantNeed.sergeantEvidences(true, evid)
            }
        }else {
            let laboratoryrecom = SSLaboratoryPredictRecom()
            laboratoryrecom.laborEvid = laborEvid
            laboratoryrecom.laborAddRecomitem()
            addSubview(laboratoryrecom)
            laboratoryrecom.snp.makeConstraints { make in
                make.top.left.right.equalToSuperview().inset(14)
                make.centerX.equalToSuperview()
            }
            self.laboratoryrecom = laboratoryrecom
            laboratorytable.evids = SSSergeantNeed.laboratoryEvidences(laborEvid)
            laboratoryrecom.laboratorychange = { [weak self] evid in
                guard let self = self else { return }
                self.laborEvid = evid ?? SSSherlocklistEvidence()
                self.laboratorytable.evids = SSSergeantNeed.laboratoryEvidences(self.laborEvid)
                laboratorytable.reloadData()
            }
        }

        addSubview(laboratorytable)
        laboratorytable.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(14)
            make.right.equalToSuperview().offset(-14)
            make.top.equalTo(laboratoryonce?.snp.bottom ?? laboratorymore?.snp.bottom ?? laboratoryrecom?.snp.bottom ?? self).offset(10)
            make.height.equalTo(laboratorytable.evids.count * 38)
        }
        
        laboratorytip.font = KKToolUtils.ubuntu_font(size: 12)
        laboratorytip.numberOfLines = 0
        laboratorytip.textColor = KKToolUtils.color_from_hex("#FF666666")
        laboratorytip.ss_borderWidth = 1
        laboratorytip.ss_cornerRadius = 12
        laboratorytip.textInsets = UIEdgeInsets(top: 11, left: 13, bottom: 11, right: 13)
        addSubview(laboratorytip)
        laboratorytip.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(14)
            make.right.equalToSuperview().offset(-14)
            make.top.equalTo(laboratorytable.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        if isLaborawithd {
            laboratorytip.text = "Please log in your account to confirm the order so that we can transfer the funds to your bank account."
            laboratorytip.backgroundColor = KKToolUtils.color_from_hex("#0A00CCBB")
            laboratorytip.ss_borderColor = KKToolUtils.color_from_hex("#3000CCBB")
        }else {
            laboratorytip.text = "A high credit score leads to a higher loan amount. Maintain your credit to enjoy a larger loan limit."
            laboratorytip.backgroundColor = KKToolUtils.color_from_hex("#0AAAFF00")
            laboratorytip.ss_borderColor = KKToolUtils.color_from_hex("#21AAFF00")
        }
        
    }

}
