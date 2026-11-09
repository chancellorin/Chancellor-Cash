//
//  SSDedutionRecomPredict.swift
//  Sherlock
//
//  Created by Alien on 2026/10/27.
//

import UIKit
import PureLayout
import KKUtilsKitSwift
import SnapKit

class SSDedutionRecomPredict: SSSherlockPredict {

    let dedutionProg = UILabel()
        
    static func deduction_loading() {
        let deduc = SSDedutionRecomPredict()
        KKToolUtils.key_window?.addSubview(deduc)
        deduc.autoPinEdgesToSuperviewEdges()
    }
    
    static func deduction_dismiss() {
        for winsub in KKToolUtils.key_window?.subviews ?? [] {
            if winsub is SSDedutionRecomPredict {
                var winsub = winsub as! SSDedutionRecomPredict
                winsub.dedutionProg.stopPercentAnimation()
                winsub.removeFromSuperview()
                break
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        deduction_stepui()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        deduction_stepui()
    }
    
    func deduction_stepui() {
        sherlockliv.image = .sherlockTopgreen
        
        let dedutionti = UILabel()
        dedutionti.textColor = .white
        dedutionti.font = KKToolUtils.ubuntu_font(size: 20, weight: .bold)
        dedutionti.text = "Under review"
        dedutionti.textAlignment = .center
        sherlockbgv.addSubview(dedutionti)
        dedutionti.snp.makeConstraints { make in
            make.top.equalTo(sherlockliv.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(28)
        }
        
        let dedutiontip = UILabel()
        dedutiontip.textColor = KKToolUtils.color_from_hex("#9E9E9E")
        dedutiontip.font = KKToolUtils.ubuntu_font(size: 11)
        dedutiontip.numberOfLines = 0
        dedutiontip.textAlignment = .center
        dedutiontip.text = "Updating your credit score, please do not leave this page. This process takes about 15 seconds..."
        dedutiontip.lineSpace()
        sherlockbgv.addSubview(dedutiontip)
        dedutiontip.snp.makeConstraints { make in
            make.top.equalTo(dedutionti.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(26)
        }
        
        let dedutionProgimv = UIImageView(image: .deductionCircle)
        sherlockbgv.addSubview(dedutionProgimv)
        dedutionProgimv.snp.makeConstraints { make in
            make.width.height.equalTo(84)
            make.centerX.equalToSuperview()
            make.top.equalTo(dedutiontip.snp.bottom).offset(13)
        }
        
        dedutionProg.textColor = KKToolUtils.color_from_hex("#B8FF55")
        dedutionProg.font = KKToolUtils.ubuntu_font(size: 13, weight: .bold)
        dedutionProg.text = "1%"
        dedutionProg.textAlignment = .center
        sherlockbgv.addSubview(dedutionProg)
        dedutionProg.snp.makeConstraints { make in
            make.edges.equalTo(dedutionProgimv)
        }
        dedutionProg.startPercentAnimation(duration: 15) {
        }
        
        let dedutionArrimv = UIImageView(image: .deductionArr)
        sherlockbgv.addSubview(dedutionArrimv)
        dedutionArrimv.snp.makeConstraints { make in
            make.size.equalTo(CGSizeMake(272, 27))
            make.centerX.equalToSuperview()
            make.top.equalTo(dedutionProgimv.snp.bottom).offset(7)
        }
        
        let dedutionBtip = UILabel()
        dedutionBtip.textColor = KKToolUtils.color_from_hex("#B8FF55")
        dedutionBtip.font = KKToolUtils.ubuntu_font(size: 11, weight: .medium)
        dedutionBtip.numberOfLines = 0
        dedutionBtip.text = "Just one more step before your loan is credited, please don't leave this page."
        dedutionBtip.textAlignment = .center
        dedutionBtip.lineSpace()
        sherlockbgv.addSubview(dedutionBtip)
        dedutionBtip.snp.makeConstraints { make in
            make.top.equalTo(dedutionArrimv.snp.bottom).offset(17)
            make.left.right.equalToSuperview().inset(47)
            make.bottom.equalToSuperview().inset(29)
        }
        
    }

}

extension UILabel {
    private struct PercentAnimationKey {
        static var displayLink: Void?
        static var startDate: Void?
        static var duration: Void?
        static var completion: Void?
    }
    
    private var displayLink: CADisplayLink? {
        get { objc_getAssociatedObject(self, &PercentAnimationKey.displayLink) as? CADisplayLink }
        set { objc_setAssociatedObject(self, &PercentAnimationKey.displayLink, newValue, .OBJC_ASSOCIATION_RETAIN) }
    }
    private var startDate: Date? {
        get { objc_getAssociatedObject(self, &PercentAnimationKey.startDate) as? Date }
        set { objc_setAssociatedObject(self, &PercentAnimationKey.startDate, newValue, .OBJC_ASSOCIATION_RETAIN) }
    }
    private var animDuration: TimeInterval {
        get { objc_getAssociatedObject(self, &PercentAnimationKey.duration) as? TimeInterval ?? 15 }
        set { objc_setAssociatedObject(self, &PercentAnimationKey.duration, newValue, .OBJC_ASSOCIATION_RETAIN) }
    }
    private var completion: (() -> Void)? {
        get { objc_getAssociatedObject(self, &PercentAnimationKey.completion) as? () -> Void }
        set { objc_setAssociatedObject(self, &PercentAnimationKey.completion, newValue, .OBJC_ASSOCIATION_COPY) }
    }
    func startPercentAnimation(duration: TimeInterval = 15, completion: (() -> Void)? = nil) {
        stopPercentAnimation()
        self.animDuration = duration
        self.startDate = Date()
        self.completion = completion
        
        let link = CADisplayLink(target: self, selector: #selector(updatePercentAnim))
        link.add(to: .main, forMode: .common)
        self.displayLink = link
    }
    
    func stopPercentAnimation() {
        displayLink?.invalidate()
        displayLink = nil
    }
    
    @objc private func updatePercentAnim() {
        guard let start = startDate, let link = displayLink else { return }
        let elapsed = Date().timeIntervalSince(start)
        let progress = min(elapsed / animDuration, 1.0)
        let value = 1 + (99 - 1) * progress
        
        self.text = String(format: "%.0f%%", value)
        
        if progress >= 1.0 {
            link.invalidate()
            displayLink = nil
            completion?()
        }
    }
}
