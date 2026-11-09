//
//  SSLandladyViewController.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/29.
//

import UIKit
import SnapKit
import KKUtilsKitSwift
import KKDeviceInsightKitSwift

class SSLandladyViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var landtipen: UILabel!
    @IBOutlet weak var landtiphi: UILabel!

    @IBOutlet weak var landladytipv: UIView!
    
    weak var landladyv: SSLandladyPredict!
    
    var landid: String = ""
    
    init(landid: String?) {
        super.init(nibName: "SSLandladyViewController", bundle: nil)
        self.navigationItem.title = "PAN"
        self.landid = landid ?? ""
    }
    
    @MainActor required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        landlady_stepui()
        SSSherlockAnalysisPublic.ss_publickycinit(pubid: landid) { evids in
            self.landladyv.landEvids = evids
        }
    }
    
    func landlady_stepui() {
        landtipen.text = "If the information is wrong, please re-take and upload the front of the PAN"
        landtiphi.text = "अगर जानकारी गलत है तो कृपया पैन की तस्वीर दोबारा लें और अपलोड करें"
        let landladyv = SSLandladyPredict()
        landladyv.landid = landid
        view.addSubview(landladyv)
        landladyv.snp.makeConstraints { make in
            make.top.equalTo(landladytipv.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(14)
            make.right.equalToSuperview().offset(-14)
        }
        landladyv.landladyimvselect = { [weak self] in
            self?.landlady_motive()
        }
        landladyv.landladysucc = { [weak self] in
            SSSherlockAnalysisPublic.ss_publickyc { sher in
                self?.navigationController?.pushViewController(sher, animated: true)
            }
        }
        self.landladyv = landladyv
    }
    
    func landlady_motive() {
        let motive = SSMotivePredict.motive_alert(["Turn on the camera", "Open the photo library"])
        motive.motiveaction = { moindex in
            if moindex == 0 {
                self.landlady_wannawatson()
            }else {
                SSSherlockAnalysisPublic.ss_publicpoint(48)
                let picker = UIImagePickerController()
                picker.delegate = self
                self.present(picker, animated: true)
            }
        }
    }
    
    func landlady_wannawatson() {
        KKPermissionInfo.request_camera_permission { persult in
            switch persult.status {
            case .allowed:
                SSSherlockAnalysisPublic.ss_publicpoint(11)
                self.landlady_watson()
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
    
    func landlady_watson() {
        SSSherlockAnalysisPublic.ss_publicpoint(43)
        let watson = SSWatsonViewController()
        watson.watsonimg = { [weak self] wat in
            self?.landladyv.landladyaddimg(wat)
        }
        self.navigationController?.pushViewController(watson, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        SSSherlockDeduce.ss_deduce()
        picker.dismiss(animated: true) { [weak self] in
            SSSherlockDeduce.ss_deducemiss()
            guard let image = info[.originalImage] as? UIImage else { return }
            self?.landladyv.landladyaddimg(image)
        }
    }

}
