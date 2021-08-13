//
//  ToastManager.swift
//  swift-chat-v2-sample
//
//  Created by Miranda Strand on 8/13/21.
//

import UIKit

class ToastManager {

    /*
     Shared instance to be used on the main thread only
     */
    static let shared = ToastManager()

    var isShowingToast = false

    var toastQueue: [(String, Bool)] = []

    var visibleViewController: UIViewController? {
        guard let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first, let rootViewController = window.rootViewController else {
            return nil
        }
        var topViewController = rootViewController
        while let newTopViewController = topViewController.presentedViewController, !newTopViewController.isBeingDismissed {
            topViewController = newTopViewController
        }
        return topViewController
    }

    func showSuccessToast(_ message: String) {
        if isShowingToast {
            toastQueue.insert((message, true), at: 0)
            return
        }
        let toast = UIAlertController(title: "Success", message: message, preferredStyle: .actionSheet)
        isShowingToast = true
        visibleViewController?.present(toast, animated: true) {
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { [weak self] (_) in
                self?.dismissAndShowNext(fromToast: toast)
            })
        }
    }

    func showFailureToast(_ message: String) {
        if isShowingToast {
            toastQueue.insert((message, false), at: 0)
            return
        }
        let toast = UIAlertController(title: "Error", message: message, preferredStyle: .actionSheet)
        toast.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] (_) in
            self?.dismissAndShowNext(fromToast: toast)
        }))
        isShowingToast = true
        visibleViewController?.present(toast, animated: true)
    }

    func dismissAndShowNext(fromToast toast: UIAlertController) {
        toast.dismiss(animated: true) { [weak self] in
            guard let strongSelf = self else {
                return
            }
            strongSelf.isShowingToast = false
            if let (nextMessage, isSuccess) = strongSelf.toastQueue.popLast() {
                isSuccess ? strongSelf.showSuccessToast(nextMessage) : strongSelf.showFailureToast(nextMessage)
            }
        }
    }
}
