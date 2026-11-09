//
//  SSMoriartyPredict.swift
//  moriarty
//
//  Created by moriarty on 2026/6/30.
//

import UIKit
import SnapKit
import KKUtilsKitSwift

enum MoriartyType: Int {
    case moriartycam
    case moriartyloa
    case moriartycon
}

class SSMoriartyPredict: SSSherlockPredict {

    weak var moriartyimv: UIImageView!
    weak var moriartytip: UILabel!
    weak var moriartyti: UILabel!
    
    var moriartype: MoriartyType = .moriartycam {
        didSet {
            moriartyrefrash(moriartype)
        }
    }
    
    var moriarselect: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        moriarty_stepui()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        moriarty_stepui()
    }
    
    func moriarty_stepui() {
        sherlocklebtt.isHidden = false
        sherlockribtt.isHidden = false
        
        let moriartyimv = UIImageView()
        sherlockbgv.addSubview(moriartyimv)
        moriartyimv.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(26)
            make.left.equalToSuperview().offset(22)
            make.size.equalTo(CGSize(width: 44, height: 44))
        }
        self.moriartyimv = moriartyimv
        
        let moriartyti = UILabel()
        moriartyti.textColor = .white
        moriartyti.font = KKToolUtils.ubuntu_font(size: 17, weight: .bold)
        sherlockbgv.addSubview(moriartyti)
        moriartyti.snp.makeConstraints { make in
            make.top.bottom.equalTo(moriartyimv)
            make.left.equalTo(moriartyimv.snp.right).offset(12)
            make.right.equalToSuperview()
        }
        self.moriartyti = moriartyti
        
        let moriartytip = UILabel()
        moriartytip.textColor = KKToolUtils.color_from_hex("#666666")
        moriartytip.font = KKToolUtils.ubuntu_font(size: 13)
        moriartytip.numberOfLines = 0
        moriartytip.lineSpace()
        sherlockbgv.addSubview(moriartytip)
        moriartytip.snp.makeConstraints { make in
            make.top.equalTo(moriartyimv.snp.bottom).offset(27)
            make.left.equalToSuperview().offset(52)
            make.right.equalToSuperview().offset(-37)
            make.bottom.equalToSuperview().offset(-87)
        }
        self.moriartytip = moriartytip
        
        let moriartycirl = UIView()
        moriartycirl.backgroundColor = KKToolUtils.color_from_hex("#61AAFF00")
        moriartycirl.ss_cornerRadius = 2.5
        sherlockbgv.addSubview(moriartycirl)
        moriartycirl.snp.makeConstraints { make in
            make.top.equalTo(moriartytip).offset(10)
            make.left.equalToSuperview().offset(37)
            make.size.equalTo(CGSize(width: 5, height: 5))
        }
    }
    
    
    override func sherlocklebttap() {
        moriartylebttapd()
    }
    
    override func sherlockribttap() {
        moriartyribttapd()
    }

}
