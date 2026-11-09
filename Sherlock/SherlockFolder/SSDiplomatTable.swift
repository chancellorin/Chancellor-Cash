//
//  SSDiplomatTable.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/29.
//

import UIKit
import KKUtilsKitSwift

class SSDiplomatTable: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    func diplomatfind(dipdex: Int) {
        var logic = SSSherlockEvidence()
        for i in 0..<diplomatEvids.count {
            if i < dipdex, (diplomatEvids[i].diptant ?? "").isEmpty == true {
                SSSherlockDeduce.ss_deduce("Please provide a valid value for \"KT_XXX\".".replacingOccurrences(of: "KT_XXX", with: diplomatEvids[i].itemName ?? ""))
                return
            }
            if i >= dipdex {
                break
            }
            logic.state = diplomatEvids[0].diptant
            logic.city = diplomatEvids[1].diptant
            logic.bank = diplomatEvids[2].diptant
            logic.branch = diplomatEvids[3].diptant
        }
        
        SSSherlockDeduce.ss_deduce()
        SSSherlockAnalysis.ss_sherlock(lock: "/app/v3/sys/ifsc", logic: logic) { analy in
            SSSherlockDeduce.ss_deducemiss()
            let envelope = analy?.kj.model(SSSherlocklistEvidence.self)
            if dipdex > 3 {
                self.diplomatffind?(envelope?.list?.first ?? "")
            }else {
                self.diplomat_motive(dipdex: dipdex, motives: envelope?.list ?? [])
            }
        } resultfail: { analyerr in
            SSSherlockDeduce.ss_deduce(analyerr.errmsg, isbusy: true)
        }
    }
    
    func diplomat_motive(dipdex: Int, motives: [String]) {
        let motive = SSMotivePredict.motive_alert(motivetitl: diplomatEvids[dipdex].itemName ?? "", motives)
        motive.motiveaction = { moindex in
            for i in 0..<self.diplomatEvids.count {
                if i >= dipdex {
                    self.diplomatEvids[i].diptant = nil
                }
            }
            self.diplomatEvids[dipdex].diptant = motives[moindex]
            self.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        diplomatEvids.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dipcell = tableView.dequeueReusableCell(withIdentifier: "SSDiplomatTableCell", for: indexPath) as! SSDiplomatTableCell
        dipcell.diplomatEvid = diplomatEvids[indexPath.row]
        dipcell.diplomatchange = { evid, dipcell in
            if let dipdex = tableView.indexPath(for: dipcell) {
                self.diplomatEvids[dipdex.row] = evid
            }
        }
        dipcell.diplomatff = {
            self.diplomatff?()
        }
        dipcell.diplomatffind = { dipcell in
            if let dipdex = tableView.indexPath(for: dipcell) {
                self.diplomatfind(dipdex: dipdex.row)
            }
        }
        return dipcell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        10
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        UIView()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView()
    }
    
    var diplomatEvids: [SSSherlockDiplomatEvidence] = []
    var diplomatff: (() -> Void)?
    var diplomatffind: ((String) -> Void)?

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        veteran_stepui()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        veteran_stepui()
    }
    
    func veteran_stepui() {
        delegate = self
        dataSource = self
        sectionHeaderTopPadding = 0
        register(UINib(nibName: "SSDiplomatTableCell", bundle: nil), forCellReuseIdentifier: "SSDiplomatTableCell")
    }

    
}
