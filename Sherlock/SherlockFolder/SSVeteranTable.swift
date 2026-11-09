//
//  SSVeteranTable.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/29.
//

import UIKit
import SnapKit
import KKUtilsKitSwift

class SSVeteranTable: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    func veteran_motive(dipdex: Int, motives: [String]) {
        let motive = SSMotivePredict.motive_alert(motives)
        motive.motiveaction = { moindex in
            self.diplomatEvids[0][dipdex].diptant = motives[moindex]
            self.diplomatEvids[0][dipdex].dipkey = self.diplomatEvids[0][dipdex].buttonList?[moindex].buttonKey
            self.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        diplomatEvids.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vercell = tableView.dequeueReusableCell(withIdentifier: "SSVeteranTableCell", for: indexPath) as! SSVeteranTableCell
        vercell.veterantact.veterandex.text = "0\(indexPath.row + 1)"
        vercell.veterantact.veteranti.text = "Contact 0\(indexPath.row + 1)"
        vercell.vetEvidre = diplomatEvids[0][indexPath.row]
        vercell.vetEvidna = diplomatEvids[1][indexPath.row]
        vercell.vetEvidph = diplomatEvids[2][indexPath.row]
        vercell.veteranselectact = { vet in
            if let vetdex = tableView.indexPath(for: vet) {
                let motives = self.diplomatEvids[0][vetdex.row].buttonList?.compactMap { $0.buttonLabel } ?? []
                self.veteran_motive(dipdex: vetdex.row, motives: motives)
            }
        }
        vercell.veteranselectinfo = { vet in
            if let vetdex = tableView.indexPath(for: vet) {
                self.veteranselectinfo?(vetdex.row)
            }
        }
        if let dipre = vercell.vetEvidre.diptant, !dipre.isEmpty, let dipna = vercell.vetEvidna.diptant, !dipna.isEmpty, let dipph = vercell.vetEvidph.diptant, !dipph.isEmpty {
            vercell.veterantbgv.ss_borderColor = KKToolUtils.color_from_hex("#30AAFF00")
            vercell.veterantact.backgroundColor = KKToolUtils.color_from_hex("#05AAFF00")
            vercell.veterantact.veterandex.backgroundColor = KKToolUtils.color_from_hex("#21AAFF00")
            vercell.veterantact.veterandex.textColor = KKToolUtils.color_from_hex("#FFAAFF00")
            vercell.veterantact.veterandex.ss_borderColor = KKToolUtils.color_from_hex("#36AAFF00")
            vercell.veterantact.veteranti.textColor = KKToolUtils.color_from_hex("#FFDDDDDD")
        }else {
            vercell.veterantbgv.ss_borderColor = KKToolUtils.color_from_hex("#FF1E1E1E")
            vercell.veterantact.backgroundColor = KKToolUtils.color_from_hex("#FF161616")
            vercell.veterantact.veterandex.backgroundColor = KKToolUtils.color_from_hex("#FFDBDBDB")
            vercell.veterantact.veterandex.textColor = KKToolUtils.color_from_hex("#FF3A3A3A")
            vercell.veterantact.veterandex.ss_borderColor = KKToolUtils.color_from_hex("#FF3C3C3C")
            vercell.veterantact.veteranti.textColor = KKToolUtils.color_from_hex("#FF444444")
        }
        return vercell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let vetbgv = UIView()
        let vetv = SSDiplomatPredict()
        vetv.diplomatEvid = diplomatEvidem
        vetv.diplomatti.textColor = KKToolUtils.color_from_hex("#FFBBBBBB")
        vetbgv.addSubview(vetv)
        vetv.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(14)
            make.right.equalToSuperview().offset(-14)
        }
        vetv.diplomatchange = { evid in
            self.diplomatEvidem = evid
        }
        return vetbgv
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        5
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        87
    }
    
    var diplomatEvids: [[SSSherlockDiplomatEvidence]] = []
    var veteranselectinfo: ((Int) -> Void)?
    var diplomatEvidem: SSSherlockDiplomatEvidence = SSSherlockDiplomatEvidence()

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
        register(UINib(nibName: "SSVeteranTableCell", bundle: nil), forCellReuseIdentifier: "SSVeteranTableCell")
    }
    
}
