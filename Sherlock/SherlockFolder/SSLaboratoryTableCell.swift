//
//  SSLaboratoryTableCell.swift
//  Sherlock
//
//  Created by Sherlock on 2026/7/1.
//

import UIKit
import KKUtilsKitSwift
import PureLayout

class SSLaboratoryTableCell: UITableViewCell {
    
    let laboratoryti = UILabel()
    let laboratorylue = UILabel()
    let laboratorybtt = UIButton(type: .custom)
    
    var laboraEvid = SSSherlockNewspaperTbEvidence() {
        didSet {
            laboratoryti.text = laboraEvid.newstitx
            laboratorylue.text = laboraEvid.newscontent
            laboratorylue.textColor = KKToolUtils.color_from_hex(laboraEvid.newscolor)
            laboratorybtt.isHidden = laboraEvid.newstip == nil
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        laboratory_stepui()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        laboratory_stepui()
    }
    
    func laboratory_stepui() {
        selectionStyle = .none

        laboratoryti.textColor = KKToolUtils.color_from_hex("#FF666666")
        laboratoryti.font = KKToolUtils.ubuntu_font(size: 13)
        contentView.addSubview(laboratoryti)
        laboratoryti.autoPinEdge(toSuperviewEdge: .top)
        laboratoryti.autoPinEdge(toSuperviewEdge: .bottom)
        laboratoryti.autoPinEdge(toSuperviewEdge: .left, withInset: 14)

        laboratorylue.font = KKToolUtils.ubuntu_font(size: 13, weight: .bold)
        contentView.addSubview(laboratorylue)
        laboratorylue.autoPinEdge(toSuperviewEdge: .top)
        laboratorylue.autoPinEdge(toSuperviewEdge: .bottom)
        laboratorylue.autoPinEdge(toSuperviewEdge: .right, withInset: 14)
        
        laboratorybtt.setImage(.laboratoryEximg, for: .normal)
        laboratorybtt.addTarget(self, action: #selector(laboratorybttap), for: .touchUpInside)
        contentView.addSubview(laboratorybtt)
        laboratorybtt.autoPinEdge(.left, to: .right, of: laboratoryti)
        laboratorybtt.autoSetDimensions(to: CGSizeMake(21, 21))
        laboratorybtt.autoAlignAxis(toSuperviewAxis: .horizontal)
    }
    
    @objc func laboratorybttap() {
        SSSherlockDeduce.ss_deduce(laboraEvid.newstip ?? "")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
