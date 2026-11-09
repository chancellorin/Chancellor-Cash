//
//  SSDiplomatTableCell.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/29.
//

import UIKit

class SSDiplomatTableCell: UITableViewCell {
    
    @IBOutlet weak var diplomatpredict: SSDiplomatPredict!
    
    var diplomatEvid: SSSherlockDiplomatEvidence = SSSherlockDiplomatEvidence() {
        didSet {
            diplomatpredict.diplomatEvid = diplomatEvid
        }
    }

    var diplomatchange: ((SSSherlockDiplomatEvidence, SSDiplomatTableCell) -> Void)?
    var diplomatff: (() -> Void)?
    var diplomatffind: ((SSDiplomatTableCell) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        diplomatpredict.diplomatchange = { evid in
            self.diplomatchange?(evid, self)
        }
        diplomatpredict.diplomatff = {
            self.diplomatff?()
        }
        diplomatpredict.diplomatffind = {
            self.diplomatffind?(self)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
