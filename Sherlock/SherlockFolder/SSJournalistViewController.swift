//
//  SSJournalistViewController.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/29.
//

import UIKit
import SnapKit
import KKUtilsKitSwift
import KKDeviceInsightKitSwift

class SSJournalistViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var journalistipv: UIView!
    
    weak var journalistv: SSJournalistPredict!
    
    var jourid: String = ""
    
    init(jourid: String?) {
        super.init(nibName: "SSJournalistViewController", bundle: nil)
        self.navigationItem.title = "Aadhaar"
        self.jourid = jourid ?? ""
    }
    
    @MainActor required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        journalist_stepui()
        SSSherlockAnalysisPublic.ss_publickycinit(pubid: jourid) { evids in
            self.journalistv.jourEvids = evids
        }
    }

    func journalist_stepui() {
        let journalistv = SSJournalistPredict()
        journalistv.jourid = jourid
        view.addSubview(journalistv)
        journalistv.snp.makeConstraints { make in
            make.top.equalTo(journalistipv.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(14)
            make.right.equalToSuperview().offset(-14)
        }
        journalistv.journalistimvselect = { [weak self] in
            self?.journalist_motive()
        }
        journalistv.journalistsucc = { [weak self] in
            SSSherlockAnalysisPublic.ss_publickyc { sher in
                self?.navigationController?.pushViewController(sher, animated: true)
            }
        }
        self.journalistv = journalistv
    }
    
    func journalist_motive() {
        let motive = SSMotivePredict.motive_alert(["Turn on the camera", "Open the photo library"])
        motive.motiveaction = { moindex in
            if moindex == 0 {
                self.journalist_wanawatson()
            }else {
                if self.journalistv.jourtaped == 700 {
                    SSSherlockAnalysisPublic.ss_publicpoint(57)
                }
                let picker = UIImagePickerController()
                picker.delegate = self
                self.present(picker, animated: true)
            }
        }
    }
    
    func journalist_wanawatson() {
        KKPermissionInfo.request_camera_permission { persult in
            switch persult.status {
            case .allowed:
                SSSherlockAnalysisPublic.ss_publicpoint(11)
                self.journalist_watson()
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
    
    func journalist_watson() {
        if journalistv.jourtaped == 700 {
            SSSherlockAnalysisPublic.ss_publicpoint(53)
        }
        let watson = SSWatsonViewController()
        watson.watsonimg = { [weak self] wat in
            switch self?.journalistv.jourtaped {
            case 700:
                self?.journalistv.jourfaddimg(wat)
            case 701:
                self?.journalistv.jourbaddimg(wat)
            default: break
            }
        }
        self.navigationController?.pushViewController(watson, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        SSSherlockDeduce.ss_deduce()
        picker.dismiss(animated: true) { [weak self] in
            SSSherlockDeduce.ss_deducemiss()
            guard let image = info[.originalImage] as? UIImage else { return }
            switch self?.journalistv.jourtaped {
            case 700:
                self?.journalistv.jourfaddimg(image)
            case 701:
                self?.journalistv.jourbaddimg(image)
            default: break
            }
        }
    }
    

}
