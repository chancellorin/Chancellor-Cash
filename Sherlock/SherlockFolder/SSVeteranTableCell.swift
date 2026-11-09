//
//  SSVeteranTableCell.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/29.
//

import UIKit

class SSVeteranTableCell: UITableViewCell {

    @IBOutlet weak var veterantact: SSVeteranTableCelltact!
    @IBOutlet weak var veteraninfo: SSVeteranTableCellinfo!
    @IBOutlet weak var veterantbgv: UIView!
    
    var vetEvidre: SSSherlockDiplomatEvidence = SSSherlockDiplomatEvidence() {
        didSet {
            veteraninfo.vetEvidre = vetEvidre
        }
    }
    
    var vetEvidna: SSSherlockDiplomatEvidence = SSSherlockDiplomatEvidence() {
        didSet {
            veteraninfo.vetEvidna = vetEvidna
        }
    }
    
    var vetEvidph: SSSherlockDiplomatEvidence = SSSherlockDiplomatEvidence() {
        didSet {
            veteraninfo.vetEvidph = vetEvidph
        }
    }

    var veteranselectact: ((SSVeteranTableCell) -> Void)?
    var veteranselectinfo: ((SSVeteranTableCell) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        veteraninfo.veteranselectinfo = {
            self.veteranselectinfo?(self)
        }
        veteraninfo.veteranselectact = {
            self.veteranselectact?(self)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
