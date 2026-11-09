//
//  SSWatsonViewController.swift
//  Sherlock
//
//  Created by Sherlock on 2026/7/1.
//

import UIKit
import KKDeviceInsightKitSwift

class SSWatsonViewController: UIViewController {
    
    @IBOutlet weak var watsonpredict: SSWatsonPredict!
    @IBOutlet weak var watsonpredictbtnv: SSWatsonPredictbtnv!
    @IBOutlet weak var watsonback: UIButton!
    
    var watsonimg: ((UIImage) -> Void)?
    
    init() {
        super.init(nibName: "SSWatsonViewController", bundle: nil)
    }
    
    @MainActor required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        watsonback.setImage(.sherlockNavBack.rotateRight90(), for: .normal)
        watsonpredictbtnv.watsonselect = { wat in
            switch wat {
            case 0:
                self.watsonpredictbtnv.watsontype = 1
                self.watsonpredict.watsoncam.takePhoto()
            case 1:
                self.watsonpredictbtnv.watsontype = 0
                self.watsonpredict.watsoncam.startCameraSession()
            default:
                if let watsonimg = self.watsonpredict.watsoncaimg {
                    self.watsonimg?(watsonimg)
                }
                self.navigationController?.popViewController(animated: true)
            }
        }
        watsonVercam()
    }

    @IBAction func watsonbkselect(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func watsonVercam() {
        KKPermissionInfo.request_camera_permission { persult in
            switch persult.status {
            case .allowed:
                self.watsonpredictbtnv.watsontype = 0
                self.watsonpredict.watsoncam.startCameraSession()
            default: break
            }
        }
    }
    
}
