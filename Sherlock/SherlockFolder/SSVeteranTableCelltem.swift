//
//  SSVeteranTableCelltem.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/29.
//

import UIKit
import KKUtilsKitSwift
import SnapKit

class SSVeteranTableCelltem: UIView {
    
    var vetEvid: SSSherlockDiplomatEvidence = SSSherlockDiplomatEvidence() {
        didSet {
            veterantinfo.text = vetEvid.diptant ?? vetEvid.itemName
            veterantinfo.textColor = (vetEvid.diptant ?? "").isEmpty ? .white : KKToolUtils.color_from_hex("#FFCCCCCC")
        }
    }
    
    var veteranselect: (() -> Void)?

    var veteranshipimv = UIImageView(image: .veteranChship)
    var veterantactimv = UIImageView(image: .veteranCh)
    var veterantinfo = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        veteran_stepui()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        veteran_stepui()
    }
    
    func veteran_stepui() {
        backgroundColor = KKToolUtils.color_from_hex("#FF1C1C1C")
        ss_borderColor = KKToolUtils.color_from_hex("#FF3C3C3C")
        ss_borderWidth = 1
        ss_cornerRadius = 12
        
        veteranshipimv.isHidden = true
        addSubview(veteranshipimv)
        veteranshipimv.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 14, height: 14))
            make.right.equalToSuperview().offset(-13)
            make.centerY.equalToSuperview()
        }
        
        veterantactimv.isHidden = true
        addSubview(veterantactimv)
        veterantactimv.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 28, height: 28))
            make.right.equalToSuperview().offset(-13)
            make.centerY.equalToSuperview()
        }
        
        veterantinfo.textColor = .white
        veterantinfo.font = KKToolUtils.ubuntu_font(size: 12, weight: .bold)
        addSubview(veterantinfo)
        veterantinfo.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(13)
            make.right.equalToSuperview().offset(-45)

        }
        
        let veterantbtt = UIButton(type: .custom, primaryAction: UIAction { _ in
            self.veteranselect?()
        })
        addSubview(veterantbtt)
        veterantbtt.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }

}
