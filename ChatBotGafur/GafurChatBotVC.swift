//
//  GafurChatBotVC.swift
//  ChatBotGafur
//
//  Created by Prateek Chaubey on 7/21/18.
//  Copyright © 2018 Prateek Chaubey. All rights reserved.
//

import UIKit
import AVFoundation
import ApiAI
import MessageKit

class GafurChatBotVC: UIViewController {
    
    let speechSynthesizer = AVSpeechSynthesizer()
    
    @IBOutlet weak var botResponse: UILabel!
    @IBOutlet weak var messageField: UITextField!
    @IBOutlet var chatToolBar: UIToolbar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "CHAT WITH GAFUR BHAI"
        messageField.autocorrectionType = .no
        NotificationCenter.default.addObserver(self, selector: #selector(GafurChatBotVC.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(GafurChatBotVC.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func speechAndText(text: String) {
        let speechUtterance = AVSpeechUtterance(string: text)
        speechSynthesizer.speak(speechUtterance)
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
            self.botResponse.text = text
        }, completion: nil)
    }
    
    @IBAction func sendMessage() {
        
        let request = ApiAI.shared().textRequest()
        
        if let text = self.messageField.text, text != "" {
            request?.query = text
        } else {
            return
        }
        
        request?.setMappedCompletionBlockSuccess({(request, response) in
            let response = response as! AIResponse
            if let textResponse = response.result.fulfillment.messages {
                let textResArray = textResponse[0] as NSDictionary
                self.botResponse.text = textResArray.value(forKey: "speech") as? String
            }
        }, failure: {(request, error) in
            print(error!)
        })
        
        ApiAI.shared().enqueue(request)
        messageField.text = ""
    }
    
    func createToolBar() {
        
        chatToolBar?.barStyle = UIBarStyle.default
        chatToolBar?.tintColor = UIColor.lightGray
        chatToolBar?.sizeToFit()
        
        let cameraButton = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: nil)
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let sendButton = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(sendMessage))
        
        chatToolBar?.setItems([cameraButton, flexibleSpace, sendButton], animated: true)
        messageField.inputAccessoryView = chatToolBar
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            self.chatToolBar?.frame = CGRect(x: 0, y: keyboardSize.height, width: keyboardSize.width, height: 44)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            self.chatToolBar?.frame = CGRect(x: 0, y: self.view.frame.size.height-64, width: keyboardSize.width, height: 44)
        }
    }

}

extension GafurChatBotVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
}
