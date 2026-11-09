//
//  SSTerroristPredict.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/25.
//

import UIKit
import KKUtilsKitSwift
import PureLayout

class SSTerroristPredict: UIView {
    
    weak var terrem: SSTerroristPredictem!
    weak var terrli: SSTerroristPredictli!

    override init(frame: CGRect) {
        super.init(frame: frame)
        terrorist_stepui()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        terrorist_stepui()
    }
    
    func terrorist_stepui() {
        let terrem = SSTerroristPredictem()
        addSubview(terrem)
        terrem.autoPinEdge(toSuperviewEdge: .top, withInset: 10)
        terrem.autoPinEdge(toSuperviewEdge: .left)
        terrem.autoPinEdge(toSuperviewEdge: .right)
        self.terrem = terrem

        let terrli = SSTerroristPredictli()
        addSubview(terrli)
        terrli.autoPinEdge(.top, to: .bottom, of: terrem, withOffset: 15)
        terrli.autoPinEdge(toSuperviewEdge: .left)
        terrli.autoPinEdge(toSuperviewEdge: .right)
        terrli.autoPinEdge(toSuperviewEdge: .bottom)
        self.terrli = terrli

    }
    
}
