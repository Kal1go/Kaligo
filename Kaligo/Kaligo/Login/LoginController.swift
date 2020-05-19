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
    
    @IBOutlet weak var authorizationButton: ASAuthorizationAppleIDButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        config()
        setUpSignInAppleButton()
    }
    
    func config() {
        
    }
    
    func auth(appleIDCredential: ASAuthorizationAppleIDCredential) {
        let appleID = appleIDCredential.user //appleID is the password
        let name = appleIDCredential.fullName?.getFullName() ?? ""
        let email = appleIDCredential.email ?? ""
        
        let params = [
            "email": email,
            "appleID": appleID,
            "name": name
        ]
        
        self.showSpinner(onView: self.view)
        UserHandler.auth(params: params as [String: Any]) { (response) in
            switch response {
            case .success(let user):
                DispatchQueue.main.async {
                    CommonData.shared.user = user
                    self.showAlert(title: "Login realizado com succeso!", message: "")
                    self.removeSpinner()
                }
            case.error(let description):
                DispatchQueue.main.async {
                    self.showAlert(title: "Não foi possível fazer login!",
                    message: description)
                }
            }
        }
    }
}

// MARK: - LoginAuthorization
extension LoginController: ASAuthorizationControllerDelegate {
    func setUpSignInAppleButton() {
        authorizationButton.addTarget(self, action: #selector(handleAppleIdRequest), for: .touchUpInside)
        authorizationButton.cornerRadius = 10
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
