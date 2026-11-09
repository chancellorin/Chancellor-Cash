//
//  SSSherlockEvidence.swift
//  Sherlock
//
//  Created by Sherlock on 2026/7/3.
//

import UIKit
import KakaJSON

struct SSSherlockAnalysisEvidence: Convertible {
    var resultCode: Int = -1
    var resultMsg: String?
    var data: [String: Any]?
}

struct SSSherlockPublicsyseEvidence: Convertible {
    var appEmail: String?
    var officialWebsiteUrl: String?
    var feedbackGuidance: String?
    var retrieveMobileContact: Int?
    var pushMaxCount: Int?
    var pushPerCount: Int?
    var dynamicParameter: SSSherlockPublicsysedyEvidence?
}

struct SSSherlockPublicsysedyEvidence: Convertible {
    var rejectH5: String?

    var userId: String?
    var token: String?
    
    var phone: String?
    var name: String?
    var userStatus: Int?
    var appUserType: String?
    var payAccountModifySwitch: String?
    var maxApplyAmount: String?
    
    var bankCode: String?
    var accountNo: String?
    var accountName: String?
    var creditCard: String?
    
    var hasOrder: Int?
    var firstLoanOptionLine: String?
    var promptCopy: String?
    var withdrawalOrderId: String?
    
    var starRating: String?
    var remarks: String?
    
    var kycId: String?
    var kycStatus: String?

    var buttonKey: String?
    var buttonLabel: String?
    var buttonSort: Int?

    var cardNo: String?
    
    var latestVersion: String?
    var latestVersionUrl: String?
    var updateType: String?

    var connect: String?
}

struct SSSherlockOrdlistEvidence: Convertible {
    var list: [SSSherlocklistEvidence]?
}

struct SSSherlocklistEvidence: Convertible {
    
    var productId: String?
    var productName: String?
    var productLogo: String?
    var orderId: String?

    var orderList: [SSSherlockSergeantEvidence]?
    var bankCardList: [SSSherlockPublicsysedyEvidence]?
    var productInfoList: [SSSherlockSergeantEvidence]?
    var mentationInfoList:  [SSSherlockPublicsysedyEvidence]?
    var kycList: [SSSherlockPublicsysedyEvidence]?
    var kycItemList: [SSSherlockDiplomatEvidence]?
    var amountDetailList: [SSSherlockSergeantEvidence]?
    var list: [String]?
    
    var amindex: Int = 0

}

struct SSSherlockNewspaperTbEvidence: Convertible {
    var newstitx: String?
    var newstip: String?
    var newscontent: String?
    var newscolor: String = "AAAAAA"
}

struct SSSherlockNewspaperEvidence: Convertible {
    var product: SSSherlockSergeantEvidence?
    var bankCard: SSSherlockPublicsysedyEvidence?
    var orderDetail: SSSherlockSergeantEvidence?
}

struct SSSherlockDiplomatEvidence: Convertible {
    var itemCode: String?
    var itemName: String?
    var regularExpression: String?
    var itemSort: Int?
    var itemType: Int?
    var isRequired: Int?
    var buttonList: [SSSherlockPublicsysedyEvidence]?
    
    var dipkey: String?
    var diptant: String?
    var diptantti: String?

    var echoMap: SSSherlockPublicsysedyEvidence?
}

struct SSSherlockSergeantEvidence: Convertible {
    var orderId: String?
    var productId: String?
    var productName: String?
    var orderStatus: Int?
    var loanAmount: String?
    var applyDate: String?
    var loanDate: String?
    var dueDate: String?
    var repayDate: String?
    var productTermV3Response: SSSherlocklistEvidence?
    
    var productLogo: String?
    
    var userType: Int?
    var sheree: String?
    var assamo: String?
    
    var EMIs: Int?
    var EMIAmount: String?
    var EMIRepayDate: String?
    var showTerm: String?
    var loanTerm: String?
    var receiptAmount: String?
    var feeAmount: String?
    var interestAmount: String?
    var taxAmount: String?
    var payoutDate: String?
    var penaltyAmount: String?
    var totalRepaymentAmount: String?
    var reductionAmount: String?
    var alreadyRepaymentAmount: String?
    var shouldRepaymentAmount: String?
    var repaymentDate: String?
    
    var termDetailList: [SSSherlockSergeantEvidence]?
    var terindex: Int = 0
    var arrivalAmount: String?
    var borrowingDate: String?
    
    var laboraselected = true
}

struct SSSherlockEvidence {
    var dcUpFlag: String?
    
    var orderId: String?
    var productId: String?
    
    var mobile: String?
    var verifyType: String?
    var verifyCode: String?
    var longitude: String?
    var latitude: String?
    var imei: String?
    var serialNo: String?
    
    var description: String?
    var whatsApp: String?
    var pictureUrl: String?
        
    var kycId: String?
    
    var kycCommitItemList: [[String: Any]]?
    
    var liveness: String?
    
    var itemCode: String?
    var itemValueType: String?
    var itemValue: String?
    
    var state: String?
    var city: String?
    var bank: String?
    var branch: String?
    
    var accountType: String?
    var bankCode: String?
    var accountNo: String?
    var accountNoVerify: String?
    var creditCard: String?

    var periodNoList: [Int]?
    
    var appType: String?
    
    var loanAmount: String?
    var showTerm: String?
    var list: [[String: Any]]?
    var allowContact: String?
    var loanTerm: String?
    
    var eventCode: String?
    var eventContent: String?
    var remark1: String?
    var remark2: String?
    var remark3: String?
    
    var adid: String?
    
    var productIds: String?
    var loanAmounts: String?
    var loanTerms: String?

    func toDict() -> [String: Any] {
        var result: [String: Any] = [:]
        let mirror = Mirror(reflecting: self)
        
        for child in mirror.children {
            guard let key = child.label else { continue }
            var value = child.value
            var m = Mirror(reflecting: value)
            while m.displayStyle == .optional {
                guard let wrapped = m.children.first?.value else {
                    value = ()
                    break
                }
                value = wrapped
                m = Mirror(reflecting: value)
            }
            guard !(value is ()) else { continue }
            if let str = value as? String, str.isEmpty { continue }
            if let arr = value as? [Any], arr.isEmpty { continue }
            result[key] = value
        }
        return result
    }
    
}
