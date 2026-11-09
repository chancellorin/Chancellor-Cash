//
//  SSSleuthRecomViewController.swift
//  Sherlock
//
//  Created by Alien on 2026/10/22.
//

import UIKit
import KKUtilsKitSwift
import SnapKit
import PureLayout

class SSSleuthRecomViewController: UIViewController {
    
    private weak var sleuthtip: UILabel!
    var sleuthtext = "You do not currently meet the requirements for this product. Once a more suitable loan product becomes available, we will notify you through the app. Please stay tuned."
    var sleuthbttHid = true
    
    init(stext: String? = nil, bttHid: Bool = true) {
        super.init(nibName: "SSSleuthRecomViewController", bundle: nil)
        self.navigationItem.title = "Accurate Recommendation"
        if let stext = stext {
            sleuthtext = stext
        }
        sleuthbttHid = bttHid
    }
    
    @MainActor required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let sleuthtip = UILabel()
        sleuthtip.font = KKToolUtils.ubuntu_font(size: 12)
        sleuthtip.textColor = .white
        sleuthtip.numberOfLines = 0
        sleuthtip.textAlignment = .center
        sleuthtip.text = sleuthtext
        view.addSubview(sleuthtip)
        sleuthtip.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(25+137+11)
            make.left.right.equalToSuperview().inset(24)
        }
        
        let sleuthbtt = UIButton(type: .custom, primaryAction: UIAction { _ in
            self.navigationController?.pushViewController(SSSergeantViewController(), animated: true)
        })
        sleuthbtt.isHidden = sleuthbttHid
        sleuthbtt.setTitleColor(KKToolUtils.color_from_hex("#FF0A0A0A"), for: .normal)
        sleuthbtt.titleLabel?.font = KKToolUtils.ubuntu_font(size: 16, weight: .bold)
        sleuthbtt.setTitle("View Now", for: .normal)
        sleuthbtt.ss_layerShadow(cornerRadius: 25)
        sleuthbtt.backgroundColor = KKToolUtils.color_from_hex("#FFAAFF00")
        view.addSubview(sleuthbtt)
        sleuthbtt.autoSetDimension(.height, toSize: 50)
        sleuthbtt.autoPinEdge(toSuperviewEdge: .left, withInset: 14)
        sleuthbtt.autoPinEdge(toSuperviewEdge: .right, withInset: 14)
        sleuthbtt.autoPinEdge(toSuperviewEdge: .bottom, withInset: 30)

    }

}
