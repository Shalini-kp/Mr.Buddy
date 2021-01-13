//
//  ChatViewController.swift
//  Mr.Buddy
//
//  Copyright © 2020 Shalini. All rights reserved.
//

import UIKit

struct ChatItems: Codable {
    var isBot: Bool?
    var isImageVisible: Bool?
    var textMessage: String?
}

class ChatViewController: UIViewController {

    @IBOutlet weak var chatToolBox: UIView!
    @IBOutlet weak var chatViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var chatViewController: UITableView!
    @IBOutlet weak var chatTextView: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    
    @IBAction func sendButtonTapped(_ sender: Any) {
        chatItems.append(ChatItems(isBot: false, isImageVisible: false, textMessage: chatTextView.text))
        chatViewController.reloadData()
        chatTextView.text = nil
    }
    
    var chatItems = [ChatItems]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        chatViewController.rowHeight = UITableView.automaticDimension
        chatViewController.estimatedRowHeight = 300
        
        chatItems.append(ChatItems(isBot: true, isImageVisible: false, textMessage: "Hi"))
        chatItems.append(ChatItems(isBot: true, isImageVisible: false, textMessage: "How are you"))
        chatItems.append(ChatItems(isBot: true, isImageVisible: false, textMessage: "Hi How are you How are you How are you How are you How are you How are you How are you How are you"))
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        view.addGestureRecognizer(tapGesture)
        
    self.navigationController?.navigationItem.hidesBackButton = false
    }

    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(ChatViewController.keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatViewController.keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        chatViewController.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidHideNotification
            , object: nil)
    }
    
    @objc func handleTapGesture(tapGesture: UITapGestureRecognizer)
    {
        view.endEditing(true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
            
            print(" ***** keyboardWillShow ******")
            chatViewBottomConstraint.constant = -keyboardHeight
             //chatViewController.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.8, animations: {
            // For some reason adding inset in keyboardWillShow is animated by itself but removing is not, that's why we have to use animateWithDuration here
            //self.chatViewController.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            print(" ***** keyboardWillHide ******")
            self.chatViewBottomConstraint.constant = 0
        })
    }
    
    func heightWithConstrainedWidth(_ text: String, width: CGFloat, font: UIFont) -> CGRect {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = text.boundingRect(with: constraintRect, options: [NSStringDrawingOptions.usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox
    }
    
    func add(_ a: Int,_ b: Int) -> Int {
        return a + b
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = chatItems[indexPath.row]
        
        if item.isBot ?? false {
           guard let cell = tableView.dequeueReusableCell(withIdentifier: "SenderTableViewCellID", for: indexPath) as? SenderTableViewCell else { return UITableViewCell()}
            cell.botTextView.text = chatItems[indexPath.row].textMessage
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReceiverTableViewCellID", for: indexPath) as? ReceiverTableViewCell else { return UITableViewCell()}
            cell.userTextView.text = chatItems[indexPath.row].textMessage
            
            return cell
        }
    }
}
