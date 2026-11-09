//
//  SSSergeantColor.swift
//  Sherlock
//
//  Created by Sherlock on 2026/7/2.
//

import UIKit
import KKUtilsKitSwift

struct SSSergeantNeed {
    static func sergeantColorstring(_ serg: Int? = 0, colorult: ((_ color: String, _ bgcolor: String) -> Void)? = nil, staterult: ((_ rult: String) -> Void)? = nil, tiprult: ((_ rult: String) -> Void)? = nil) {
        switch serg {
        case 10:
            colorult?("FFCC00", "2A2200")
            staterult?("Unfinished Application")
            tiprult?("Our data submission process is fast and simple.")

        case 30:
            colorult?("5577FF", "001030")
            staterult?("Under review")
            tiprult?("Your application is under review. You can view the details in Order history.")

        case 31:
            colorult?("FF5555", "250000")
            staterult?("Reject")
            tiprult?("Your loan application can not be approved.")

        case 32:
            colorult?("00CCBB", "002825")
            staterult?("Pending")
            tiprult?("Please log in your account to confirm the order so that we can transfer the funds to your bank account.")

        case 36:
            colorult?("4499FF", "001C30")
            staterult?("Update bank account")
            tiprult?("Our loan disbursement is hindered due to incorrect bank card information. Please update it promptly.")

        case 50:
            colorult?("BB55FF", "1E002E")
            staterult?("Loan processing")
            tiprult?("We are tranferring money to your bank account. Please wait patiently")

        case 60:
            colorult?("FFAA00", "2A1A00")
            staterult?("Repayment Due")
            tiprult?("Your loan has been disbursed. Please repay on time.")

        case 61:
            colorult?("FF4444", "2A0000")
            staterult?("Overdue")
            tiprult?("This order is now overdue. Please repay as soon as possible to avoid further damage to your credit.")

        case 70:
            colorult?("AAFF00", "0D2500")
            staterult?("Pay off")
            tiprult?("Your loan order has been settled, and your credit score has increased. You are now eligible to apply for a higher loan amount.")

        case 99:
            colorult?("777777", "222222")
            staterult?("Cancel")
            tiprult?("Your order has been cancelled. If you require further assistance, please feel free to contact our Customer Service team.")

        default:
            colorult?("AAFF00", "2A1A00")
            staterult?("")
            tiprult?("A high credit score leads to a higher loan amount. Maintain your credit to enjoy a larger loan limit.")
        }
    }
    
    static func laboratoryEvidences(_ laborevid: SSSherlocklistEvidence?) -> [SSSherlockNewspaperTbEvidence]  {
        guard let laborevid = laborevid, let plist = laborevid.productInfoList, !plist.isEmpty else { return [] }
        var sergeants: [SSSherlockNewspaperTbEvidence] = []
        
        var allamo = 0
        var allfee = 0
        var allreamo = 0
        
        for i in plist.indices {
            guard let res = plist[i].productTermV3Response, plist[i].laboraselected, let amoList = res.amountDetailList, !amoList.isEmpty else { continue }
            let laamo = Int(amoList[res.amindex].loanAmount ?? "0") ?? 0
            allamo += laamo
            let amoItem = amoList[res.amindex]
            if let terList = amoItem.termDetailList, !terList.isEmpty {
                allfee += laamo - (Int(terList[amoItem.terindex].arrivalAmount ?? "0") ?? 0)
                allreamo += Int(terList[amoItem.terindex].arrivalAmount ?? "0") ?? 0
            }
        }
        
        sergeants.append(SSSherlockNewspaperTbEvidence(newstitx: "Total amount", newscontent: "₹\(KKToolUtils.format_amount("\(allamo)"))", newscolor: "#FDE047"))
        sergeants.append(SSSherlockNewspaperTbEvidence(newstitx: "Total fee", newscontent: "₹\(KKToolUtils.format_amount("\(allfee)"))", newscolor: "#FDE047"))
        sergeants.append(SSSherlockNewspaperTbEvidence(newstitx: "Amount received", newscontent: "₹\(KKToolUtils.format_amount("\(allreamo)"))", newscolor: "#FDE047"))

        return sergeants
    }
    
