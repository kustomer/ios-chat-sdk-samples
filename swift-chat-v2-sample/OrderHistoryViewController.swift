//
//  OrderHistoryViewController.swift
//  swift-chat-v2-sample
//
//  Created by Miranda Strand on 8/11/21.
//

import KustomerChat
import UIKit

class OrderHistoryViewController: UIViewController, OrderCellDelegate, UITableViewDataSource, UITableViewDelegate {

    var user: User?

    var orders: [Order] = []

    var conversations: [Int: String] = [:]

    @IBOutlet weak var welcomeLabel: UILabel!

    @IBOutlet weak var orderTableView: UITableView!

    // MARK: - Init

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.user = MockAuth.shared.currentUser
    }

    deinit {
        print("DEINIT!")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    // MARK: - Kustomer

    func describeCustomer() {
        // TODO: implement this
    }

    func openChat(forOrder order: Order) {
        if let conversationID = conversations[order.id] {
            // If we've opened a conversation for this order before, open the existing conversation
            Kustomer.openConversation(id: conversationID, animated: true) { (result: Result<KUSConversation, KError>) in
                switch result {
                case .success(let conversation):
                    print("Opened conversation with id \(conversation.id ?? "not found")")
                case .failure(let error):
                    print("Error opening conversation \(error.localizedDescription)")
                }
            }
        } else {
            // If this is the first time chatting about this order, open a new conversation and save it to the conversations map
            Kustomer.openNewConversation(initialMessages: ["How can I help with your order of \(order.description)?"], afterCreateConversation: { [weak self] (conversation: KUSConversation) in
                if let conversationID = conversation.id {
                    self?.conversations[order.id] = conversationID
                }
            }, animated: true)
        }
    }
    
    func logOutOfKustomer() {
        Kustomer.logOut { error in
            if let error = error {
                // TODO: show a toast
                ToastManager.showFailureToast("Error logging out of Kustomer chat: \(error.localizedDescription)")
            } else {
                ToastManager.showSuccessToast("Logged out of Kustomer chat")
            }
        }
    }

    // MARK: - Setup

    func setUpUI() {
        guard let user = user else {
            assertionFailure("No user for order history")
            return
        }
        welcomeLabel.text = "Welcome, \(user.email)"
        MockAPIClient().getOrders(forUser: user) { [weak self] result in
            guard let strongSelf = self, case let .success(fetchedOrders) = result else {
                return
            }
            strongSelf.orders = fetchedOrders
            strongSelf.orderTableView.reloadData()
        }
    }

    // MARK: - Actions

    @IBAction func didTapLogOut(_ sender: Any) {
        MockAuth.shared.logOut()
        logOutOfKustomer()
        dismiss(animated: true, completion: nil)
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as? OrderCell else {
            return UITableViewCell()
        }
        if orders.indices.contains(indexPath.row) {
            cell.setUp(withOrder: orders[indexPath.row])
            cell.delegate = self
        }
        return cell
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, heightForRowAt: IndexPath) -> CGFloat {
        return 100.0
    }

    // MARK: - OrderCellDelegate

    func didTapGetHelp(forOrder order: Order) {
        openChat(forOrder: order)
    }

}
