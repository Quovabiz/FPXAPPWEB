//
//  ViewController.swift
//  FPXAPPWEB
//
//  Created by Felix Holzapfel on 14.07.24.
//

import UIKit
import WebKit
import LocalAuthentication

class ViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Check if the user has already logged in before
        if KeychainHelper.load(key: "userCredentials") != nil {
            authenticateUser()
        } else {
            // Proceed with normal login flow
            loadWebView()
        }
    }

    func loadWebView() {
        let url = URL(string: "https://fpx.art")!
        let request = URLRequest(url: url)
        webView.load(request)
    }

    func saveCredentials(username: String, password: String) {
        let credentials = "\(username):\(password)"
        if let credentialsData = credentials.data(using: .utf8) {
            let status = KeychainHelper.save(key: "userCredentials", data: credentialsData)
            if status == errSecSuccess {
                print("Credentials saved successfully")
            } else {
                print("Error saving credentials: \(status)")
            }
        }
    }

    func authenticateUser() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authenticate with Face ID"

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        // Authentication was successful
                        if let credentialsData = KeychainHelper.load(key: "userCredentials"),
                           let credentials = String(data: credentialsData, encoding: .utf8) {
                            let credentialsArray = credentials.split(separator: ":")
                            let username = String(credentialsArray[0])
                            let password = String(credentialsArray[1])
                            // Proceed with login using stored username and password
                            self.login(username: username, password: password)
                        }
                    } else {
                        // Authentication failed
                        let alert = UIAlertController(title: "Authentication Failed", message: "Sorry, we could not authenticate you.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default))
                        self.present(alert, animated: true)
                    }
                }
            }
        } else {
            // Biometrics are not available
            let alert = UIAlertController(title: "Biometrics Unavailable", message: "Your device is not configured for biometric authentication.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }

    func login(username: String, password: String) {
        // Implement your login logic here
        print("Logging in with username: \(username) and password: \(password)")
        loadWebView()  // Load the web view after successful login
    }
}

// Keychain Helper
class KeychainHelper {

    static func save(key: String, data: Data) -> OSStatus {
        let query = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ] as [String : Any]

        SecItemDelete(query as CFDictionary)

        return SecItemAdd(query as CFDictionary, nil)
    }

    static func load(key: String) -> Data? {
        let query = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ] as [String : Any]

        var dataTypeRef: AnyObject? = nil

        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

        if status == noErr {
            return dataTypeRef as! Data?
        } else {
            return nil
        }
    }
}
