//
//  WebViewController.swift
//  HNReader
//
//  Created by Bertalan Kormendy on 2017. 08. 15..
//  Copyright © 2017. Bertalan Kormendy. All rights reserved.
//
//  IN THIS FILE:   custom webview controller
//                  loads url on viewDidLoad() that was passed before the segue
//                  TODO: navigation (< >), open in Safari, share
//
//

import UIKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    var url: String?
    
    @IBAction func done(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.loadRequest(URLRequest(url: URL(string: url!)!))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
