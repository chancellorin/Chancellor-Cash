//
//  SSLaboratoryPredictRecomitem.swift
//  Sherlock
//
//  Created by Alien on 2026/10/23.
//

import UIKit
import KKUtilsKitSwift
import SnapKit
import PureLayout

class SSLaboratoryPredictRecomitem: UIView {

    weak var laboratoryimv: UIImageView!
    weak var laboratoryna: UILabel!
    weak var laboratorybtt: UIButton!
    weak var laboratoryamo: SSLaboratoryPredictRecomamo!
    
    let laboratoryTermselect = SSLaboratoryPredictMoreselect()
    
    let laboratoryramoti = UILabel()
    let laboratoryramo = UILabel()

    var laborEvid = SSSherlockSergeantEvidence() {
        didSet {
            laboratoryamo.laborRecomEvid = laborEvid
            laboratoryTermselect.laborRecomEvid = laborEvid
            laboratorybtt.isSelected = laborEvid.laboraselected
            guard let laborEvid = laborEvid.productTermV3Response else { return }
            if let laborters = laborEvid.amountDetailList?[laborEvid.amindex].termDetailList, let laborterindex = laborEvid.amountDetailList?[laborEvid.amindex].terindex {
                laboratoryramo.text = "₹\(KKToolUtils.format_amount(laborters[laborterindex].arrivalAmount))"
            }
        }
    }
    
    func laboratoryAddmoreinfo() {
        SSSherlockAnalysis.ss_sherlockimgv(lock: laborEvid.productLogo, on: laboratoryimv)
        laboratoryna.text = laborEvid.productName
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        laboratory_stepui()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        laboratory_stepui()
    }
    
    
    var laboratorychange: ((SSSherlockSergeantEvidence) -> Void)?
    var laboratoryselect: ((SSSherlockSergeantEvidence) -> Void)?
    
    func laboratory_stepui() {
        backgroundColor = KKToolUtils.color_from_hex("#FF161616")
        ss_cornerRadius = 18
        isUserInteractionEnabled = true
        
        let laboratoryimv = UIImageView()
        laboratoryimv.contentMode = .scaleAspectFill
        laboratoryimv.ss_cornerRadius = 12
        addSubview(laboratoryimv)
        laboratoryimv.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.left.equalToSuperview().offset(14)
            make.width.height.equalTo(40)
        }
        self.laboratoryimv = laboratoryimv
        
        let laboratoryna = UILabel()
        laboratoryna.font = KKToolUtils.ubuntu_font(size: 15, weight: .bold)
        laboratoryna.textColor = .white
        addSubview(laboratoryna)
        laboratoryna.snp.makeConstraints { make in
            make.top.equalTo(laboratoryimv)
            make.height.equalTo(22)
            make.left.equalTo(laboratoryimv.snp.right).offset(12)
        }
        self.laboratoryna = laboratoryna
        
        let laboratorydetail = UIButton(type: .custom, primaryAction: UIAction { [weak self] _ in
            guard let self = self, let laborEvid = laborEvid.productTermV3Response else { return }
            SSLaboratoryDetailPredict.sherlock_alert(SSLaboratoryDetailPredict(evid: laborEvid))
        })
        laboratorydetail.setTitleColor(KKToolUtils.color_from_hex("#555555"), for: .normal)
        laboratorydetail.titleLabel?.font = KKToolUtils.ubuntu_font(size: 11)
        laboratorydetail.setTitle("Loan details >>", for: .normal)
        addSubview(laboratorydetail)
        laboratorydetail.snp.makeConstraints { make in
            make.top.equalTo(laboratoryna.snp.bottom)
            make.bottom.equalTo(laboratoryimv)
            make.left.equalTo(laboratoryna)
            make.width.equalTo(85)
        }
        
        let laboratorybtt = UIButton(type: .custom)
        laboratorybtt.isUserInteractionEnabled = false
        laboratorybtt.isSelected = true
        laboratorybtt.setImage(.laboratoryPn, for: .normal)
        laboratorybtt.setImage(.laboratoryPs, for: .selected)
        addSubview(laboratorybtt)
        laboratorybtt.snp.makeConstraints { make in
            make.top.right.equalToSuperview().inset(14)
            make.width.height.equalTo(18)
        }
        self.laboratorybtt = laboratorybtt

        let laboratoryamo = SSLaboratoryPredictRecomamo()
        addSubview(laboratoryamo)
        laboratoryamo.snp.makeConstraints { make in
            make.top.equalTo(laboratoryimv.snp.bottom)
            make.left.right.equalToSuperview()
        }
        self.laboratoryamo = laboratoryamo
        laboratoryamo.laboratoryamoselect = { evid in
            self.laborEvid = evid
            self.laboratorychange?(self.laborEvid)
        }

        addSubview(laboratoryTermselect)
        laboratoryTermselect.autoPinEdge(.top, to: .bottom, of: laboratoryamo, withOffset: 6)
        laboratoryTermselect.autoPinEdge(toSuperviewEdge: .left)
        laboratoryTermselect.autoPinEdge(toSuperviewEdge: .right)
        laboratoryTermselect.laboratoryRecomterselect = { evid in
            self.laborEvid = evid
            self.laboratorychange?(self.laborEvid)
        }
        
        laboratoryramoti.font = KKToolUtils.ubuntu_font(size: 13)
        laboratoryramoti.textColor = KKToolUtils.color_from_hex("#555555")
        laboratoryramoti.text = "Amount received"
        addSubview(laboratoryramoti)
        laboratoryramoti.snp.makeConstraints { make in
            make.top.equalTo(laboratoryTermselect.snp.bottom).offset(12)
            make.height.equalTo(20)
            make.left.equalTo(laboratoryimv)
            make.bottom.equalToSuperview().inset(21)
        }
        
        laboratoryramo.font = KKToolUtils.ubuntu_font(size: 13, weight: .bold)
        laboratoryramo.textColor = KKToolUtils.color_from_hex("#AAFF00")
        addSubview(laboratoryramo)
        laboratoryramo.snp.makeConstraints { make in
            make.top.bottom.equalTo(laboratoryramoti)
            make.right.equalTo(laboratorybtt)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(labporaitemselect))
        tap.delegate = self
        addGestureRecognizer(tap)
    }
    
    @objc func labporaitemselect() {
        laborEvid.laboraselected = !laborEvid.laboraselected
        laboratoryselect?(laborEvid)
    }
    
}

extension SSLaboratoryPredictRecomitem: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view?.isDescendant(of: laboratoryTermselect) == true {
            return false
        }
        return true
    }
}
