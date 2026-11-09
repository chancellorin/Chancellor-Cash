//
//  SSSleuthTable.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/26.
//

import UIKit

class SSSleuthTable: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sercell = tableView.dequeueReusableCell(withIdentifier: "SSSleuthTableCell", for: indexPath) as! SSSleuthTableCell
        sercell.evid = evid
        return sercell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        166
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sleuthcellselect?()
    }
    
    var sleuthcellselect: (() -> Void)?
    
    var evid: SSSherlockPublicsysedyEvidence = SSSherlockPublicsysedyEvidence() {
        didSet {
            reloadData()
        }
    }

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        sleuth_stepui()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        sleuth_stepui()
    }
    
    func sleuth_stepui() {
        delegate = self
        dataSource = self
        register(SSSleuthTableCell.self, forCellReuseIdentifier: "SSSleuthTableCell")
        sectionHeaderTopPadding = 0
    }

}
