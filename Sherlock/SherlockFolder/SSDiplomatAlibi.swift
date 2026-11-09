//
//  SSDiplomatAlibi.swift
//  Sherlock
//
//  Created by Sherlock on 2026/7/7.
//

import UIKit
import KKUtilsKitSwift

struct SSDiplomatAlibi {
    static func diplomat_alibi(diplomatEvids: [SSSherlockDiplomatEvidence], resultsucc: @escaping ([[String: String]]) -> Void) {
        var evids: [[String: String]] = []
        for evid in diplomatEvids {
            if evid.isRequired == 1 {
                guard let diptant = evid.diptant, !diptant.isEmpty else {
                    SSSherlockDeduce.ss_deduce("Please provide a valid value for \"KT_XXX\".".replacingOccurrences(of: "KT_XXX", with: evid.diptantti ?? evid.itemName ?? ""))
                    return
                }
            }
            if let evidex = evid.regularExpression, !evidex.isEmpty, let diptant = evid.diptant, !diptant.isEmpty {
                guard NSPredicate(format: "SELF MATCHES %@", evidex).evaluate(with: diptant) else {
                    SSSherlockDeduce.ss_deduce("Please provide a valid value for \"KT_XXX\".".replacingOccurrences(of: "KT_XXX", with: evid.diptantti ?? evid.itemName ?? ""))
                    return
                }
            }
            let dipsult = ["itemCode": evid.itemCode ?? "", "itemValueType": "1", "itemValue": evid.dipkey ?? evid.diptant ?? ""]
            evids.append(dipsult)
        }
        resultsucc(evids)
    }
    
    static func diplomat_alibifind() -> [SSSherlockDiplomatEvidence] {
        let sherst = SSSherlockDiplomatEvidence(itemName: "BANK State", itemType: 10, isRequired: 1)
        let sherci = SSSherlockDiplomatEvidence(itemName: "BANK City", itemType: 10, isRequired: 1)
        let sherba = SSSherlockDiplomatEvidence(itemName: "BANK Name", itemType: 10, isRequired: 1)
        let sherbr = SSSherlockDiplomatEvidence(itemName: "BANK Branch", itemType: 10, isRequired: 1)
        return [sherst, sherci, sherba, sherbr]
    }
}
