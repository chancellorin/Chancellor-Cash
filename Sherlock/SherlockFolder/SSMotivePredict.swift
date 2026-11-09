//
//  SSMotivePredict.swift
//  Sherlock
//
//  Created by Sherlock on 2026/7/1.
//

import UIKit
import PureLayout
import KKUtilsKitSwift

class SSMotivePredict: UIView {
    
    static func motive_alert(motivetitl: String = "", _ motivelist: [String]) -> SSMotivePredict {
        let motive = SSMotivePredict()
        motive.motivetitl.text = motivetitl
        motive.motivelist = motivelist
        KKToolUtils.key_window?.addSubview(motive)
        motive.autoPinEdgesToSuperviewEdges()
        return motive
    }
    
    var motiveaction: ((Int) -> Void)?
    private let motiveker = UIPickerView()
    private let motivetitl = UILabel()
    private var currentSelIndex = 0
    
    private var motivelist: [String] = [] {
        didSet {
            currentSelIndex = 0
            DispatchQueue.main.async {
                self.motiveker.reloadAllComponents()
                self.motiveker.selectRow(0, inComponent: 0, animated: false)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        motive_stepui()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        motive_stepui()
    }
    
    func motive_stepui() {
        backgroundColor = UIColor(white: 0, alpha: 0.72)
            
        let motivebgv = UIView()
        motivebgv.backgroundColor = .white
        motivebgv.layer.cornerRadius = 20
        motivebgv.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        addSubview(motivebgv)
        motivebgv.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), excludingEdge: .top)
//        motivebgv.autoSetDimension(.height, toSize: 350)
        
        motivetitl.font = KKToolUtils.ubuntu_font(size: 16, weight: .bold)
        motivetitl.textColor = KKToolUtils.color_from_hex("#333333")
        motivetitl.textAlignment = .center
        motivetitl.numberOfLines = 0
        motivebgv.addSubview(motivetitl)
        motivetitl.autoPinEdge(toSuperviewEdge: .top, withInset: 10)
        motivetitl.autoPinEdge(toSuperviewEdge: .right, withInset: 16)
        motivetitl.autoPinEdge(toSuperviewEdge: .left, withInset: 16)
        
        motivebgv.addSubview(motiveker)
        motiveker.dataSource = self
        motiveker.delegate = self
        motiveker.autoSetDimension(.height, toSize: 240)
        motiveker.autoPinEdge(.top, to: .bottom, of: motivetitl, withOffset: 10)
        motiveker.autoPinEdge(.left, to: .left, of: motivebgv, withOffset: 10)
        motiveker.autoPinEdge(.right, to: .right, of: motivebgv, withOffset: -10)

        let motivelebtt = UIButton(type: .custom, primaryAction: UIAction { _ in
            self.removeFromSuperview()
        })
        motivelebtt.titleLabel?.font = KKToolUtils.ubuntu_font(size: 16, weight: .bold)
        motivelebtt.setTitleColor(.white, for: .normal)
        motivelebtt.setTitle("Cancel", for: .normal)
        motivelebtt.backgroundColor = KKToolUtils.color_from_hex("#111111")
        motivelebtt.ss_layerShadow(cornerRadius: 14, shadowColor: KKToolUtils.color_from_hex("#1A000000"))
        motivebgv.addSubview(motivelebtt)
        motivelebtt.autoPinEdge(.top, to: .bottom, of: motiveker, withOffset: 20)
        motivelebtt.autoPinEdge(toSuperviewEdge: .bottom, withInset: 30)
        motivelebtt.autoPinEdge(toSuperviewEdge: .left, withInset: 24)
        motivelebtt.autoSetDimension(.height, toSize: 52)
        
        let motiveribtt = UIButton(type: .custom, primaryAction: UIAction { _ in
            self.motiveaction?(self.currentSelIndex)
            self.removeFromSuperview()
        })
        motiveribtt.titleLabel?.font = KKToolUtils.ubuntu_font(size: 16, weight: .bold)
        motiveribtt.setTitleColor(.white, for: .normal)
        motiveribtt.setTitle("Confirm", for: .normal)
        motiveribtt.backgroundColor = KKToolUtils.color_from_hex("#E94057")
        motiveribtt.ss_layerShadow(cornerRadius: 14, shadowColor: KKToolUtils.color_from_hex("#4DE94057"))
        motivebgv.addSubview(motiveribtt)
        motiveribtt.autoPinEdge(toSuperviewEdge: .right, withInset: 24)
        motiveribtt.autoPinEdge(.top, to: .top, of: motivelebtt)
        motiveribtt.autoPinEdge(.bottom, to: .bottom, of: motivelebtt)
        motiveribtt.autoPinEdge(.left, to: .right, of: motivelebtt, withOffset: 16)
        motiveribtt.autoMatch(.width, to: .width, of: motivelebtt)

    }

}

extension SSMotivePredict: UIPickerViewDataSource, UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 46
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        motivelist.count
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        if pickerView.subviews.count > 1 {
            pickerView.subviews[1].backgroundColor = .clear
        }
        let label: UILabel
        if let reuseLabel = view as? UILabel {
            label = reuseLabel
        } else {
            label = UILabel()
            label.textAlignment = .center
            label.numberOfLines = 1
        }
        label.text = motivelist[row]
        
        if row == currentSelIndex {
            label.font = KKToolUtils.ubuntu_font(size: 18, weight: .bold)
            label.textColor = .black
        } else {
            label.font = KKToolUtils.ubuntu_font(size: 14)
        }
        label.textColor = KKToolUtils.color_from_hex("#FF101010")
        return label
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentSelIndex = row
        DispatchQueue.main.async {
            pickerView.reloadAllComponents()
        }
    }
}

