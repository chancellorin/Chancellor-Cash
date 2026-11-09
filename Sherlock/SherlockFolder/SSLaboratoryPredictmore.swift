//
//  SSLaboratoryPredictmore.swift
//  Sherlock
//
//  Created by Sherlock on 2026/7/1.
//

import UIKit
import PureLayout

class SSLaboratoryPredictmore: UIView {
    
    let laboratoryinfo = SSLaboratoryPredictMoreinfo()
    let laboratoryamo = SSLaboratoryPredictMoreamo()
    let laboratoryselect = SSLaboratoryPredictMoreselect()
    let laboratorybank = SSLaboratoryPredictbank()
    
    var laborEvid = SSSherlocklistEvidence() {
        didSet {
            laboratoryinfo.laborEvid = laborEvid
            laboratoryamo.laborEvid = laborEvid
            laboratoryselect.laborEvid = laborEvid
        }
    }
    
    func laboratoryAddmoreinfo() {
        laboratoryinfo.laboratoryAddmoreinfo()
        if let laborba = laborEvid.bankCardList?.first {
            laboratorybank.evid = laborba
        }
    }
    
    var isLaborawithd = false {
        didSet {
            laboratoryamo.isLaborawithd = isLaborawithd
            laboratoryselect.isLaborawithd = isLaborawithd
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
        
        addSubview(laboratoryinfo)
        laboratoryinfo.autoPinEdge(toSuperviewEdge: .top, withInset: 10)
        laboratoryinfo.autoPinEdge(toSuperviewEdge: .left, withInset: 14)
        laboratoryinfo.autoPinEdge(toSuperviewEdge: .right, withInset: 14)
        
        addSubview(laboratoryamo)
        laboratoryamo.autoPinEdge(.top, to: .bottom, of: laboratoryinfo, withOffset: 10)
        laboratoryamo.autoPinEdge(.left, to: .left, of: laboratoryinfo)
        laboratoryamo.autoPinEdge(.right, to: .right, of: laboratoryinfo)
        
        laboratoryamo.laboratoryamoselect = { evid in
            self.laborEvid = evid
            self.laboratoryamoselect?(self.laborEvid)
        }
        
        addSubview(laboratoryselect)
        laboratoryselect.autoPinEdge(.top, to: .bottom, of: laboratoryamo, withOffset: 10)
        laboratoryselect.autoPinEdge(toSuperviewEdge: .left)
        laboratoryselect.autoPinEdge(toSuperviewEdge: .right)
        laboratoryselect.laboratoryterselect = { evid in
            self.laborEvid = evid
            self.laboratoryamoselect?(self.laborEvid)
        }
        
        addSubview(laboratorybank)
        laboratorybank.autoPinEdge(.top, to: .bottom, of: laboratoryselect, withOffset: 10)
        laboratorybank.autoPinEdge(.left, to: .left, of: laboratoryinfo)
        laboratorybank.autoPinEdge(.right, to: .right, of: laboratoryinfo)
        laboratorybank.autoPinEdge(toSuperviewEdge: .bottom)
    }


}
