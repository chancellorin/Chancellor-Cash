//
//  SSSergeantTable.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/25.
//

import UIKit

class SSSergeantTable: UITableView, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sergeantst.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sercell = tableView.dequeueReusableCell(withIdentifier: "SSSergeantTableCell", for: indexPath) as! SSSergeantTableCell
        sercell.sergeantEvidence = sergeantst[indexPath.row]
        return sercell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        128
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sergeantselect?(sergeantst[indexPath.row].orderStatus, sergeantst[indexPath.row].orderId)
    }
    
    var sergeantst: [SSSherlockSergeantEvidence] = [] {
        didSet {
            reloadData()
        }
    }
    
    var sergeantselect: ((Int?, String?) -> Void)?

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: .plain)
        sergeant_stepui()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        sergeant_stepui()
    }
    
    func sergeant_stepui() {
        delegate = self
        dataSource = self
        register(SSSergeantTableCell.self, forCellReuseIdentifier: "SSSergeantTableCell")
        sectionHeaderTopPadding = 0
    }
    
    
    
}
