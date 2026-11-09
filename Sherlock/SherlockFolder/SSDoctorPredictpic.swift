//
//  SSDoctorPredictpic.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/27.
//

import UIKit
import KKUtilsKitSwift
import PureLayout

class SSDoctorPredictpic: UIView {
    
    var doctortap: (() -> Void)?
    var doctortaped = 0

    weak var doctorpicon: UIImageView!
    weak var doctorpictw: UIImageView!
    weak var doctorpicth: UIImageView!
    
    weak var doctoronb: UIButton!
    weak var doctortwb: UIButton!
    weak var doctorthb: UIButton!
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        doctor_stepui()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        doctor_stepui()
    }
    
    func doctor_stepui() {
        let doctorti = UILabel()
        doctorti.textColor = KKToolUtils.color_from_hex("#FFBBBBBB")
        doctorti.text = "Upload pictures"
        doctorti.font = KKToolUtils.ubuntu_font(size: 13, weight: .bold)
        addSubview(doctorti)
        doctorti.autoPinEdge(toSuperviewEdge: .top)
        doctorti.autoPinEdge(toSuperviewEdge: .left)
        doctorti.autoSetDimension(.height, toSize: 20)
        
        let doctorpicon = UIImageView(image: .doctorAddpic)
        doctorpicon.contentMode = .scaleAspectFill
        doctorpicon.ss_cornerRadius = 14
        doctorpicon.tag = 500
        addSubview(doctorpicon)
        doctorpicon.autoPinEdge(.top, to: .bottom, of: doctorti, withOffset: 7)
        doctorpicon.autoPinEdge(toSuperviewEdge: .left)
        doctorpicon.autoSetDimensions(to: CGSize(width: 110, height: 100))
        self.doctorpicon = doctorpicon
        
        let doctoronb = UIButton(type: .custom, primaryAction: UIAction { _ in
            self.doctorpicon.image = .doctorAddpic
            self.doctoronb.isHidden = true
        })
        doctoronb.isHidden = true
        doctoronb.setImage(.doctorDelpic, for: .normal)
        addSubview(doctoronb)
        doctoronb.autoPinEdge(.top, to: .top, of: doctorpicon, withOffset: -10)
        doctoronb.autoPinEdge(.right, to: .right, of: doctorpicon, withOffset: 9)
        doctoronb.autoSetDimensions(to: CGSize(width: 20, height: 20))
        self.doctoronb = doctoronb
        
        let doctorpictw = UIImageView(image: .doctorAddpic)
        doctorpictw.contentMode = .scaleAspectFill
        doctorpictw.ss_cornerRadius = 14
        doctorpictw.tag = 501
        addSubview(doctorpictw)
        doctorpictw.autoPinEdge(.top, to: .top, of: doctorpicon)
        doctorpictw.autoAlignAxis(toSuperviewAxis: .vertical)
        doctorpictw.autoMatch(.width, to: .width, of: doctorpicon)
        doctorpictw.autoMatch(.height, to: .height, of: doctorpicon)
        self.doctorpictw = doctorpictw

        let doctortwb = UIButton(type: .custom, primaryAction: UIAction { _ in
            self.doctorpictw.image = .doctorAddpic
            self.doctortwb.isHidden = true
        })
        doctortwb.isHidden = true
        doctortwb.setImage(.doctorDelpic, for: .normal)
        addSubview(doctortwb)
        doctortwb.autoPinEdge(.top, to: .top, of: doctorpictw, withOffset: -10)
        doctortwb.autoPinEdge(.right, to: .right, of: doctorpictw, withOffset: 9)
        doctortwb.autoSetDimensions(to: CGSize(width: 20, height: 20))
        self.doctortwb = doctortwb

        let doctorpicth = UIImageView(image: .doctorAddpic)
        doctorpicth.contentMode = .scaleAspectFill
        doctorpicth.ss_cornerRadius = 14
        doctorpicth.tag = 502
        addSubview(doctorpicth)
        doctorpicth.autoPinEdge(.top, to: .top, of: doctorpicon)
        doctorpicth.autoPinEdge(toSuperviewEdge: .right)
        doctorpicth.autoMatch(.width, to: .width, of: doctorpicon)
        doctorpicth.autoMatch(.height, to: .height, of: doctorpicon)
        self.doctorpicth = doctorpicth
        
        let doctorthb = UIButton(type: .custom, primaryAction: UIAction { _ in
            self.doctorpicth.image = .doctorAddpic
            self.doctorthb.isHidden = true
        })
        doctorthb.isHidden = true
        doctorthb.setImage(.doctorDelpic, for: .normal)
        addSubview(doctorthb)
        doctorthb.autoPinEdge(.top, to: .top, of: doctorpicth, withOffset: -10)
        doctorthb.autoPinEdge(.right, to: .right, of: doctorpicth, withOffset: 9)
        doctorthb.autoSetDimensions(to: CGSize(width: 20, height: 20))
        self.doctorthb = doctorthb

        doctoraddt(self.doctorpicth)
        doctoraddt(self.doctorpictw)
        doctoraddt(self.doctorpicon)

    }

    func doctoraddt(_ doct: UIImageView) {
        doct.isUserInteractionEnabled = true
        let docttap = UITapGestureRecognizer(target: self, action: #selector(doctorPictap))
        doct.addGestureRecognizer(docttap)
    }
    
   
    @objc func doctorPictap(_ doctap: UITapGestureRecognizer) {
        guard let imv = doctap.view as? UIImageView else { return }
        doctortaped = imv.tag
        doctortap?()
    }
    
}
