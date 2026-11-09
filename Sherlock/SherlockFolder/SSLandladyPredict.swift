//
//  SSLandladyPredict.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/29.
//

import UIKit
import KKUtilsKitSwift
import PureLayout
import KKImageCompressKitSwift

class SSLandladyPredict: UIView {
    
    weak var landladyimv: UIImageView!
    weak var landladyfbtt: UIButton!
    weak var landladyfdv: SSJournalistPredictfdv!

    var landEvids: [SSSherlockDiplomatEvidence] = []
    
    var landladyimvselect: (() -> Void)?
    var landladysucc: (() -> Void)?
    var landid: String = ""

    func landladyaddimg(_ land: UIImage) {
        landladyimv.image = land
        landladyfbtt.isHidden = false
        landEvids[0].diptant = KKImageCompressUtils.compress_image_data(land)?.base64EncodedString()
        self.landladyup(0)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        landlady_stepui()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        landlady_stepui()
    }
    
    func landlady_stepui() {
        let landladyti = UILabel()
        landladyti.textColor = KKToolUtils.color_from_hex("#888888")
        landladyti.text = "Front of PAN"
        landladyti.font = KKToolUtils.ubuntu_font(size: 13, weight: .bold)
        addSubview(landladyti)
        landladyti.autoPinEdge(toSuperviewEdge: .top)
        landladyti.autoPinEdge(toSuperviewEdge: .left)
        landladyti.autoSetDimension(.height, toSize: 20)
        
        let landladyimv = UIImageView(image: .landladyUppic)
        landladyimv.contentMode = .scaleAspectFit
        landladyimv.backgroundColor = KKToolUtils.color_from_hex("#FF1C1C1C")
        landladyimv.ss_cornerRadius = 14
        addSubview(landladyimv)
        landladyimv.autoPinEdge(.top, to: .bottom, of: landladyti, withOffset: 7)
        landladyimv.autoPinEdge(toSuperviewEdge: .left)
        landladyimv.autoPinEdge(toSuperviewEdge: .right)
        landladyimv.autoMatch(.height, to: .width, of: landladyimv, withMultiplier: 160/347)
        landladyimv.isUserInteractionEnabled = true
        let landladytap = UITapGestureRecognizer(target: self, action: #selector(landladyPictap))
        landladyimv.addGestureRecognizer(landladytap)
        self.landladyimv = landladyimv
        
        let landladyfbtt = UIButton(type: .custom, primaryAction: UIAction { _ in
            self.journalistdele()
        })
        landladyfbtt.isHidden = true
        landladyfbtt.setImage(.doctorDelpic, for: .normal)
        addSubview(landladyfbtt)
        landladyfbtt.autoPinEdge(.top, to: .top, of: landladyimv, withOffset: -6)
        landladyfbtt.autoPinEdge(.right, to: .right, of: landladyimv, withOffset: 6)
        landladyfbtt.autoSetDimensions(to: CGSize(width: 22, height: 22))
        self.landladyfbtt = landladyfbtt
        
        let landladytip = UILabel()
        landladytip.textColor = .white
        landladytip.text = "Please upload your PAN\nकृपया अपने पैन कार्ड के सामने वाले हिस्से को अपलोड करें"
        landladytip.font = KKToolUtils.ubuntu_font(size: 12, weight: .bold)
        landladytip.numberOfLines = 0
        landladytip.lineSpace(8)
        addSubview(landladytip)
        landladytip.autoPinEdge(.top, to: .bottom, of: landladyimv, withOffset: 8)
        landladytip.autoPinEdge(toSuperviewEdge: .left)
        landladytip.autoPinEdge(toSuperviewEdge: .right)
        
        let landladyfdv = SSJournalistPredictfdv()
        landladyfdv.islandlady = true
        addSubview(landladyfdv)
        landladyfdv.autoPinEdge(.top, to: .bottom, of: landladytip, withOffset: 15)
        landladyfdv.autoPinEdge(toSuperviewEdge: .left)
        landladyfdv.autoPinEdge(toSuperviewEdge: .right)
        self.landladyfdv = landladyfdv
        
        let landladybtt = UIButton(type: .custom, primaryAction: UIAction { _ in
            SSSherlockAnalysisPublic.ss_publicpoint(40)
            if self.landEvids.count < 2 {
                SSSherlockDeduce.ss_deduce(isbusy: true)
                return
            }
            if self.landladyfbtt.isHidden {
                SSSherlockDeduce.ss_deduce("Please provide a valid value for \"KT_XXX\".".replacingOccurrences(of: "KT_XXX", with: self.landEvids[0].itemName ?? ""))
              return
            }
            if self.landladyfdv.journalistantfd.text?.isEmpty == true {
                SSSherlockDeduce.ss_deduce("Please provide a valid value for \"KT_XXX\".".replacingOccurrences(of: "KT_XXX", with: self.landEvids[1].itemName ?? ""))
                return
            }
            if let evidex = self.landEvids[1].regularExpression, !evidex.isEmpty {
                guard let jourtx = self.landladyfdv.journalistantfd.text, NSPredicate(format: "SELF MATCHES %@", evidex).evaluate(with: jourtx) else {
                    SSSherlockDeduce.ss_deduce("Please provide a valid value for \"KT_XXX\".".replacingOccurrences(of: "KT_XXX", with: self.landEvids[1].itemName ?? ""))
                    return
                }
                self.landEvids[1].diptant = jourtx
            }
            self.landladyup(1)
        })
        landladybtt.setTitleColor(KKToolUtils.color_from_hex("#FF0A0A0A"), for: .normal)
        landladybtt.titleLabel?.font = KKToolUtils.ubuntu_font(size: 16, weight: .bold)
        landladybtt.setTitle("Continue", for: .normal)
        landladybtt.ss_layerShadow(cornerRadius: 25)
        landladybtt.backgroundColor = KKToolUtils.color_from_hex("#FFAAFF00")
        addSubview(landladybtt)
        landladybtt.autoPinEdge(.top, to: .bottom, of: landladyfdv, withOffset: 60)
        landladybtt.autoSetDimension(.height, toSize: 50)
        landladybtt.autoPinEdge(toSuperviewEdge: .left)
        landladybtt.autoPinEdge(toSuperviewEdge: .right)
        landladybtt.autoPinEdge(toSuperviewEdge: .bottom)
    }
    
    @objc func landladyPictap() {
        SSSherlockAnalysisPublic.ss_publicpoint(41)
        if landEvids.count < 2 {
            SSSherlockDeduce.ss_deduce(isbusy: true)
            return
        }
        landladyimvselect?()
    }
    
    func journalistdele() {
        landladyimv.image = .landladyUppic
        landladyfbtt.isHidden = true
        landladyfdv.journalistantfd.text = ""
        landEvids[0].diptant = nil
    }
    
    func landladyup(_ jourdex: Int) {
        SSSherlockDeduce.ss_deduce()
        SSSherlockAnalysis.ss_sherlock(lock: "/app/v3/kyc/item/commit", silogic: SSSherlockEvidence(kycId: self.landid, itemCode: landEvids[jourdex].itemCode, itemValueType: jourdex > 0 ? "1" : "2", itemValue: landEvids[jourdex].diptant)) { analy in
            SSSherlockDeduce.ss_deducemiss()
            if jourdex == 0 {
                if let evid = analy?.kj.model(SSSherlockDiplomatEvidence.self), let evno = evid.echoMap?.cardNo {
                    self.landladyfdv.journalistantfd.text = evno
                }
            }
            if jourdex == 1 {
                self.landladysucc?()
            }
        } resultfail: { analyerr in
            switch analyerr.errcode {
            case 6212011, 6212201:
                SSSherlockDeduce.ss_deducemiss()
                SSAddictPredict.sherlock_alert(SSAddictPredict())
            default:
                SSSherlockDeduce.ss_deduce(analyerr.errmsg, isbusy: true)
            }
            self.journalistdele()
        }
    }

}
