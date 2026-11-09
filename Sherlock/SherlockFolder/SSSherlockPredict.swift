//
//  SSSherlockPredict.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/30.
//

import UIKit
import KKUtilsKitSwift
import PureLayout

private var sherlockWin: UIWindow?

class SSSherlockPredict: UIView {
    
    static func sherlock_alert(_ sherlock: SSSherlockPredict) {
        KKToolUtils.key_window?.addSubview(sherlock)
        sherlock.autoPinEdgesToSuperviewEdges()
    }
    
    static func sherlock_alertWin(_ sherlock: SSSherlockPredict) {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        sherlockWin = UIWindow(windowScene: scene)
        sherlockWin?.windowLevel = .alert + 100
        sherlockWin?.frame = UIScreen.main.bounds
        sherlockWin?.isHidden = false
        sherlockWin?.backgroundColor = .clear
        sherlockWin?.addSubview(sherlock)
        sherlock.autoPinEdgesToSuperviewEdges()
    }
    
    static func sherlock_alertWinHidden(_ sherlock: SSSherlockPredict) {
        sherlockWin?.isHidden = true
        sherlockWin = nil
        sherlock.removeFromSuperview()
    }
    
    weak var sherlockbgv: UIView!
    weak var sherlockliv: UIImageView!
    weak var sherlockbtt: UIButton!
    weak var sherlocklebtt: UIButton!
    weak var sherlockribtt: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        sherlock_stepui()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        sherlock_stepui()
    }
    
    func sherlock_stepui() {
        backgroundColor = UIColor(white: 0, alpha: 0.72)
        
        let sherlockbgv = UIView()
        sherlockbgv.backgroundColor = KKToolUtils.color_from_hex("#181818")
        sherlockbgv.ss_borderColor = KKToolUtils.color_from_hex("#2A2A2A")
        sherlockbgv.ss_borderWidth = 1
        sherlockbgv.ss_cornerRadius = 22
        addSubview(sherlockbgv)
        sherlockbgv.autoAlignAxis(toSuperviewAxis: .horizontal)
        sherlockbgv.autoPinEdge(toSuperviewEdge: .left, withInset: 38)
        sherlockbgv.autoPinEdge(toSuperviewEdge: .right, withInset: 38)
        
        let sherlockliv = UIImageView(image: .sherlockTopgreen)
        sherlockbgv.addSubview(sherlockliv)
        sherlockliv.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), excludingEdge: .bottom)
        sherlockliv.autoSetDimension(.height, toSize: 3)
        
        let sherlockbtt = UIButton(type: .custom, primaryAction: UIAction { [weak self] _ in
            self?.sherlockbttap()
        })
        sherlockbtt.isHidden = true
        sherlockbtt.backgroundColor = KKToolUtils.color_from_hex("#AAFF00")
        sherlockbtt.ss_layerShadow(cornerRadius: 22)
        sherlockbtt.titleLabel?.font = KKToolUtils.ubuntu_font(size: 14, weight: .bold)
        sherlockbtt.setTitleColor(KKToolUtils.color_from_hex("#0A0A0A"), for: .normal)
        sherlockbgv.addSubview(sherlockbtt)
        sherlockbtt.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0, left: 24, bottom: 17, right: 24), excludingEdge: .top)
        sherlockbtt.autoSetDimension(.height, toSize: 44)
        sherlockbtt.setTitle("Confirm", for: .normal)

        let sherlocklebtt = UIButton(type: .custom, primaryAction: UIAction { [weak self] _ in
            self?.sherlocklebttap()
        })
        sherlocklebtt.isHidden = true
        sherlocklebtt.ss_cornerRadius = 22
        sherlocklebtt.ss_borderColor = KKToolUtils.color_from_hex("#FF333333")
        sherlocklebtt.backgroundColor = KKToolUtils.color_from_hex("#FF242424")
        sherlocklebtt.setTitleColor(KKToolUtils.color_from_hex("#FF777777"), for: .normal)
        sherlocklebtt.titleLabel?.font = KKToolUtils.ubuntu_font(size: 14, weight: .bold)
        sherlocklebtt.setTitle("Cancel", for: .normal)
        sherlockbgv.addSubview(sherlocklebtt)
        sherlocklebtt.autoPinEdge(.left, to: .left, of: sherlockbtt)
        sherlocklebtt.autoPinEdge(.bottom, to: .bottom, of: sherlockbtt)
        sherlocklebtt.autoPinEdge(.top, to: .top, of: sherlockbtt)

        let sherlockribtt = UIButton(type: .custom, primaryAction: UIAction { [weak self] _ in
            self?.sherlockribttap()
        })
        sherlockribtt.isHidden = true
        sherlockribtt.backgroundColor = KKToolUtils.color_from_hex("#AAFF00")
        sherlockribtt.ss_layerShadow(cornerRadius: 22)
        sherlockribtt.titleLabel?.font = KKToolUtils.ubuntu_font(size: 14, weight: .bold)
        sherlockribtt.setTitleColor(KKToolUtils.color_from_hex("#0A0A0A"), for: .normal)
        sherlockribtt.setTitle("Confirm", for: .normal)
        sherlockbgv.addSubview(sherlockribtt)
        sherlockribtt.autoPinEdge(.right, to: .right, of: sherlockbtt)
        sherlockribtt.autoPinEdge(.bottom, to: .bottom, of: sherlocklebtt)
        sherlockribtt.autoPinEdge(.left, to: .right, of: sherlocklebtt, withOffset: 10)
        sherlockribtt.autoMatch(.width, to: .width, of: sherlocklebtt)
        sherlockribtt.autoMatch(.height, to: .height, of: sherlocklebtt)
        

        self.sherlockbgv = sherlockbgv
        self.sherlockliv = sherlockliv
        self.sherlockbtt = sherlockbtt
        self.sherlocklebtt = sherlocklebtt
        self.sherlockribtt = sherlockribtt
        
    }
    
    open func sherlockbttap() {
        
    }
    
    open func sherlocklebttap() {
        
    }
    
    open func sherlockribttap() {
        
    }

}
