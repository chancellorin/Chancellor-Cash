//
//  SSSleuthCollectionCell.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/25.
//

import UIKit
import KKUtilsKitSwift
import PureLayout

class SSSleuthCollectionCell: UICollectionViewCell {
    
    weak var sleuthimv: UIImageView!
    weak var sleuthti: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        sleuth_stepui()
    }
    
    
    func sleuth_stepui() {
        backgroundColor = .clear
        
        let sleuthimv = UIImageView()
        contentView.addSubview(sleuthimv)
        sleuthimv.autoPinEdge(toSuperviewEdge: .top, withInset: 12)
        sleuthimv.autoSetDimensions(to: CGSize(width: 44, height: 44))
        sleuthimv.autoAlignAxis(toSuperviewAxis: .vertical)
        self.sleuthimv = sleuthimv
        
        let sleuthti = UILabel()
        sleuthti.textColor = KKToolUtils.color_from_hex("#FF888888")
        sleuthti.textAlignment = .center
        sleuthti.font = KKToolUtils.ubuntu_font(size: 11)
        contentView.addSubview(sleuthti)
        sleuthti.autoPinEdge(.top, to: .bottom, of: sleuthimv, withOffset: 7)
        sleuthti.autoPinEdge(toSuperviewEdge: .left)
        sleuthti.autoPinEdge(toSuperviewEdge: .right)
        sleuthti.autoSetDimension(.height, toSize: 15)
        self.sleuthti = sleuthti
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}
