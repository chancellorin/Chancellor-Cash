//
//  SSClientPredictlink.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/25.
//

import UIKit
import KKUtilsKitSwift
import SnapKit

class SSClientPredictlink: UIView {
    
    weak var clientli: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        client_stepui()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        client_stepui()
    }
    
    func client_stepui() {
        let clientti = UILabel()
        clientti.text = "Official Website Link"
        clientti.textColor = KKToolUtils.color_from_hex("#FFBBBBBB")
        clientti.font = KKToolUtils.ubuntu_font(size: 13, weight: .bold)
        addSubview(clientti)
        clientti.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(14)
            make.height.equalTo(20)
        }
        
        let clientv = UIView()
        clientv.backgroundColor = KKToolUtils.color_from_hex("#FF1C1C1C")
        clientv.ss_borderColor = KKToolUtils.color_from_hex("#FF2A2A2A")
        clientv.ss_borderWidth = 1
        clientv.ss_cornerRadius = 14
        addSubview(clientv)
        clientv.snp.makeConstraints { make in
            make.top.equalTo(clientti.snp.bottom).offset(7)
            make.left.equalTo(14)
            make.right.equalTo(-14)
            make.height.equalTo(54)
            make.bottom.equalTo(-4)
        }
        
        let clientimv = UIImageView(image: .clientWs)
        clientv.addSubview(clientimv)
        clientimv.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        
        let clientbton = UIButton(type: .custom, primaryAction: UIAction { _ in
            UIPasteboard.general.string = self.clientli.text
            SSSherlockDeduce.ss_deduce("Link copied to clipboard.")
        })
        clientbton.setImage(.clientCy, for: .normal)
        clientv.addSubview(clientbton)
        clientbton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 74, height: 32))
        }
        
        let clientli = UILabel()
        clientli.textColor = KKToolUtils.color_from_hex("#FFAAAAAA")
        clientli.font = KKToolUtils.ubuntu_font(size: 14, weight: .medium)
        clientli.adjustsFontSizeToFitWidth = true
        clientli.minimumScaleFactor = 0.5
        clientv.addSubview(clientli)
        clientli.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(clientimv.snp.right).offset(10)
            make.right.equalTo(clientbton.snp.left).offset(-10)
        }
        self.clientli = clientli
        
        SSSherlockAnalysisPublic.ss_publicsysdeduce { evid in
            self.clientli.text = evid?.officialWebsiteUrl
        }
    }

}
