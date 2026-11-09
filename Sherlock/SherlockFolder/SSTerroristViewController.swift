//
//  SSTerroristViewController.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/25.
//

import UIKit
import PureLayout
import KKUtilsKitSwift

class SSTerroristViewController: SherlockViewController {

    weak var terrtopv: SSTerroristPredict!
    weak var terrintrv: SSTerroristPredictintrod!

    init() {
        super.init(nibName: nil, bundle: nil)
        self.navigationItem.title = "Repayment Instructions"
    }
    
    @MainActor required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let terrtopv = SSTerroristPredict()
        view.addSubview(terrtopv)
        terrtopv.autoPinEdge(toSuperviewSafeArea: .top, withInset: 10)
        terrtopv.autoPinEdge(toSuperviewEdge: .left)
        terrtopv.autoPinEdge(toSuperviewEdge: .right)
        self.terrtopv = terrtopv

        let terrintrv = SSTerroristPredictintrod()
        view.addSubview(terrintrv)
        terrintrv.autoPinEdge(.top, to: .bottom, of: terrtopv, withOffset: 14)
        terrintrv.autoPinEdge(toSuperviewEdge: .left)
        terrintrv.autoPinEdge(toSuperviewEdge: .right)
        self.terrintrv = terrintrv
        
        SSSherlockAnalysisPublic.ss_publicsysdeduce { evid in
            self.terrtopv.terrem.terroristli.text = evid?.appEmail
            self.terrtopv.terrli.terroristli.text = evid?.officialWebsiteUrl
            self.terrintrv.terrintrod.text = self.terrintrv.terrintrod.text?.replacingOccurrences(of: "KT_WEBSITELINK", with: evid?.officialWebsiteUrl ?? "")
        }
    }


}
