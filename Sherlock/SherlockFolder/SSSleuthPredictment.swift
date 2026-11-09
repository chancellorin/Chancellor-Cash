//
//  SSSleuthPredictment.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/26.
//

import UIKit
import KKUtilsKitSwift
import SnapKit

class SSSleuthPredictment: UIView {
    
    var sleuthEvids: [SSSherlockPublicsysedyEvidence] = [] {
        didSet {
            resetLoopTimer()
        }
    }
    
    var sleuthtent: String = "" {
        didSet {
            sleuthment.text = sleuthtent
            sleuthment.lineSpace()
        }
    }
    
    var sleuthsor: String = "0" {
        didSet {
            for sarv in sleuthsarv.subviews {
                guard let sar = sarv as? UIButton else { continue }
                sar.isSelected = (sar.tag < (Int(sleuthsor) ?? 0) + 300)
            }
        }
    }

    weak var sleuthment: UILabel!
    weak var sleuthsarv: UIStackView!
    weak var sleuthv: UIView!

    private var sleuthindex = 0
    private var looptimer: Timer?
    
    
    private func resetLoopTimer() {
        looptimer?.invalidate()
        looptimer = nil
        sleuthindex = 0
        guard !sleuthEvids.isEmpty else {
            sleuthtent = ""
            sleuthsor = "0"
            return
        }

        updateContentWithAnimation(sleuthindex)
        looptimer = Timer.scheduledTimer(withTimeInterval: 4, repeats: true) { [weak self] _ in
            guard let self = self, !self.sleuthEvids.isEmpty else { return }
            self.sleuthindex = (self.sleuthindex + 1) % self.sleuthEvids.count
            self.updateContentWithAnimation(self.sleuthindex)
        }
    }
    
    private func updateContentWithAnimation(_ index: Int) {
        UIView.animate(withDuration: 0.4, animations: {
            self.sleuthment.alpha = 0
            self.sleuthv.alpha = 0
        }, completion: { _ in
            let item = self.sleuthEvids[index]
            self.sleuthtent = item.remarks ?? ""
            self.sleuthsor = item.starRating ?? "0"
            UIView.animate(withDuration: 0.4) {
                self.sleuthment.alpha = 1
                self.sleuthv.alpha = 1
            }
        })
    }
    
    deinit {
        looptimer?.invalidate()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        sleuth_stepui()
        sleuth_stepswipe()
    }
    
    func sleuth_stepswipe() {
        let leswipe = UISwipeGestureRecognizer(target: self, action: #selector(sleuthleft_swipeaction(_:)))
        leswipe.direction = .left
        self.addGestureRecognizer(leswipe)
        
        let riswipe = UISwipeGestureRecognizer(target: self, action: #selector(sleuthright_swipeaction(_:)))
        riswipe.direction = .right
        self.addGestureRecognizer(riswipe)
    }
    
    @objc private func sleuthleft_swipeaction(_ gesture: UISwipeGestureRecognizer) {
        
    }
    
    @objc private func sleuthright_swipeaction(_ gesture: UISwipeGestureRecognizer) {
        
    }
    
    func sleuth_stepui() {
        let sleuthbgimv = UIImageView(image: .sleuthEvbg)
        sleuthbgimv.contentMode = .scaleToFill
        addSubview(sleuthbgimv)
        sleuthbgimv.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let sleuthment = UILabel()
        sleuthment.textColor = KKToolUtils.color_from_hex("#D9FFFFFF")
        sleuthment.font = KKToolUtils.ubuntu_font(size: 13)
        sleuthment.numberOfLines = 0
        sleuthment.adjustsFontSizeToFitWidth = true
        sleuthment.minimumScaleFactor = 0.5
        addSubview(sleuthment)
        sleuthment.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(14)
            make.bottom.equalToSuperview().offset(-54)
            make.right.equalToSuperview().offset(-14)
        }
        self.sleuthment = sleuthment
        
        let sleuthv = UIView()
        sleuthv.backgroundColor = KKToolUtils.color_from_hex("#8C000000")
        sleuthv.ss_cornerRadius = 10
        addSubview(sleuthv)
        sleuthv.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(14)
            make.right.bottom.equalToSuperview().offset(-14)
            make.height.equalTo(32)
        }
        self.sleuthv = sleuthv
        
        let sleuthcr = UILabel()
        sleuthcr.text = "Customer Review"
        sleuthcr.textColor = KKToolUtils.color_from_hex("#FF555555")
        sleuthcr.font = KKToolUtils.ubuntu_font(size: 12)
        sleuthv.addSubview(sleuthcr)
        sleuthcr.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-12)
        }
        
        let sleuthsarv = UIStackView()
        sleuthsarv.axis = .horizontal
        sleuthsarv.spacing = 3
        sleuthsarv.distribution = .fill
        sleuthv.addSubview(sleuthsarv)
        sleuthsarv.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(12)
            make.width.equalTo(87)
        }
        self.sleuthsarv = sleuthsarv
        
        for i in 0..<5 {
            let sleuthsar = UIButton()
            sleuthsar.isUserInteractionEnabled = false
            sleuthsar.setImage(.sleuthSn, for: .normal)
            sleuthsar.setImage(.sleuthSs, for: .selected)
            sleuthsar.tag = 300+i
            sleuthsarv.addArrangedSubview(sleuthsar)
        }
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        sleuth_stepui()
    }
    
    

}
