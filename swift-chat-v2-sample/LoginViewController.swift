//
//  LoginViewController.swift
//  swift-chat-v2-sample
//
//  Created by Miranda Strand on 8/11/21.
//

import KustomerChat
import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!

    @IBOutlet weak var passwordTextField: UITextField!

    @IBAction func didTapLogInButton(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        MockAuth.shared.logIn(withEmail: email, password: password) { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            guard case .success = result else {
                return
            }
            strongSelf.logInToKustomer(withEmail: email)
            strongSelf.performSegue(withIdentifier: "loginToOrderHistory", sender: strongSelf)
        }
    }

    func logInToKustomer(withEmail email: String) {
        /*
         Check first if the user is already logged in. Calling Kustomer.logIn saves an encrypted key to the iOS keychain.
         This saves the customer identity across all app restarts. Do not just call Kustomer.logIn or Kustomer.logOut every time
         the app loads because this requires you to generate a new JWT on each app load.
         */
        Kustomer.isLoggedIn(userEmail: email, userId: nil) { (result: Result<Bool, KError>) in
            guard case let .success(userIsLoggedIn) = result else {
                DispatchQueue.main.async {
                    ToastManager.shared.showFailureToast("Could not get Kustomer chat login status")
                }
                return
            }
            if userIsLoggedIn {
                DispatchQueue.main.async {
                    ToastManager.shared.showSuccessToast("Already logged in to Kustomer chat")
                }
                return
            }

            /*
             Fetch a JSON Web Token (JWT) from your backend. Here our mock API client is calling the completion after a short delay
             with the hardcoded JWT value from Constants.swift. This is not suitable for use in production. Always generate the JWT
             server-side before you pass the token to the client SDK. Never store the token client-side. This helps secure customer
             chat histories and ensure that your secret keys stay private.
             */
            MockAPIClient().getJWT(forEmail: email) { result in
                guard case let .success(jwt) = result else {
                    return
                }

                /*
                 Now we can log in with the hashed JWT payload to securely identify the user.
                 */
                Kustomer.logIn(jwt: jwt) { result in
                    switch result {
                    case .success:
                        DispatchQueue.main.async {
                            ToastManager.shared.showSuccessToast("Logged in to Kustomer chat")
                        }

                        /*
                         Now that we're logged in, we can add this email address to the Customer object of the customer logged into the chat.
                         This will allow messages from this customer to appear with the associated email. Note: if you created your JWT with
                         the same email address you used to log in, then the email would already be there, but the JWT could have instead used
                         an externalId or a different email than the one here, which is why we make this call.
                         */
                        Kustomer.chatProvider.describeCurrentCustomer(email: email) { result in
                            DispatchQueue.main.async {
                                switch result {
                                case .success:
                                    ToastManager.shared.showSuccessToast("Added email to Customer object")
                                case .failure(let error):
                                    ToastManager.shared.showFailureToast("Failed to add email to Customer object: \(error.localizedDescription)")
                                }
                            }
                        }

                    case .failure(let error):
                        DispatchQueue.main.async {
                            ToastManager.shared.showFailureToast("Error logging in to Kustomer chat: \(error.localizedDescription)")
                        }
                    }
                }
            }
        }
    }
}

