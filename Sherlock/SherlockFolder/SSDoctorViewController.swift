//
//  SSDoctorViewController.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/26.
//

import UIKit
import KKUtilsKitSwift
import KKDeviceInsightKitSwift

class SSDoctorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var doctorpicv: SSDoctorPredictpic!
    @IBOutlet weak var doctorttionv: SSDoctorPredicttion!
    @IBOutlet weak var doctorappv: SSDoctorPredictapp!
    @IBOutlet weak var doctormit: UIButton!
    
    var doctorpics: [UIImage] = []
    var doctorpicurls: [String] = []
    var poproot = false

    init() {
        super.init(nibName: "SSDoctorViewController", bundle: nil)
        self.navigationItem.title = "Feedback"
    }
    
    @MainActor required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doctormit.setTitle("Submit", for: .normal)
        doctormit.ss_layerShadow()
        doctorpicv.doctortap = { [weak self] in
            let picker = UIImagePickerController()
            picker.delegate = self
            self?.present(picker, animated: true)
        }
        if let navc = navigationController as? SherlockNavigationController  {
            navc.navback = {
                self.sherlock_pop()
            }
        }
    }
    
    @IBAction func doctorbttselect(_ sender: Any) {
        if doctorttionv.doctortv.text.isEmpty {
            SSSherlockDeduce.ss_deduce("Please enter your question")
            return
        }
        if let apptx = doctorappv.doctorap.text, !apptx.isEmpty, !KKAddressBookInfo.is_valid_mobile_phone(apptx) {
            SSSherlockDeduce.ss_deduce("Invalid phone number. Please check.")
            return
        }
        doctoruppic()
    }
    
    func doctoruppic() {
        if !doctorpicv.doctoronb.isHidden {
            doctorpics.append(doctorpicv.doctorpicon.image ?? UIImage())
        }
        if !doctorpicv.doctortwb.isHidden {
            doctorpics.append(doctorpicv.doctorpictw.image ?? UIImage())
        }
        if !doctorpicv.doctorthb.isHidden {
            doctorpics.append(doctorpicv.doctorpicth.image ?? UIImage())
        }
        doctoruppicAnalysis(0)
    }
    
    func doctoruppicAnalysis(_ i: Int) {
        if i < doctorpics.count {
            SSSherlockDeduce.ss_deduce()
            SSSherlockAnalysis.ss_sherlockUppic(doctorpics[i]) { picurl in
                if let picurl = picurl {
                    self.doctorpicurls.append(picurl)
                }
                self.doctoruppicAnalysis(i+1)
            }
        }else {
            doctorsubmit()
        }
    }
    
    func doctorsubmit() {
        
        SSSherlockAnalysis.ss_sherlock(lock: "/app/v3/user/problemFeedback", logic: SSSherlockEvidence(description: doctorttionv.doctortv.text, whatsApp: doctorappv.doctorap.text, pictureUrl: doctorpicurls.joined(separator: ","))) { analy in
            SSSherlockDeduce.ss_deduce("Thanks for your feedback!", delay: 3)
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.sherlock_pop()
            }
        } resultfail: { analyerr in
            SSSherlockDeduce.ss_deduce(analyerr.errmsg, isbusy: true)
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        SSSherlockDeduce.ss_deduce()
        picker.dismiss(animated: true) { [weak self] in
            SSSherlockDeduce.ss_deducemiss()
            guard let image = info[.originalImage] as? UIImage else { return }
            switch self?.doctorpicv.doctortaped {
            case 500:
                self?.doctorpicv.doctorpicon.image = image
                self?.doctorpicv.doctoronb.isHidden = false
            case 501:
                self?.doctorpicv.doctorpictw.image = image
                self?.doctorpicv.doctortwb.isHidden = false
            case 502:
                self?.doctorpicv.doctorpicth.image = image
                self?.doctorpicv.doctorthb.isHidden = false
            default: break
            }
        }
    }
    
    func sherlock_pop() {
        if poproot {
            NotificationCenter.default.post(name: Notification.Name("ConsultantHiddenMenue"), object: nil)
            navigationController?.popToRootViewController(animated: true)
            return
        }
        if let navs = navigationController?.viewControllers {
            for shervc in navs {
                if let soldier = shervc as? SSNewspaperViewController {
                    self.navigationController?.popToViewController(soldier, animated: true)
                    return
                }
            }
        }
        NotificationCenter.default.post(name: Notification.Name("ConsultantHiddenMenue"), object: nil)
        navigationController?.popToRootViewController(animated: true)
    }


}
