//
//  aboutLegal.swift
//  dexly
//
//  Created by Hayden Malcomson on 2016-03-11.
//  Copyright © 2016 Hayden Malcomson. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

class aboutLegal: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var textView: UITextView!
    
    var deviceID = UIDevice.current.modelName
    var versionNumber = UIDevice.current.systemVersion
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        textView.scrollRangeToVisible(NSRange(location:0, length:0))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["haydenmalc@gmail.com"])
        mailComposerVC.setSubject("dexly fb (\(deviceID) | \(versionNumber))")
        mailComposerVC.setMessageBody("", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        _ = UIAlertController(title: "Did not send message", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", preferredStyle: .alert)
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendEmailButtonTapped(sender: AnyObject) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    @IBAction func dismissLegal(sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func developerSite(sender: AnyObject) {
        UIApplication.shared.openURL(URL(string:"http://hmalc.com/")!)
    }
}
