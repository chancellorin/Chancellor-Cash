//
//  SSLaboratoryTable.swift
//  Sherlock
//
//  Created by Sherlock on 2026/7/1.
//

import UIKit
import KKUtilsKitSwift

class SSLaboratoryTable: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        evids.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sercell = tableView.dequeueReusableCell(withIdentifier: "SSLaboratoryTableCell", for: indexPath) as! SSLaboratoryTableCell
        sercell.contentView.backgroundColor = indexPath.row % 2 == 0 ? KKToolUtils.color_from_hex("#FF161616") : KKToolUtils.color_from_hex("#FF191919")
        sercell.laboraEvid = evids[indexPath.row]
        return sercell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        38
    }
    
    var evids: [SSSherlockNewspaperTbEvidence] = []

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        sleuth_stepui()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        sleuth_stepui()
    }
    
    func sleuth_stepui() {
        backgroundColor = .clear
        ss_cornerRadius = 16
        isScrollEnabled = false
        separatorStyle = .none
        delegate = self
        dataSource = self
        register(SSLaboratoryTableCell.self, forCellReuseIdentifier: "SSLaboratoryTableCell")
        sectionHeaderTopPadding = 0
    }

}
