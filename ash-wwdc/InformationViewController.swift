//
//  InformationViewController.swift
//  ash-wwdc
//
//  Created by Ash Bhat on 4/24/15.
//  Copyright (c) 2015 Ash Bhat. All rights reserved.
//

import Foundation
import UIKit

@objc class InformationViewController: UIViewController {
    
    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var headerImage: UIImageView!
    var relatedUrl: NSURL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(animated: Bool) {
        descriptionTextView.scrollRangeToVisible(
            NSRange(location: 0, length: 0))
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func openUrl(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(relatedUrl)
    }
    
}