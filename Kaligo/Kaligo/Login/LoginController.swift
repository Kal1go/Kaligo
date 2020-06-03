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
    
    let authorizationAppleIDButton = ASAuthorizationAppleIDButton(type: .signIn, style: .black)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpSignInAppleButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if !CommonData.isSawOndoarding {
            self.presentOnboarding()
        }
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
        
        self.view.showSpinner()
        UserHandler.auth(params: params as [String: Any]) { (response) in
            switch response {
            case .success(let user):
                DispatchQueue.main.async {
                    self.toMain(user: user)
                    self.view.removeSpinner()
                }
            case.error(let description):
                DispatchQueue.main.async {
                    self.view.removeSpinner()
                    self.showCustomAlert(title: "Não foi possível fazer login!",
                                         message: description, isOneButton: true) { _ in }
                }
            }
        }
    }
    
    private func toMain(user: User) {
        LoginController.isLogged = true
        CommonData.shared.user = user
        let mainStoryboard = UIStoryboard(name: "Posts", bundle: Bundle.main)
            .instantiateViewController(withIdentifier: "mainvc")
        mainStoryboard.modalPresentationStyle = .fullScreen
        self.present(mainStoryboard, animated: true, completion: nil)
        
    }
    
    private func presentOnboarding() {
        let onboardingVC = UIStoryboard(name: "Onboarding", bundle: nil)
            .instantiateViewController(identifier: "onboardingvc")
        onboardingVC.modalPresentationStyle = .fullScreen
        self.present(onboardingVC, animated: true, completion: nil)
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
        authorizationAppleIDButton.addTarget(
            self,
            action: #selector(handleAppleIdRequest),
            for: .touchUpInside
        )
        authorizationAppleIDButton.cornerRadius = 10
        self.view.addSubview(authorizationAppleIDButton)
        
        authorizationAppleIDButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            authorizationAppleIDButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            authorizationAppleIDButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100),
            authorizationAppleIDButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
            authorizationAppleIDButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
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
