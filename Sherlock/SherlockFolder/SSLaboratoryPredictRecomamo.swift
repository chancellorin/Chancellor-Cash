//
//  SSLaboratoryPredictRecomamo.swift
//  Sherlock
//
//  Created by Alien on 2026/10/23.
//

import UIKit
import KKUtilsKitSwift
import PureLayout

class SSLaboratoryPredictRecomamo: UIView {

    weak var laboratorylefbtt: UIButton!
    weak var laboratoryrigbtt: UIButton!
    weak var laboratoryamo: UILabel!
    weak var laboratorytip: UILabel!
    
    var laborRecomEvid = SSSherlockSergeantEvidence() {
        didSet {
            guard let recomEvid = laborRecomEvid.productTermV3Response else { return }
            laboratoryamo.text = "₹\(KKToolUtils.format_amount(recomEvid.amountDetailList?[recomEvid.amindex].loanAmount))"
            if recomEvid.amountDetailList?.count ?? 0 <= 1 {
                laboratoryrigbtt.isHidden = true
                laboratorylefbtt.isHidden = true
            }else {
                laboratoryrigbtt.isHidden = false
                laboratorylefbtt.isHidden = false
                if recomEvid.amindex <= 0 {
                    laboratorylefbtt.isHidden = true
                }
                if recomEvid.amindex >= (recomEvid.amountDetailList?.count ?? 1) - 1 {
                    laboratoryrigbtt.isHidden = true
                }
            }
        }
    }
    
    var laboratoryamoselect: ((SSSherlockSergeantEvidence) -> Void)?
    
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
        laboratorytip.text = "Tips: Select loan amount first"
        laboratorytip.font = KKToolUtils.ubuntu_font(size: 11, weight: .bold)
        addSubview(laboratorytip)
        laboratorytip.autoPinEdge(toSuperviewEdge: .left, withInset: 14)
        laboratorytip.autoPinEdge(toSuperviewEdge: .top, withInset: 10)
        laboratorytip.autoSetDimension(.height, toSize: 17)
        self.laboratorytip = laboratorytip
        
        let laboratorylefbtt = UIButton(type: .custom, primaryAction: UIAction { [weak self] _ in
            guard let self = self else { return }
            guard var recomEvid = laborRecomEvid.productTermV3Response else { return }
            if var labors = recomEvid.amountDetailList, recomEvid.amindex < labors.count, let labterms = labors[recomEvid.amindex].termDetailList {
                labors[recomEvid.amindex].terindex = labterms.count - 1
                recomEvid.amountDetailList = labors
            }
            recomEvid.amindex -= 1
            laborRecomEvid.productTermV3Response = recomEvid
            laboratoryamoselect?(laborRecomEvid)
        })
        addSubview(laboratorylefbtt)
        laboratorylefbtt.autoPinEdge(toSuperviewEdge: .left, withInset: 5)
        laboratorylefbtt.autoSetDimensions(to: CGSize(width: 60, height: 60))
        laboratorylefbtt.autoPinEdge(toSuperviewEdge: .bottom, withInset: 16)
        laboratorylefbtt.autoPinEdge(.top, to: .bottom, of: laboratorytip, withOffset: 10)

        self.laboratorylefbtt = laboratorylefbtt
        
        let laboratoryrigbtt = UIButton(type: .custom, primaryAction: UIAction { [weak self] _ in
            guard let self = self else { return }
            guard var recomEvid = laborRecomEvid.productTermV3Response else { return }
            if var labors = recomEvid.amountDetailList, recomEvid.amindex < labors.count, let labterms = labors[recomEvid.amindex].termDetailList {
                labors[recomEvid.amindex].terindex = labterms.count - 1
                recomEvid.amountDetailList = labors
            }
            recomEvid.amindex += 1
            laborRecomEvid.productTermV3Response = recomEvid
            laboratoryamoselect?(laborRecomEvid)
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
        laboratoryamo.autoPinEdge(.bottom, to: .bottom, of: laboratorylefbtt)
        self.laboratoryamo = laboratoryamo
        
        laboratorylefbtt.setImage(.laboratoryReduce, for: .normal)
        laboratoryrigbtt.setImage(.laboratoryPlus, for: .normal)
        laboratorytip.textColor = laboratoryColor
    }

}
