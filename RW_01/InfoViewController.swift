//
//  InfoViewController.swift
//  RW_01
//
//  Created by Andrey Velikiy on 12/6/17.
//  Copyright © 2017 Andrey Velikiy. All rights reserved.
//

import UIKit
import WebKit

class InfoViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
	@IBOutlet weak var instructions: WKWebView!
	var activityIndicator: UIActivityIndicatorView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		//load HTML file
		let url = Bundle.main.url(forResource: "BullsEye", withExtension: "html")
		instructions.loadFileURL(url!, allowingReadAccessTo: url!)
		instructions.navigationDelegate = self
		//add/start activity indicator
		activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
		activityIndicator.center = view.center
		activityIndicator.startAnimating()
		self.view.addSubview(activityIndicator)
		activityIndicator.hidesWhenStopped = true
    }
	
	//delegate method to hide activity indicator on page load
	func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
		if !instructions.isLoading {
			activityIndicator.stopAnimating()
			activityIndicator.isHidden = true
		}
	}
	
    @IBAction func close () {
        dismiss(animated: true, completion: nil)
    }
}
