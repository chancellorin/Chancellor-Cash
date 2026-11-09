//
//  SSClientViewController.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/25.
//

import UIKit
import KKUtilsKitSwift

class SSClientViewController: SherlockViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
        self.navigationItem.title = "Official Website"
    }
    
    @MainActor required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let clientopv = SSClientPredict()
        view.addSubview(clientopv)
        clientopv.autoPinEdge(toSuperviewSafeArea: .top, withInset: 10)
        clientopv.autoPinEdge(toSuperviewEdge: .right)
        clientopv.autoPinEdge(toSuperviewEdge: .left)

        let clienliv = SSClientPredictlink()
        view.addSubview(clienliv)
        clienliv.autoPinEdge(.top, to: .bottom, of: clientopv, withOffset: 10)
        clienliv.autoPinEdge(toSuperviewEdge: .right)
        clienliv.autoPinEdge(toSuperviewEdge: .left)
        
        
    }
    
}
