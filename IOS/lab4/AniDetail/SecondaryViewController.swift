//
//  SecondaryViewController.swift
//  AniDetail
//
//  Created by Alexandra Charland on 2/28/21.
//

import UIKit
import WebKit
class SecondaryViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var webSpinner: UIActivityIndicatorView!
    var webpage : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        loadWebPage("https://myanimelist.net/")
        // Do any additional setup after loading the view.
    }
    func loadWebPage(_ urlString: String){
        //the urlString should be a propery formed url
        //creates a URL object
        let url = URL(string: urlString)
        //create a URLRequest object
        let request = URLRequest(url: url!)
        //load the URLRequest object in our web view
        webView.load(request)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let url = webpage {
            loadWebPage(url)
        }
    }
    //WKNavigationDelegate method that is called when a web page begins to load
       func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
           webSpinner.startAnimating()
       }
    
    //WKNavigationDelegate method that is called when a web page loads successfully
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            webSpinner.stopAnimating()
        }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
