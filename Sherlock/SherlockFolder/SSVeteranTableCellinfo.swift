//
//  SSVeteranTableCellinfo.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/29.
//

import UIKit
import SnapKit

class SSVeteranTableCellinfo: UIView {
    
    var vetEvidre: SSSherlockDiplomatEvidence = SSSherlockDiplomatEvidence() {
        didSet {
            veteranship.vetEvid = vetEvidre
        }
    }
    
    var vetEvidna: SSSherlockDiplomatEvidence = SSSherlockDiplomatEvidence() {
        didSet {
            veteranna.vetEvid = vetEvidna
        }
    }
    
    var vetEvidph: SSSherlockDiplomatEvidence = SSSherlockDiplomatEvidence() {
        didSet {
            veteranne.vetEvid = vetEvidph
        }
    }
    
    weak var veteranship: SSVeteranTableCelltem!
    weak var veteranna: SSVeteranTableCelltem!
    weak var veteranne: SSVeteranTableCelltem!

    var veteranselectact: (() -> Void)?
    var veteranselectinfo: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        veteran_stepui()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        veteran_stepui()
    }
    
    func veteran_stepui() {
        let veteranship = SSVeteranTableCelltem()
        veteranship.veteranshipimv.isHidden = false
        addSubview(veteranship)
        veteranship.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(14)
            make.right.equalToSuperview().offset(-14)
            make.top.equalToSuperview().offset(12)
            make.height.equalTo(44)
        }
        self.veteranship = veteranship
        veteranship.veteranselect = { [weak self] in
            self?.veteranselectact?()
        }
        
        let veteranna = SSVeteranTableCelltem()
        veteranna.veterantactimv.isHidden = false
        addSubview(veteranna)
        veteranna.snp.makeConstraints { make in
            make.left.right.height.equalTo(veteranship)
            make.top.equalTo(veteranship.snp.bottom).offset(10)
        }
        self.veteranna = veteranna
        veteranna.veteranselect = { [weak self] in
            self?.veteranselectinfo?()
        }
        
        let veteranne = SSVeteranTableCelltem()
        veteranne.veterantactimv.isHidden = false
        addSubview(veteranne)
        veteranne.snp.makeConstraints { make in
            make.left.right.height.equalTo(veteranship)
            make.top.equalTo(veteranna.snp.bottom).offset(10)
        }
        self.veteranne = veteranne
        veteranne.veteranselect = { [weak self] in
            self?.veteranselectinfo?()
        }
    }

}
