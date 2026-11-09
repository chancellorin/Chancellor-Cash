//
//  SSLaboratoryPredictMoreselectCollCell.swift
//  Sherlock
//
//  Created by Sherlock on 2026/7/2.
//

import UIKit
import KKUtilsKitSwift
import PureLayout

class SSLaboratoryPredictMoreselectCollCell: UICollectionViewCell {

    weak var laboratory: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        laboratory_stepui()
    }
    
    func laboratory_stepui() {
        
        contentView.ss_borderWidth = 1
        contentView.ss_cornerRadius = 12
        
        let laboratory = UILabel()
        laboratory.font = KKToolUtils.ubuntu_font(size: 13)
        laboratory.textColor = KKToolUtils.color_from_hex("#FF666666")
        laboratory.textAlignment = .center
        contentView.addSubview(laboratory)
        laboratory.autoPinEdgesToSuperviewEdges()
        self.laboratory = laboratory
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}
