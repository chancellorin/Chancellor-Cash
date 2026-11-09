//
//  SSSergeantTableCell.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/25.
//

import UIKit
import KKUtilsKitSwift
import PureLayout

class SSSergeantTableCell: UITableViewCell {
    
    weak var sergeantcolv: UIView!
    weak var sergeantna: UILabel!
    weak var sergeantst: UILabel!
    weak var sergeantmo: UILabel!
    weak var sergeantfid: UILabel!
    weak var sergeantlad: UILabel!
    
    var sergeantEvidence: SSSherlockSergeantEvidence = SSSherlockSergeantEvidence() {
        didSet {
            self.sergeantna.text = sergeantEvidence.productName
            self.sergeantmo.text = "₹\(KKToolUtils.format_amount(sergeantEvidence.loanAmount))"
            SSSergeantNeed.sergeantColorstring(sergeantEvidence.orderStatus) { color, bgcolor in
                self.sergeantcolv.backgroundColor = KKToolUtils.color_from_hex(color)
                self.sergeantst.textColor = KKToolUtils.color_from_hex(color)
                self.sergeantst.backgroundColor = KKToolUtils.color_from_hex(bgcolor)
                self.sergeantst.ss_borderColor = KKToolUtils.color_from_hex("45\(color)")
            } staterult: { rult in
                self.sergeantst.text = "· \(rult)"
            }
            
            if let evid = sergeantEvidence.loanDate, !evid.isEmpty {
                self.sergeantfid.ss_splitByColonText("Payment date: \(evid)")
            } else {
                self.sergeantfid.ss_splitByColonText("Date of application: \(sergeantEvidence.applyDate ?? "")")
            }
            if let evid = sergeantEvidence.repayDate, !evid.isEmpty, sergeantEvidence.orderStatus == 70 {
                self.sergeantlad.ss_splitByColonText("Repayment date: \(evid)")
            } else if let evid = sergeantEvidence.dueDate, !evid.isEmpty {
                self.sergeantlad.ss_splitByColonText("Due date: \(evid)")
            }else {
                self.sergeantlad.ss_splitByColonText("Due date: -")
            }

        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        sergeant_stepui()
    }
    
    func sergeant_stepui() {
        let sergeantv = UIView()
        contentView.addSubview(sergeantv)
        sergeantv.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 4, left: 14, bottom: 4, right: 14))
        
        let sergeantcolv = UIView()
        sergeantcolv.ss_cornerRadius = 14
        sergeantv.addSubview(sergeantcolv)
        sergeantcolv.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 100))
        self.sergeantcolv = sergeantcolv
        
        let sergeantbv = UIView()
        sergeantbv.ss_cornerRadius = 14
        sergeantbv.backgroundColor = KKToolUtils.color_from_hex("#FF161616")
        sergeantv.addSubview(sergeantbv)
        sergeantbv.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0, left: 3, bottom: 0, right: 0))
        
        let sergeantna = UILabel()
        sergeantna.font = KKToolUtils.ubuntu_font(size: 14, weight: .bold)
        sergeantna.textColor = .white
        sergeantna.text = "Chancellor Cash"
        sergeantbv.addSubview(sergeantna)
        sergeantna.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 14, left: 16, bottom: 0, right: 0), excludingEdge: .bottom)
        sergeantna.autoSetDimension(.height, toSize: 21)
        self.sergeantna = sergeantna
        
        let sergeantst = SSLabel()
        sergeantst.textInsets = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        sergeantst.font = KKToolUtils.ubuntu_font(size: 11, weight: .bold)
        sergeantst.ss_borderWidth = 1
        sergeantst.ss_cornerRadius = 7
        sergeantbv.addSubview(sergeantst)
        sergeantst.autoSetDimension(.height, toSize: 32)
        sergeantst.autoPinEdge(toSuperviewEdge: .right, withInset: 10)
        sergeantst.autoPinEdge(toSuperviewEdge: .top, withInset: 10)
        self.sergeantst = sergeantst
        
        let sergeantmo = UILabel()
        sergeantmo.font = KKToolUtils.ubuntu_font(size: 16, weight: .bold)
        sergeantmo.textColor = .white
        sergeantmo.text = "₹"
        sergeantbv.addSubview(sergeantmo)
        sergeantmo.autoPinEdge(.top, to: .bottom, of: sergeantna, withOffset: 12)
        sergeantmo.autoPinEdge(.left, to: .left, of: sergeantna)
        sergeantmo.autoSetDimension(.height, toSize: 24)
        self.sergeantmo = sergeantmo

        let sergeantfid = UILabel()
        sergeantbv.addSubview(sergeantfid)
        sergeantfid.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10)
        sergeantfid.autoPinEdge(.left, to: .left, of: sergeantna)
        sergeantfid.autoSetDimension(.height, toSize: 17)
        self.sergeantfid = sergeantfid
        
        let sergeantlad = UILabel()
        sergeantbv.addSubview(sergeantlad)
        sergeantlad.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10)
        sergeantlad.autoPinEdge(.right, to: .right, of: sergeantst)
        sergeantlad.autoSetDimension(.height, toSize: 17)
        self.sergeantlad = sergeantlad
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
