//
//  SSLaboratoryDetailPredict.swift
//  Sherlock
//
//  Created by Alien on 2026/10/27.
//

import UIKit
import SnapKit
import KKUtilsKitSwift

class SSLaboratoryDetailPredict: SSSherlockPredict {
    
    let laboratorytable = SSLaboratoryTable()
    var laborEvid = SSSherlocklistEvidence()

    init(evid: SSSherlocklistEvidence) {
        super.init(frame: .zero)
        laborEvid = evid
        laboratory_stepui()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        laboratory_stepui()
    }
    
    func laboratory_stepui() {
        let laborti = UILabel()
        laborti.text = "Loan Details";
        laborti.textColor = KKToolUtils.color_from_hex("#AAAAAA")
        laborti.font = KKToolUtils.ubuntu_font(size: 13, weight: .bold)
        sherlockbgv.addSubview(laborti)
        laborti.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.left.right.equalToSuperview().inset(14)
            make.height.equalTo(20)
        }
        
        let laborbtt = UIButton(type: .custom, primaryAction: UIAction { _ in
            self.removeFromSuperview()
        })
        laborbtt.setImage(.laboratoryClose, for: .normal)
        sherlockbgv.addSubview(laborbtt)
        laborbtt.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 20, height: 20))
            make.right.equalToSuperview().inset(12)
            make.top.equalToSuperview().offset(15)
        }
        
        let laborline = UIView()
        laborline.backgroundColor = KKToolUtils.color_from_hex("#2A2A2A")
        sherlockbgv.addSubview(laborline)
        laborline.snp.makeConstraints { make in
            make.top.equalTo(laborti.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        
        if let termdex = laborEvid.amountDetailList?[laborEvid.amindex].terindex, let evid = laborEvid.amountDetailList?[laborEvid.amindex].termDetailList?[termdex] {
            laboratorytable.evids = SSSergeantNeed.sergeantEvidences(true, evid)
        }
        sherlockbgv.addSubview(laboratorytable)
        laboratorytable.snp.makeConstraints { make in
            make.right.left.equalToSuperview()
            make.top.equalTo(laborline.snp.bottom)
            make.height.equalTo(laboratorytable.evids.count * 38)
            make.bottom.equalToSuperview().inset(5)
        }
        
    }

}
