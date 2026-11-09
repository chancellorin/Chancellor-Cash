//
//  SSHolmesViewController.swift
//  Sherlock
//
//  Created by Sherlock on 2026/7/1.
//

import UIKit
import KKUtilsKitSwift
import KKDeviceInsightKitSwift
import KKImageCompressKitSwift

class SSHolmesViewController: UIViewController {
    
    @IBOutlet weak var holmespredict: SSHolmesPredict!
    @IBOutlet weak var holmespredictbtnv: SSHolmesPredictbtnv!
    @IBOutlet weak var holmestip: UILabel!
    
    var holmid: String = ""

    init(holmid: String?) {
        super.init(nibName: "SSHolmesViewController", bundle: nil)
        self.navigationItem.title = "Face identification"
        self.holmid = holmid ?? ""
    }
    
    @MainActor required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        holmestip.text = "Align the frame and take a clear front photo.\nअपना चेहरा फ्रेम के अनुसार संरेखित करें और सामने से स्पष्ट फोटो लें।"
        holmestip.lineSpace(10)
        holmesVercam()
        holmespredictbtnv.holmeselect = { holm in
            switch holm {
            case 0: self.holmesVercam()
            case 1:
                self.holmespredictbtnv.holmestype = 2
                self.holmespredict.holmescam.takePhoto()
            case 2:
                self.holmespredictbtnv.holmestype = 1
                self.holmespredict.holmescam.startCameraSession()
            case 3: self.holmesubmit()
            default: break
            }
        }
        SSSherlockAnalysisPublic.ss_publickycinit(pubid: holmid) { _ in }
    }
    
    func holmesVercam() {
        KKPermissionInfo.request_camera_permission { persult in
            switch persult.status {
            case .allowed:
                SSSherlockAnalysisPublic.ss_publicpoint(11)
                self.holmespredictbtnv.holmestype = 1
                self.holmespredict.holmescam.startCameraSession()
            default:
                if persult.is_first_system_choice {
                    return
                }
                let mori = SSMoriartyPredict()
                mori.moriartype = .moriartycam
                SSMoriartyPredict.sherlock_alert(mori)
            }
        }
    }
    
    func holmesubmit() {
        guard let holm = holmespredict.holmesface else {
            SSSherlockDeduce.ss_deduce("Align the frame and take a clear front photo.")
            return
        }
        SSSherlockDeduce.ss_deduce()
        SSSherlockAnalysis.ss_sherlock(lock: "/app/v3/kyc/liveness/silent", silogic: SSSherlockEvidence(liveness: KKImageCompressUtils.compress_image_data(holm)?.base64EncodedString())) { analy in
            SSSherlockDeduce.ss_deducemiss()
            SSSherlockAnalysisPublic.ss_publickyc { sher in
                self.navigationController?.pushViewController(sher, animated: true)
            }
        } resultfail: { analyerr in
            SSSherlockDeduce.ss_deduce(analyerr.errmsg, isbusy: true)
        }
    }


}
