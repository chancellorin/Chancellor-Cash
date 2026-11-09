//
//  SSSleuthTableCell.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/25.
//

import UIKit
import PureLayout
import KKUtilsKitSwift

class SSSleuthTableCell: UITableViewCell {
    
    weak var sleuthline: UIView!
    weak var sleuthmlam: UILabel!
    weak var sergeantmv: SSSleuthTableCellmv!
    weak var sergeantst: UILabel!
    
    var evid: SSSherlockPublicsysedyEvidence = SSSherlockPublicsysedyEvidence() {
        didSet {
            sleuthmlam.text = "₹\(KKToolUtils.format_amount(evid.maxApplyAmount))"
            switch evid.userStatus {
            case 30:
                sergeantst.text = "Submit Application"
            case 32:
                sergeantst.text = "Get loan"
            case 41:
                sergeantst.text = "Update bank account"
            case 81:
                sergeantst.text = "Pay Overdue"
            default:
                sergeantst.text = "Apply"
            }
        }
    }
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        sleuth_stepui()
    }
    
    func sleuth_stepui() {
        
        let sleuthv = UIView()
        sleuthv.ss_cornerRadius = 14
        sleuthv.backgroundColor = KKToolUtils.color_from_hex("#FF161616")
        sleuthv.ss_borderColor = KKToolUtils.color_from_hex("#FF232323")
        sleuthv.ss_borderWidth = 1
        contentView.addSubview(sleuthv)
        sleuthv.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 6, left: 0, bottom: 6, right: 0))
        
        let sleuthline = UIView()
        sleuthline.ss_horizontalGradient("AAFF00")
        sleuthv.addSubview(sleuthline)
        sleuthline.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), excludingEdge: .bottom)
        sleuthline.autoSetDimension(.height, toSize: 3)
        self.sleuthline = sleuthline
        
        let sleuthmla = UILabel()
        sleuthmla.textColor = KKToolUtils.color_from_hex("#FF555555")
        sleuthmla.text = "MAXIMUM LOAN AMOUNT"
        sleuthmla.font = KKToolUtils.ubuntu_font(size: 11)
        sleuthv.addSubview(sleuthmla)
        sleuthmla.autoPinEdge(toSuperviewEdge: .left, withInset: 15)
        sleuthmla.autoPinEdge(toSuperviewEdge: .top, withInset: 19)
        sleuthmla.autoSetDimension(.height, toSize: 17)
        
        let sleuthmlam = UILabel()
        sleuthmlam.text = "₹0"
        sleuthmlam.textColor = .white
        sleuthmlam.font = KKToolUtils.ubuntu_font(size: 20, weight: .bold)
        sleuthv.addSubview(sleuthmlam)
        sleuthmlam.autoPinEdge(.left, to: .left, of: sleuthmla)
        sleuthmlam.autoPinEdge(.top, to: .bottom, of: sleuthmla, withOffset: 3)
        sleuthmlam.autoSetDimension(.height, toSize: 33)
        self.sleuthmlam = sleuthmlam
        
        let sergeantstv = UIView()
        sergeantstv.backgroundColor = KKToolUtils.color_from_hex("#FFAAFF00")
        sergeantstv.ss_cornerRadius = 17
        sleuthv.addSubview(sergeantstv)
        sergeantstv.autoPinEdge(toSuperviewEdge: .right, withInset: 15)
        sergeantstv.autoPinEdge(toSuperviewEdge: .top, withInset: 21)
        sergeantstv.autoSetDimension(.height, toSize: 34)
        
        let sergeantst = UILabel()
        sergeantst.font = KKToolUtils.ubuntu_font(size: 13, weight: .bold)
        sergeantst.textColor = KKToolUtils.color_from_hex("#FF0A0A0A")
        sergeantst.text = "Apply"
        sergeantst.textAlignment = .center
        sergeantst.backgroundColor = KKToolUtils.color_from_hex("#FFAAFF00")
        sergeantstv.addSubview(sergeantst)
        sergeantst.autoPinEdge(toSuperviewEdge: .right, withInset: 18)
        sergeantst.autoPinEdge(toSuperviewEdge: .left, withInset: 18)
        sergeantst.autoPinEdge(toSuperviewEdge: .top)
        sergeantst.autoPinEdge(toSuperviewEdge: .bottom)
        self.sergeantst = sergeantst
        
        let sergeantmv = SSSleuthTableCellmv()
        sleuthv.addSubview(sergeantmv)
        sergeantmv.autoPinEdge(.top, to: .bottom, of: sleuthmlam, withOffset: 13)
        sergeantmv.autoPinEdge(toSuperviewEdge: .left, withInset: 15)
        sergeantmv.autoPinEdge(toSuperviewEdge: .right, withInset: 15)
        sergeantmv.autoPinEdge(toSuperviewEdge: .bottom, withInset: 14)
        self.sergeantmv = sergeantmv

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        sleuthline.ss_updateHorizontalGradientFrame()
    }
    
}
