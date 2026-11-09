//
//  SSJournalistPredict.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/29.
//

import UIKit
import KKUtilsKitSwift
import PureLayout
import KKImageCompressKitSwift

class SSJournalistPredict: UIView {
    
    weak var journalistfimv: UIImageView!
    weak var journalistbimv: UIImageView!
    
    weak var journalistfbtt: UIButton!
    weak var journalistbbtt: UIButton!
    
    weak var journalistfdv: SSJournalistPredictfdv!
    var jourid: String = ""
    
    var jourEvids: [SSSherlockDiplomatEvidence] = []

    func jourfaddimg(_ jour: UIImage) {
        journalistfimv.image = jour
        journalistfbtt.isHidden = false
        jourEvids[0].diptant = KKImageCompressUtils.compress_image_data(jour)?.base64EncodedString()
        self.journalistup(0)
    }
    
    func jourbaddimg(_ jour: UIImage) {
        journalistbimv.image = jour
        journalistbbtt.isHidden = false
        jourEvids[1].diptant = KKImageCompressUtils.compress_image_data(jour)?.base64EncodedString()
        self.journalistup(1)
    }
    
    var jourtaped = 0
    
    var journalistimvselect: (() -> Void)?
    var journalistsucc: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        journalist_stepui()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        journalist_stepui()
    }
    
    func journalist_stepui() {
        let journalistfti = UILabel()
        journalistfti.textColor = KKToolUtils.color_from_hex("#888888")
        journalistfti.text = "Front"
        journalistfti.font = KKToolUtils.ubuntu_font(size: 12, weight: .bold)
        addSubview(journalistfti)
        journalistfti.autoPinEdge(toSuperviewEdge: .top)
        journalistfti.autoPinEdge(toSuperviewEdge: .left)
        journalistfti.autoSetDimension(.height, toSize: 18)
        
        let journalistfimv = UIImageView(image: .journalistUppic)
        journalistfimv.tag = 700
        journalistfimv.backgroundColor = KKToolUtils.color_from_hex("#FF1C1C1C")
        journalistfimv.ss_cornerRadius = 14
        journalistfimv.contentMode = .scaleAspectFit
        addSubview(journalistfimv)
        journalistfimv.autoPinEdge(.top, to: .bottom, of: journalistfti, withOffset: 7)
        journalistfimv.autoPinEdge(toSuperviewEdge: .left)
        journalistfimv.autoMatch(.height, to: .width, of: journalistfimv, withMultiplier: 120/168)
        journalistaddt(journalistfimv)
        self.journalistfimv = journalistfimv

        let journalistbimv = UIImageView(image: .journalistUppic)
        journalistbimv.tag = 701
        journalistbimv.backgroundColor = KKToolUtils.color_from_hex("#FF1C1C1C")
        journalistbimv.ss_cornerRadius = 14
        journalistbimv.contentMode = .scaleAspectFit
        addSubview(journalistbimv)
        journalistbimv.autoPinEdge(.top, to: .top, of: journalistfimv)
        journalistbimv.autoPinEdge(toSuperviewEdge: .right)
        journalistbimv.autoPinEdge(.left, to: .right, of: journalistfimv, withOffset: 12)
        journalistbimv.autoMatch(.width, to: .width, of: journalistfimv)
        journalistbimv.autoMatch(.height, to: .height, of: journalistfimv)
        journalistaddt(journalistbimv)
        self.journalistbimv = journalistbimv
        
        let journalistbti = UILabel()
        journalistbti.textColor = KKToolUtils.color_from_hex("#FFBBBBBB")
        journalistbti.text = "Back"
        journalistbti.font = KKToolUtils.ubuntu_font(size: 13, weight: .bold)
        addSubview(journalistbti)
        journalistbti.autoPinEdge(.top, to: .top, of: journalistfti)
        journalistbti.autoMatch(.height, to: .height, of: journalistfti)
        journalistbti.autoPinEdge(.left, to: .left, of: journalistbimv)
        
        let journalistfbtt = UIButton(type: .custom, primaryAction: UIAction { _ in
            self.journalistfdele()
        })
        journalistfbtt.isHidden = true
        journalistfbtt.setImage(.doctorDelpic, for: .normal)
        addSubview(journalistfbtt)
        journalistfbtt.autoPinEdge(.top, to: .top, of: journalistfimv, withOffset: -6)
        journalistfbtt.autoPinEdge(.right, to: .right, of: journalistfimv, withOffset: 6)
        journalistfbtt.autoSetDimensions(to: CGSize(width: 22, height: 22))
        self.journalistfbtt = journalistfbtt

        let journalistbbtt = UIButton(type: .custom, primaryAction: UIAction { _ in
            self.journalistbdele()
        })
        journalistbbtt.isHidden = true
        journalistbbtt.setImage(.doctorDelpic, for: .normal)
        addSubview(journalistbbtt)
        journalistbbtt.autoPinEdge(.top, to: .top, of: journalistbimv, withOffset: -6)
        journalistbbtt.autoPinEdge(.right, to: .right, of: journalistbimv, withOffset: 6)
        journalistbbtt.autoSetDimensions(to: CGSize(width: 22, height: 22))
        self.journalistbbtt = journalistbbtt
        
        let journalistfdv = SSJournalistPredictfdv()
        addSubview(journalistfdv)
        journalistfdv.autoPinEdge(.top, to: .bottom, of: journalistbimv, withOffset: 15)
        journalistfdv.autoPinEdge(toSuperviewEdge: .left)
        journalistfdv.autoPinEdge(toSuperviewEdge: .right)
        self.journalistfdv = journalistfdv

        let journalistbtt = UIButton(type: .custom, primaryAction: UIAction { _ in
            SSSherlockAnalysisPublic.ss_publicpoint(66)
            if self.jourEvids.count < 3 {
                SSSherlockDeduce.ss_deduce(isbusy: true)
                return
            }
            if self.journalistfbtt.isHidden {
                SSSherlockDeduce.ss_deduce("Please provide a valid value for \"KT_XXX\".".replacingOccurrences(of: "KT_XXX", with: self.jourEvids[0].itemName ?? ""))
              return
            }
            if self.journalistbbtt.isHidden {
                SSSherlockDeduce.ss_deduce("Please provide a valid value for \"KT_XXX\".".replacingOccurrences(of: "KT_XXX", with: self.jourEvids[1].itemName ?? ""))
              return
            }
            if self.journalistfdv.journalistantfd.text?.isEmpty == true {
                SSSherlockDeduce.ss_deduce("Please provide a valid value for \"KT_XXX\".".replacingOccurrences(of: "KT_XXX", with: self.jourEvids[2].itemName ?? ""))
                return
            }
            if let evidex = self.jourEvids[2].regularExpression, !evidex.isEmpty {
                guard let jourtx = self.journalistfdv.journalistantfd.text, NSPredicate(format: "SELF MATCHES %@", evidex).evaluate(with: jourtx) else {
                    SSSherlockDeduce.ss_deduce("Please provide a valid value for \"KT_XXX\".".replacingOccurrences(of: "KT_XXX", with: self.jourEvids[2].itemName ?? ""))
                    return
                }
                self.jourEvids[2].diptant = jourtx
            }
            self.journalistup(2)
        })
        journalistbtt.setTitleColor(KKToolUtils.color_from_hex("#FF0A0A0A"), for: .normal)
        journalistbtt.setTitle("Continue", for: .normal)
        journalistbtt.titleLabel?.font = KKToolUtils.ubuntu_font(size: 16, weight: .bold)
        journalistbtt.ss_layerShadow(cornerRadius: 25)
        journalistbtt.backgroundColor = KKToolUtils.color_from_hex("#FFAAFF00")
        addSubview(journalistbtt)
        journalistbtt.autoPinEdge(.top, to: .bottom, of: journalistfdv, withOffset: 60)
        journalistbtt.autoSetDimension(.height, toSize: 50)
        journalistbtt.autoPinEdge(toSuperviewEdge: .left)
        journalistbtt.autoPinEdge(toSuperviewEdge: .right)
        journalistbtt.autoPinEdge(toSuperviewEdge: .bottom)

    }
    
    func journalistaddt(_ jour: UIImageView) {
        jour.isUserInteractionEnabled = true
        let jourtap = UITapGestureRecognizer(target: self, action: #selector(journalistPictap))
        jour.addGestureRecognizer(jourtap)
    }
    
   
    @objc func journalistPictap(_ jourtap: UITapGestureRecognizer) {
        if jourEvids.count < 3 {
            SSSherlockDeduce.ss_deduce(isbusy: true)
            return
        }
        guard let imv = jourtap.view as? UIImageView else { return }
        jourtaped = imv.tag
        if jourtaped == 700 {
            SSSherlockAnalysisPublic.ss_publicpoint(50)
        }
        journalistimvselect?()
    }
    
    func journalistbdele() {
        journalistbimv.image = .journalistUppic
        journalistbbtt.isHidden = true
        jourEvids[1].diptant = nil
    }
    
    func journalistfdele() {
        journalistfimv.image = .journalistUppic
        journalistfbtt.isHidden = true
        journalistfdv.journalistantfd.text = ""
        jourEvids[0].diptant = nil
    }
    
    func journalistup(_ jourdex: Int) {
        SSSherlockDeduce.ss_deduce()
        SSSherlockAnalysis.ss_sherlock(lock: "/app/v3/kyc/item/commit", silogic: SSSherlockEvidence(kycId: self.jourid, itemCode: jourEvids[jourdex].itemCode, itemValueType: jourdex > 1 ? "1" : "2", itemValue: jourEvids[jourdex].diptant)) { analy in
            SSSherlockDeduce.ss_deducemiss()
            if jourdex == 0 {
                if let evid = analy?.kj.model(SSSherlockDiplomatEvidence.self), let evno = evid.echoMap?.cardNo {
                    self.journalistfdv.journalistantfd.text = evno
                }
            }
            if jourdex == 2 {
                self.journalistsucc?()
            }
        } resultfail: { analyerr in
            switch analyerr.errcode {
            case 6212011, 6212201:
                SSSherlockDeduce.ss_deducemiss()
                SSAddictPredict.sherlock_alert(SSAddictPredict())
            default:
                SSSherlockDeduce.ss_deduce(analyerr.errmsg, isbusy: true)
            }
            if jourdex == 0 {
                self.journalistfdele()
            }else if jourdex == 1 {
                self.journalistbdele()
            }
        }
    }

}
