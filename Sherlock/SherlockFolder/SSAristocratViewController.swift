//
//  SSAristocratViewController.swift
//  Sherlock
//
//  Created by Sherlock on 2026/6/26.
//

import UIKit
import WebKit
import KKUtilsKitSwift

class SSAristocratViewController: UIViewController, WKNavigationDelegate, WKScriptMessageHandler {

    @IBOutlet weak var aristoratweb: WKWebView!
    var aristorat: String = ""
    var arisaplis = false
    
    init(_ aris: String?, _ aristoratti: String, isaplis: Bool = false) {
        super.init(nibName: "SSAristocratViewController", bundle: nil)
        self.navigationItem.title = aristoratti
        aristorat = aris ?? ""
        arisaplis = isaplis
    }
    
    @MainActor required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        aristoratweb.configuration.userContentController.add(self, name: sherlockhandler)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        aristoratweb.configuration.userContentController.removeScriptMessageHandler(forName: sherlockhandler)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aristoratweb.navigationDelegate = self
        if let aristorat = URL(string: aristorat) {
            SSSherlockDeduce.ss_deduce()
            aristoratweb.load(URLRequest(url: aristorat))
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        SSSherlockDeduce.ss_deducemiss()
        if !arisaplis {
            return
        }
        if let jsonData = try? JSONSerialization.data(withJSONObject: SSSherlockLogicFree().toDict(), options: []) {
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                aristoratweb?.evaluateJavaScript("rejectData('\(jsonString)')") { result, error in }
            }
        }
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: any Error) {
        SSSherlockDeduce.ss_deducemiss()
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if let body = message.body as? String {
            if body.hasPrefix("thirdUrl") {
                let volumes = body.replacingOccurrences(of: "thirdUrl=", with: "").replacingOccurrences(of: "type=", with: "").components(separatedBy: "&")
                if !volumes.isEmpty, let volume = volumes.first, let volurl = URL(string: String(volume)) {
                    SSSherlockAnalysisPublic.ss_publicpoint(502)
                    UIApplication.shared.open((volurl), options: [:], completionHandler: { (success) in })
                }
            }
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping @MainActor (WKNavigationActionPolicy) -> Void) {
        if let bdurl = navigationAction.request.url {
            if bdurl.absoluteString.hasPrefix("http") {
                decisionHandler(.allow)
                return
            }else {
                if let aristoratti = self.navigationItem.title, aristoratti.contains("Accurate") {
                    decisionHandler(.allow)
                    return
                }
                UIApplication.shared.open(bdurl, options: [:]) { result in
                    if !result {
                        SSSherlockDeduce.ss_deduce("You need to install the app before proceeding.")
                    }
                }
            }
        }
        decisionHandler(.cancel)
    }

}
