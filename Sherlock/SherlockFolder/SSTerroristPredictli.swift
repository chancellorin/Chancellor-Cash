//
//  SSTerroristPredictdef.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/25.
//

import UIKit
import KKUtilsKitSwift
import SnapKit

class SSTerroristPredictli: UIView {

    weak var terroristli: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        terrorist_stepui()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        terrorist_stepui()
    }
    
    func terrorist_stepui() {
        let terroristi = UILabel()
        terroristi.text = "Official Website Link"
        terroristi.textColor = KKToolUtils.color_from_hex("#FFBBBBBB")
        terroristi.font = KKToolUtils.ubuntu_font(size: 13, weight: .bold)
        addSubview(terroristi)
        terroristi.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(14)
            make.height.equalTo(20)
        }
        
        let terroristv = UIView()
        terroristv.backgroundColor = KKToolUtils.color_from_hex("#FF1C1C1C")
        terroristv.ss_borderColor = KKToolUtils.color_from_hex("#FF2A2A2A")
        terroristv.ss_borderWidth = 1
        terroristv.ss_cornerRadius = 14
        addSubview(terroristv)
        terroristv.snp.makeConstraints { make in
            make.top.equalTo(terroristi.snp.bottom).offset(5)
            make.left.equalTo(14)
            make.right.equalTo(-14)
            make.height.equalTo(46)
            make.bottom.equalToSuperview()
        }
        
        let terroristimv = UIImageView(image: .clientWs)
        terroristv.addSubview(terroristimv)
        terroristimv.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(13)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
        
        let terroristbton = UIButton(type: .custom, primaryAction: UIAction { _ in
            UIPasteboard.general.string = self.terroristli.text
            SSSherlockDeduce.ss_deduce("Link copied to clipboard.")
        })
        terroristbton.setImage(.terroristCy, for: .normal)
        terroristv.addSubview(terroristbton)
        terroristbton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-13)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 28, height: 28))
        }
        
        let terroristli = UILabel()
        terroristli.textColor = KKToolUtils.color_from_hex("#FF777777")
        terroristli.font = KKToolUtils.ubuntu_font(size: 12)
        terroristli.adjustsFontSizeToFitWidth = true
        terroristli.minimumScaleFactor = 0.5
        terroristv.addSubview(terroristli)
        terroristli.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(terroristimv.snp.right).offset(10)
            make.right.equalTo(terroristbton.snp.right).offset(-10)
        }
        self.terroristli = terroristli
    }

}
