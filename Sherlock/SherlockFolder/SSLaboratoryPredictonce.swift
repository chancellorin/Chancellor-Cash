//
//  SSLaboratoryPredictonce.swift
//  Sherlock
//
//  Created by Sherlock on 2026/7/2.
//

import UIKit
import KKUtilsKitSwift
import SnapKit

class SSLaboratoryPredictonce: UIView {

    weak var laboratorybgv: UIView!
    weak var laboratoryline: UIView!
    weak var laboratoryimv: UIImageView!
    weak var laboratoryna: UILabel!
    weak var laboratorysta: SSLabel!
    weak var laboratoryamo: SSLaboratoryPredictOnceitem!
    weak var laboratoryter: SSLaboratoryPredictOnceitem!
    weak var laboratorybank: SSLaboratoryPredictbank!
    
    var isLaborawithd = false {
        didSet {
            laboratorysta.isHidden = !isLaborawithd
        }
    }
    
    var laborEvid = SSSherlocklistEvidence() {
        didSet {
            SSSherlockAnalysis.ss_sherlockimgv(lock: laborEvid.productLogo, on: laboratoryimv)
            laboratoryna.text = laborEvid.productName
            SSSergeantNeed.sergeantColorstring(isLaborawithd ? 32 : 0) { color, bgcolor in
                self.laboratorysta.textColor = KKToolUtils.color_from_hex(color)
                self.laboratorysta.backgroundColor = KKToolUtils.color_from_hex(bgcolor)
                self.laboratorysta.ss_borderColor = KKToolUtils.color_from_hex("45\(color)")
                self.laboratoryline.ss_horizontalGradient(color)
            } staterult: { rult in
                self.laboratorysta.text = rult
            }
            laboratoryamo.laboratoryti.text = "Loan amount"
            if let laboram = laborEvid.amountDetailList?[laborEvid.amindex] {
                laboratoryamo.laboratorylue.text = "₹\(KKToolUtils.format_amount(laboram.loanAmount))"
                if let laborter = laborEvid.amountDetailList?[laborEvid.amindex].termDetailList?.first {
                    if laborter.EMIs ?? 0 > 1 {
                        laboratoryter.laboratoryti.text = "EMIs"
                        laboratoryter.laboratorylue.text = "\(laborter.EMIs ?? 0)"
                    }else {
                        laboratoryter.laboratoryti.text = "Loan tenure"
                        laboratoryter.laboratorylue.text = laborter.showTerm
                        laboratoryter.laboratoryuni.isHidden = false
                    }
                }
            }
            laboratorybank.isHidden = false
            if let newsb = laborEvid.bankCardList?.first {
                laboratorybank.evid = newsb
            }
            laboratorybgv.snp.updateConstraints { make in
                make.bottom.equalToSuperview().offset(-(10+46))
            }
        }
    }
    
    var newspaperEvid = SSSherlockNewspaperEvidence() {
        didSet {
            SSSherlockAnalysis.ss_sherlockimgv(lock: newspaperEvid.product?.productLogo, on: laboratoryimv)
            laboratoryna.text = newspaperEvid.product?.productName
            laboratorysta.isHidden = false
            SSSergeantNeed.sergeantColorstring(newspaperEvid.orderDetail?.orderStatus) { color, bgcolor in
                self.laboratorysta.textColor = KKToolUtils.color_from_hex(color)
                self.laboratorysta.backgroundColor = KKToolUtils.color_from_hex(bgcolor)
                self.laboratorysta.ss_borderColor = KKToolUtils.color_from_hex("45\(color)")
                self.laboratoryline.ss_horizontalGradient(color)
            } staterult: { rult in
                self.laboratorysta.text = rult
            }
            
            laboratoryamo.laboratoryti.text = "Loan amount"
            laboratoryamo.laboratorylue.text = "₹\(KKToolUtils.format_amount(newspaperEvid.orderDetail?.loanAmount))"
            laboratoryter.laboratoryti.text = "Loan tenure"
            laboratoryter.laboratorylue.text = newspaperEvid.orderDetail?.showTerm
            laboratoryter.laboratoryuni.isHidden = false
            
            if newspaperEvid.orderDetail?.orderStatus != 31, newspaperEvid.orderDetail?.orderStatus != 99 {
                laboratorybank.isHidden = false
                if let newsb = newspaperEvid.bankCard {
                    laboratorybank.evid = newsb
                }
                laboratorybgv.snp.updateConstraints { make in
                    make.bottom.equalToSuperview().offset(-(10+46))
                }
            }else {
                laboratorybank.isHidden = true
                laboratorybgv.snp.updateConstraints { make in
                    make.bottom.equalToSuperview().offset(-10)
                }
            }
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        laboratory_stepui()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        laboratory_stepui()
    }
    
    func laboratory_stepui() {
        
        let laboratorybgv = UIView()
        laboratorybgv.backgroundColor = KKToolUtils.color_from_hex("#FF161616")
        laboratorybgv.ss_cornerRadius = 18
        addSubview(laboratorybgv)
        laboratorybgv.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(14)
            make.right.equalToSuperview().offset(-14)
            make.bottom.equalToSuperview().offset(-10)
        }
        self.laboratorybgv = laboratorybgv

        let laboratoryline = UIView()
//        laboratoryline.ss_horizontalGradient("AAFF00")
        laboratorybgv.addSubview(laboratoryline)
        laboratoryline.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(3)
        }
        self.laboratoryline = laboratoryline
        
