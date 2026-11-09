//
//  SSSherlockAnalysisError.swift
//  Sherlock
//
//  Created by Sherlock on 2026/7/3.
//

import UIKit

enum SSSherlockAnalysisError: Error {
    case sherlock_error(Int, String?)
    
    var errmsg: String? {
        switch self {
        case .sherlock_error(_, let msg): return msg
        }
    }
    
    var errcode: Int? {
        switch self {
        case .sherlock_error(let code, _): return code
        }
    }
}


struct SSSherlockAnalysisResultcode {
    static let analysisOutResultcode: Set<Int> = [2000001, 2000002, 2002001]
    static let analysisUpgResultcode: Set<Int> = [2009006]
    static let analysisResultcode: Set<Int> = [200]
}