    static func sergeantEvidences(_ islabor: Bool = false, _ sergevid: SSSherlockSergeantEvidence?, _ isrest: Bool = false) -> [SSSherlockNewspaperTbEvidence] {
        guard let sergevid = sergevid else { return [] }
        var sergeants: [SSSherlockNewspaperTbEvidence] = []
        sergeantColorstring(sergevid.orderStatus) { color, bgcolor in
            sergeants.append(SSSherlockNewspaperTbEvidence(newstitx: "Amount received", newstip: "Service fee and GST are deducted from the loan amount for your received amount.", newscontent: "₹\(KKToolUtils.format_amount(sergevid.receiptAmount ?? sergevid.arrivalAmount))", newscolor: color))
            sergeants.append(SSSherlockNewspaperTbEvidence(newstitx: "Service fee", newstip: "This fee is collected by the financial institution for loan services.", newscontent: "₹\(KKToolUtils.format_amount(sergevid.feeAmount))"))
            if sergeanValue(sergevid.interestAmount) {
                sergeants.append(SSSherlockNewspaperTbEvidence(newstitx: "Interest", newstip: "It is calculated using your loan amount, loan period and the interest rate for this product.", newscontent: "₹\(KKToolUtils.format_amount(sergevid.interestAmount))"))
            }
            sergeants.append(SSSherlockNewspaperTbEvidence(newstitx: "GST", newscontent: "₹\(KKToolUtils.format_amount(sergevid.taxAmount))"))

            if sergeanValue(sergevid.payoutDate) {
                sergeants.append(SSSherlockNewspaperTbEvidence(newstitx: "Payment date", newscontent: sergevid.payoutDate))
            } else {
                sergeants.append(SSSherlockNewspaperTbEvidence(newstitx: "Date of application", newscontent: sergeanReturnValue(sergevid.applyDate ?? sergevid.borrowingDate)))
            }
            if !isrest {
                sergeants.append(SSSherlockNewspaperTbEvidence(newstitx: "Due date", newscontent: sergeanReturnValue( islabor ? sergevid.repaymentDate : sergevid.dueDate)))
            }
            
            if !islabor {
                if sergeanValue(sergevid.penaltyAmount) {
                    sergeants.append(SSSherlockNewspaperTbEvidence(newstitx: "Late charge", newscontent: "₹\(KKToolUtils.format_amount(sergevid.penaltyAmount))"))
                }
                if sergeanValue(sergevid.totalRepaymentAmount), [60, 61, 70].contains(sergevid.orderStatus) {
                    sergeants.append(SSSherlockNewspaperTbEvidence(newstitx: "Total repayment", newscontent: "₹\(KKToolUtils.format_amount(sergevid.totalRepaymentAmount))"))
                }
                if sergeanValue(sergevid.reductionAmount) {
                    sergeants.append(SSSherlockNewspaperTbEvidence(newstitx: "Amount of deduction", newscontent: "₹\(KKToolUtils.format_amount(sergevid.reductionAmount))"))
                }
                if sergeanValue(sergevid.alreadyRepaymentAmount) {
                    sergeants.append(SSSherlockNewspaperTbEvidence(newstitx: "Amount repaid", newscontent: "₹\(KKToolUtils.format_amount(sergevid.alreadyRepaymentAmount))", newscolor: color))
                }
                if [60, 61].contains(sergevid.orderStatus) {
                    if Float(sergevid.shouldRepaymentAmount ?? "0") ?? 0 < 0 {
                        sergeants.append(SSSherlockNewspaperTbEvidence(newstitx: "Amount due", newscontent: "₹0"))
                    }else {
                        if sergeanValue(sergevid.alreadyRepaymentAmount), sergeanValue(sergevid.reductionAmount) {
                            sergeants.append(SSSherlockNewspaperTbEvidence(newstitx: "Amount due", newscontent: "₹\(KKToolUtils.format_amount(sergevid.shouldRepaymentAmount))"))
                        }
                    }
                }
                if sergeanValue(sergevid.repaymentDate), [70].contains(sergevid.orderStatus) {
                    sergeants.append(SSSherlockNewspaperTbEvidence(newstitx: "Repayment date", newscontent: sergevid.repaymentDate))
                }
            }
            
            if sergevid.EMIs ?? 0 > 1 {
                sergeants.append(SSSherlockNewspaperTbEvidence(newstitx: "1st EMI Date", newscontent: sergevid.EMIRepayDate))
                sergeants.append(SSSherlockNewspaperTbEvidence(newstitx: "EMI Amount", newscontent: "₹\(KKToolUtils.format_amount(sergevid.EMIAmount))", newscolor: color))
                if !islabor {
                    sergeants.append(SSSherlockNewspaperTbEvidence(newstitx: "EMIs", newscontent: "\(sergevid.EMIs ?? 0)"))
                }
            }
        }
        
        func sergeanValue(_ ser: String?) -> Bool {
            if let serge = ser, !serge.isEmpty, serge != "0" {
                return true
            }
            return false
        }
        
        func sergeanReturnValue(_ ser: String?) -> String {
            if let serge = ser, !serge.isEmpty {
                return serge
            }
            return "-"
        }
        
        return sergeants
    }
}
