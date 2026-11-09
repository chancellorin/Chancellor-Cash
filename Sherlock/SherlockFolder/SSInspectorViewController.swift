//
//  SSInspectorViewController.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/25.
//

import UIKit
import SnapKit
import KKUtilsKitSwift

class SSInspectorViewController: SherlockViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.navigationItem.title = "About "
    }
    
    @MainActor required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let insptopv = SSInspectorPredict()
        view.addSubview(insptopv)
        insptopv.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        let inspbotmv = SSInspectorPredictda()
        view.addSubview(inspbotmv)
        inspbotmv.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
        }
    }

}
