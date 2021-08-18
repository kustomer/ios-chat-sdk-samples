//
//  GuestViewController.swift
//  swift-chat-v2-sample
//
//  Created by Miranda Strand on 8/17/21.
//

import KustomerChat
import UIKit

class GuestViewController: UITableViewController, KUSChatListener {

    let unreadCount = UILabel()

    let activeCount = UILabel()

    var listenerHandle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpHeader()
        setUpFooter()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Listen to the unread count
        listenerHandle = Kustomer.chatProvider.addChatListener(self)

        // Update the active conversations count
        let count = Kustomer.chatProvider.openConversationCount()
        activeCount.text = "\(count) active conversations"
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Stop listening to the unread count
        if let listenerHandle = listenerHandle {
            Kustomer.chatProvider.removeChatListener(listenerHandle)
        }
    }

    // MARK: - KUSChatListener

    func onUnreadCountChange(count: Int) {
        unreadCount.text = "\(count) unread count"
    }

    // MARK: - Actions

    @IBAction func openSDK(_ sender: Any) {
        Kustomer.show()
    }

    @IBAction func openNewChat(_ sender: Any) {
        Kustomer.openNewConversation(afterCreateConversation: { [weak self] _ in
            // Update the active conversation count when we've opened a new conversation
            let count = Kustomer.chatProvider.openConversationCount()
            self?.activeCount.text = "\(count) active conversations"
        }, animated: true)
    }

    @IBAction func openChatOnly(_ sender: Any) {
        Kustomer.show(preferredView: .onlyChat)
    }

    @IBAction func openKBOnly(_ sender: Any) {
        Kustomer.show(preferredView: .onlyKnowledgeBase)
    }

    // MARK: - Setup

    private func setUpHeader() {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 150))

        let title = UILabel(frame: .zero)
        title.text = "Kustomer Sample App"
        title.font = title.font.withSize(24.0)
        title.textAlignment = .center
        title.translatesAutoresizingMaskIntoConstraints = false
        header.addSubview(title)

        unreadCount.text = "0 unread conversations"
        unreadCount.textAlignment = .left
        unreadCount.translatesAutoresizingMaskIntoConstraints = false
        header.addSubview(unreadCount)

        activeCount.textAlignment = .right
        activeCount.translatesAutoresizingMaskIntoConstraints = false
        header.addSubview(activeCount)

        title.centerXAnchor.constraint(equalTo: header.centerXAnchor).isActive = true
        title.widthAnchor.constraint(equalTo: header.widthAnchor).isActive = true
        unreadCount.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 16.0).isActive = true
        unreadCount.widthAnchor.constraint(equalTo: header.widthAnchor, multiplier: 0.4).isActive = true
        unreadCount.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        unreadCount.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 16.0).isActive = true
        unreadCount.bottomAnchor.constraint(equalTo: header.bottomAnchor, constant: -16.0).isActive = true
        activeCount.trailingAnchor.constraint(equalTo: header.trailingAnchor, constant: -16.0).isActive = true
        activeCount.widthAnchor.constraint(equalTo: header.widthAnchor, multiplier: 0.4).isActive = true
        activeCount.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        activeCount.bottomAnchor.constraint(equalTo: header.bottomAnchor, constant: -16.0).isActive = true
        
        tableView.tableHeaderView = header
    }

    private func setUpFooter() {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100.0))
        let returnToLogin = UIAction { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        }
        let logInButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50), primaryAction: returnToLogin)
        logInButton.setTitle("Return to Log In", for: .normal)
        logInButton.setTitleColor(.systemBlue, for: .normal)
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        footer.addSubview(logInButton)
        logInButton.centerXAnchor.constraint(equalTo: footer.centerXAnchor).isActive = true
        logInButton.centerYAnchor.constraint(equalTo: footer.centerYAnchor).isActive = true
        tableView.tableFooterView = footer
    }
}
