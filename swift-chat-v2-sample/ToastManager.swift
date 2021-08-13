//
//  ToastManager.swift
//  swift-chat-v2-sample
//
//  Created by Miranda Strand on 8/13/21.
//

import UIKit

class ToastManager {

    static var visibleViewController: UIViewController? {
        guard let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first, let rootViewController = window.rootViewController else {
            return nil
        }
        var topViewController = rootViewController
        while let newTopViewController = topViewController.presentedViewController, !newTopViewController.isBeingDismissed {
            topViewController = newTopViewController
        }
        return topViewController
    }

    static func showSuccessToast(_ message: String) {
        let toast = UIAlertController(title: "Success", message: message, preferredStyle: .actionSheet)
        visibleViewController?.present(toast, animated: true) {
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { (_) in
                toast.dismiss(animated: true, completion: nil)
            })
        }
    }

    static func showFailureToast(_ message: String) {
        let toast = UIAlertController(title: "Error", message: message, preferredStyle: .actionSheet)
        toast.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            toast.dismiss(animated: true, completion: nil)
        }))
        visibleViewController?.present(toast, animated: true)
    }
}
