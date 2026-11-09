//
//  SSLaboratoryPredictMoreamo.swift
//  Sherlock
//
//  Created by Sherlock on 2026/7/2.
//

import UIKit
import KKUtilsKitSwift
import PureLayout

class SSLaboratoryPredictMoreamo: UIView {

    weak var laboratorylefbtt: UIButton!
    weak var laboratoryrigbtt: UIButton!
    weak var laboratoryamo: UILabel!
    weak var laboratoryamorange: UILabel!
    weak var laboratorytip: UILabel!

    var laborEvid = SSSherlocklistEvidence() {
        didSet {
            laboratoryamo.text = "₹\(KKToolUtils.format_amount(laborEvid.amountDetailList?[laborEvid.amindex].loanAmount))"
            if laborEvid.amountDetailList?.count ?? 0 > 1 {
                laboratoryamorange.text = "₹\(KKToolUtils.format_amount(laborEvid.amountDetailList?[(laborEvid.amountDetailList?.count ?? 1) - 1].loanAmount)) - ₹\(KKToolUtils.format_amount(laborEvid.amountDetailList?[laborEvid.amindex].loanAmount))"
            }else {
                laboratoryamorange.text = "₹\(KKToolUtils.format_amount(laborEvid.amountDetailList?[laborEvid.amindex].loanAmount))"
            }
            laboratorylefbtt.isHidden = false
            laboratoryrigbtt.isHidden = false
            if laborEvid.amindex <= 0 {
                laboratoryrigbtt.isHidden = true
            }
            if laborEvid.amindex >= (laborEvid.amountDetailList?.count ?? 1) - 1 {
                laboratorylefbtt.isHidden = true
            }
        }
    }
    
    var isLaborawithd = false {
        didSet {
            if isLaborawithd {
                laboratorylefbtt.setImage(.laboratoryReduceW, for: .normal)
                laboratoryrigbtt.setImage(.laboratoryPlusW, for: .normal)
                laboratorytip.textColor = laboratorywithdColor
            }else {
                laboratorylefbtt.setImage(.laboratoryReduce, for: .normal)
                laboratoryrigbtt.setImage(.laboratoryPlus, for: .normal)
                laboratorytip.textColor = laboratoryColor
            }
        }
    }
    
    var laboratoryamoselect: ((SSSherlocklistEvidence) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        laboratory_stepui()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        laboratory_stepui()
    }
    
    func laboratory_stepui() {
        backgroundColor = KKToolUtils.color_from_hex("#FF161616")
        ss_cornerRadius = 18
        
        let laboratorytip = UILabel()
        laboratorytip.text = "Tips: Select loan amount first"
        laboratorytip.font = KKToolUtils.ubuntu_font(size: 11, weight: .bold)
        addSubview(laboratorytip)
        laboratorytip.autoPinEdge(toSuperviewEdge: .left, withInset: 14)
        laboratorytip.autoPinEdge(toSuperviewEdge: .top, withInset: 15)
        laboratorytip.autoSetDimension(.height, toSize: 17)
        self.laboratorytip = laboratorytip
        
        let laboratorylefbtt = UIButton(type: .custom, primaryAction: UIAction { [weak self] _ in
            guard let self = self else { return }
            if var labors = laborEvid.amountDetailList, laborEvid.amindex < labors.count {
                labors[laborEvid.amindex].terindex = 0
                laborEvid.amountDetailList = labors
            }
            laborEvid.amindex += 1
            laboratoryamoselect?(laborEvid)
        })
        addSubview(laboratorylefbtt)
        laboratorylefbtt.autoPinEdge(toSuperviewEdge: .left, withInset: 5)
        laboratorylefbtt.autoSetDimensions(to: CGSize(width: 60, height: 60))
        laboratorylefbtt.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10)
        laboratorylefbtt.autoPinEdge(.top, to: .bottom, of: laboratorytip, withOffset: 10)

        self.laboratorylefbtt = laboratorylefbtt
        
        let laboratoryrigbtt = UIButton(type: .custom, primaryAction: UIAction { [weak self] _ in
            guard let self = self else { return }
            if var labors = laborEvid.amountDetailList, laborEvid.amindex < labors.count {
                labors[laborEvid.amindex].terindex = 0
                laborEvid.amountDetailList = labors
            }
            self.laborEvid.amindex -= 1
            self.laboratoryamoselect?(self.laborEvid)
        })
        addSubview(laboratoryrigbtt)
        laboratoryrigbtt.autoPinEdge(toSuperviewEdge: .right, withInset: 5)
        laboratoryrigbtt.autoSetDimensions(to: CGSize(width: 60, height: 60))
        laboratoryrigbtt.autoPinEdge(.bottom, to: .bottom, of: laboratorylefbtt)
        self.laboratoryrigbtt = laboratoryrigbtt
        
        let laboratoryamo = UILabel()
        laboratoryamo.textColor = .white
        laboratoryamo.textAlignment = .center
        laboratoryamo.font = KKToolUtils.ubuntu_font(size: 30, weight: .bold)
        laboratoryamo.text = "₹"
        addSubview(laboratoryamo)
        laboratoryamo.autoPinEdge(.top, to: .top, of: laboratorylefbtt)
        laboratoryamo.autoPinEdge(.left, to: .right, of: laboratorylefbtt, withOffset: 10)
        laboratoryamo.autoPinEdge(.right, to: .left, of: laboratoryrigbtt, withOffset: -10)
        laboratoryamo.autoSetDimension(.height, toSize: 45)
        self.laboratoryamo = laboratoryamo
        
        let laboratoryamorange = UILabel()
        laboratoryamorange.textColor = KKToolUtils.color_from_hex("#FF444444")
        laboratoryamorange.textAlignment = .center
        laboratoryamorange.font = KKToolUtils.ubuntu_font(size: 11)
        laboratoryamorange.text = "₹ - ₹"
        addSubview(laboratoryamorange)
        laboratoryamorange.autoPinEdge(.left, to: .left, of: laboratoryamo)
        laboratoryamorange.autoPinEdge(.right, to: .right, of: laboratoryamo)
        laboratoryamorange.autoPinEdge(.top, to: .bottom, of: laboratoryamo, withOffset: 1)
        laboratoryamorange.autoSetDimension(.height, toSize: 17)
        self.laboratoryamorange = laboratoryamorange
    }

}
