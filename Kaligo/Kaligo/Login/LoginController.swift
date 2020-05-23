//
//  LoginController.swift
//  Kaligo
//
//  Created by Matheus Silva on 19/05/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import UIKit
import AuthenticationServices
import Endpoints_Requests

class LoginController: UIViewController {
    
    static var isLogged: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isLogged")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isLogged")
        }
    }
    
    @IBOutlet weak var authorizationButton: ASAuthorizationAppleIDButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpSignInAppleButton()
    }
    
    private func auth(appleIDCredential: ASAuthorizationAppleIDCredential) {
        let appleID = appleIDCredential.user //appleID is the password
        let name = appleIDCredential.fullName?.getFullName() ?? ""
        let email = appleIDCredential.email ?? ""
        
        let params = [
            "email": email,
            "appleID": appleID,
            "name": name,
            "level": 0
        ] as [String: Any]
        
        self.showSpinner(onView: self.view)
        UserHandler.auth(params: params as [String: Any]) { (response) in
            switch response {
            case .success(let user):
                DispatchQueue.main.async {
                    self.toMain(user: user)
                    self.removeSpinner()
                }
            case.error(let description):
                DispatchQueue.main.async {
                    self.removeSpinner()
                    self.showAlert(title: "Não foi possível fazer login!",
                                   message: description)
                }
            }
        }
    }
    
    private func toMain(user: User) {
        LoginController.isLogged = true
        CommonData.shared.user = user
        let mainStoryboard = UIStoryboard(name: "Galery", bundle: Bundle.main)
            .instantiateViewController(withIdentifier: "galeryvc")
        mainStoryboard.modalPresentationStyle = .fullScreen
        self.present(mainStoryboard, animated: true, completion: nil)
        
    }
    static func logout(presenter: UIViewController) {
        LoginController.isLogged = false
        
        guard let rootVC = UIStoryboard.init(name: "Login", bundle: nil)
            .instantiateViewController(withIdentifier: "loginvc") as? LoginController else {
                return
        }
        let navigationController = UINavigationController(rootViewController: rootVC)
        navigationController.setNavigationBarHidden(true, animated: false)
        UIApplication.shared.windows.first?.rootViewController = navigationController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}

// MARK: - LoginAuthorization
extension LoginController: ASAuthorizationControllerDelegate {
    func setUpSignInAppleButton() {
        authorizationButton.addTarget(
            self,
            action: #selector(handleAppleIdRequest),
            for: .touchUpInside
        )
        authorizationButton.cornerRadius = 10
        authorizationButton.
    }
    @objc func handleAppleIdRequest() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
    }
    
    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as?  ASAuthorizationAppleIDCredential {
            self.auth(appleIDCredential: appleIDCredential)
        }
        
        func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
            print(error)
        }
    }
}