        let laboratoryimv = UIImageView()
        laboratoryimv.contentMode = .scaleAspectFill
        laboratoryimv.ss_cornerRadius = 12
        laboratorybgv.addSubview(laboratoryimv)
        laboratoryimv.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.left.equalToSuperview().offset(14)
            make.width.height.equalTo(40)
        }
        self.laboratoryimv = laboratoryimv
        
        let laboratoryna = UILabel()
        laboratoryna.font = KKToolUtils.ubuntu_font(size: 15, weight: .bold)
        laboratoryna.textColor = .white
        laboratorybgv.addSubview(laboratoryna)
        laboratoryna.snp.makeConstraints { make in
            make.top.bottom.equalTo(laboratoryimv)
            make.left.equalTo(laboratoryimv.snp.right).offset(12)
        }
        self.laboratoryna = laboratoryna
        
        let laboratorysta = SSLabel()
        laboratorysta.textInsets = UIEdgeInsets(top: 8, left: 11, bottom: 8, right: 11)
        laboratorysta.isHidden = true
        laboratorysta.font = KKToolUtils.ubuntu_font(size: 12, weight: .bold)
        laboratorysta.ss_borderWidth = 1
        laboratorysta.ss_cornerRadius = 8
        laboratorybgv.addSubview(laboratorysta)
        laboratorysta.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-14)
            make.height.equalTo(34)
            make.centerY.equalTo(laboratoryimv)
        }
        self.laboratorysta = laboratorysta
        
        let laboratoryitemv = UIView()
        laboratoryitemv.backgroundColor = KKToolUtils.color_from_hex("#FF1A1A1A")
        laboratoryitemv.ss_cornerRadius = 12
        laboratorybgv.addSubview(laboratoryitemv)
        laboratoryitemv.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(14)
            make.right.equalToSuperview().offset(-14)
            make.top.equalTo(laboratoryimv.snp.bottom).offset(14)
            make.bottom.equalToSuperview().offset(-14)
            make.height.equalTo(70)
        }
        
        let laboratoryitline = UIView()
        laboratoryitline.backgroundColor = KKToolUtils.color_from_hex("#FF252525")
        laboratoryitemv.addSubview(laboratoryitline)
        laboratoryitline.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(1)
            make.centerX.equalToSuperview()
        }
        
        let laboratoryamo = SSLaboratoryPredictOnceitem()
        laboratoryitemv.addSubview(laboratoryamo)
        laboratoryamo.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.right.equalTo(laboratoryitline.snp.left)
        }
        self.laboratoryamo = laboratoryamo
        
        let laboratoryter = SSLaboratoryPredictOnceitem()
        laboratoryitemv.addSubview(laboratoryter)
        laboratoryter.snp.makeConstraints { make in
            make.right.top.bottom.equalToSuperview()
            make.left.equalTo(laboratoryitline.snp.right)
        }
        self.laboratoryter = laboratoryter
        
        let laboratorybank = SSLaboratoryPredictbank()
        laboratorybank.isHidden = true
        addSubview(laboratorybank)
        laboratorybank.snp.makeConstraints { make in
            make.top.equalTo(laboratorybgv.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(14)
            make.right.equalToSuperview().offset(-14)
        }
        self.laboratorybank = laboratorybank
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        laboratoryline.ss_updateHorizontalGradientFrame()
    }

}
