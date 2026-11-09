//
//  SSLaboratoryPredictRecom.swift
//  Sherlock
//
//  Created by Alien on 2026/10/23.
//

import UIKit

class SSLaboratoryPredictRecom: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.axis = .vertical
        self.spacing = 10
        self.distribution = .equalSpacing
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var laborEvid: SSSherlocklistEvidence?
    var laboratorychange: ((SSSherlocklistEvidence?) -> Void)?

    func laborAddRecomitem() {
        if let laborEvid = laborEvid, var evidPlist = laborEvid.productInfoList {
            for i in evidPlist.indices {
                let laboritem = SSLaboratoryPredictRecomitem()
                laboritem.laborEvid = evidPlist[i]
                laboritem.laboratoryAddmoreinfo()
                addArrangedSubview(laboritem)
                laboritem.laboratorychange = { laevid in
                    evidPlist[i] = laevid
                    self.laborEvid?.productInfoList = evidPlist
                    self.laboratorychange?(self.laborEvid)
                }
                laboritem.laboratoryselect = { laevid in
                    evidPlist[i] = laevid
                    self.laborEvid?.productInfoList = evidPlist
                    self.laboratorychange?(self.laborEvid)
                }
            }
            let laboratorybank = SSLaboratoryPredictbank()
            if let laborba = evidPlist.first?.productTermV3Response?.bankCardList?.first {
                laboratorybank.evid = laborba
            }
            addArrangedSubview(laboratorybank)
        }
    }

}
