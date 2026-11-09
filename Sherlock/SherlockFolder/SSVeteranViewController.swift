//
//  SSVeteranViewController.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/29.
//

import UIKit
import KKUtilsKitSwift
import ContactsUI
import KKDeviceInsightKitSwift

class SSVeteranViewController: UIViewController, CNContactPickerDelegate {

    
    @IBOutlet weak var veterantable: SSVeteranTable!
    @IBOutlet weak var verteranbtt: UIButton!
    var veteid: String = ""
    var vetedex = 0

    init(veteid: String?) {
        super.init(nibName: "SSVeteranViewController", bundle: nil)
        self.navigationItem.title = "Emergency Contact"
        self.veteid = veteid ?? ""
    }
    
    @MainActor required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        verteranbtt.setTitle("Apply Now", for: .normal)
        verteranbtt.ss_layerShadow()
        
        SSSherlockAnalysisPublic.ss_publickycinit(pubid: veteid) { evids in
            var evidres: [SSSherlockDiplomatEvidence] = []
            var evidnas: [SSSherlockDiplomatEvidence] = []
            var evidphs: [SSSherlockDiplomatEvidence] = []
            
            var evidexre = 1
            var evidexna = 1
            var evidexph = 1

            for evid in evids {
                var veter = evid
                if veter.itemCode?.contains("relation") == true {
                    veter.diptantti = "Contact 0\(evidexre) \(veter.itemName ?? "")"
                    evidres.append(veter)
                    evidexre += 1
                }
                if veter.itemCode?.contains("name") == true {
                    veter.diptantti = "Contact 0\(evidexna) \(veter.itemName ?? "")"
                    evidnas.append(veter)
                    evidexna += 1
                }
                if veter.itemCode?.contains("phone") == true {
                    veter.diptantti = "Contact 0\(evidexph) \(veter.itemName ?? "")"
                    evidphs.append(veter)
                    evidexph += 1
                }
                if evid.itemCode?.contains("email") == true {
                    self.veterantable.diplomatEvidem = evid
                }
            }
            self.veterantable.diplomatEvids = [evidres, evidnas, evidphs]
            self.veterantable.reloadData()
        }
        
        veterantable.veteranselectinfo = { vetdex in
            self.vetedex = vetdex
            let picker = CNContactPickerViewController()
            picker.delegate = self
            self.present(picker, animated: true)
        }
        
    }
    
    @IBAction func verteranbttselecy(_ sender: Any) {
        SSSherlockDeduce.ss_deduce()
        var evids: [SSSherlockDiplomatEvidence] = []
        for evid in veterantable.diplomatEvids {
            evids.append(contentsOf: evid)
        }
        evids.append(self.veterantable.diplomatEvidem)
        let envlist = evids.sorted { ($0.itemSort ?? Int.min) < ($1.itemSort ?? Int.min) }
        SSDiplomatAlibi.diplomat_alibi(diplomatEvids: envlist) { evidsult in
            SSSherlockAnalysis.ss_sherlock(lock: "/app/v3/kyc/commit", silogic: SSSherlockEvidence(kycId: self.veteid), logic: SSSherlockEvidence(kycId: self.veteid, kycCommitItemList: evidsult)) { analy in
                SSSherlockDeduce.ss_deducemiss()
                NotificationCenter.default.post(name: Notification.Name("Veteransucc"), object: nil)
                self.navigationController?.popToRootViewController(animated: true)
            } resultfail: { analyerr in
                SSSherlockDeduce.ss_deduce(analyerr.errmsg, isbusy: true)
            }
        }
    }
    
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contactProperty: CNContactProperty) {
        dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            let contact = contactProperty.contact
            let name = [contact.familyName, contact.givenName].joined().trimmingCharacters(in: .whitespaces).isEmpty ? contact.nickname : "\(contact.familyName) \(contact.givenName)".trimmingCharacters(in: .whitespaces)
            guard !name.isEmpty else {
                SSSherlockDeduce.ss_deduce("The name field cannot be empty.")
                return
            }
            guard let phone = contactProperty.value as? CNPhoneNumber else {
                SSSherlockDeduce.ss_deduce("Invalid contact number. Please check.")
                return
            }
            let digits = String(phone.stringValue.unicodeScalars.filter(CharacterSet.decimalDigits.contains))
            let phoneNum = KKAddressBookInfo.normalize_india_local_prefix(digits)
            guard KKAddressBookInfo.is_valid_mobile_phone(phoneNum) else {
                SSSherlockDeduce.ss_deduce("Invalid contact number. Please check.")
                return
            }
            for evid in veterantable.diplomatEvids[2] {
                if evid.diptant == phoneNum {
                    SSSherlockDeduce.ss_deduce("This contact has already been submitted. Please enter a different contact.")
                    return
                }
            }
            self.veterantable.diplomatEvids[1][vetedex].diptant = name
            self.veterantable.diplomatEvids[2][vetedex].diptant = phoneNum
            self.veterantable.reloadData()
        }
    }
    
}
