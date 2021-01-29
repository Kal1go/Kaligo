//
//  CustomAlertView.swift
//  Kaligo
//
//  Created by Matheus Silva on 25/05/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import UIKit

public class CustomAlertView: UIViewController {
    
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var messageLabel: UILabel!
    @IBOutlet weak private var alertView: UIView!
    @IBOutlet weak private var cancelButton: UIButton!
    @IBOutlet weak private var okButton: UIButton!
    @IBOutlet weak var cancelButtonView: UIView!
    
    public var titleAlert: String = ""
    public var messageAlert: String = ""
    
    public var isOneButton: Bool = false
    private var confirmDidTapHandler: ((Bool) -> Void)?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = titleAlert
        messageLabel.text = messageAlert
        
        if isOneButton {
            setOneButton()
        }
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        animateView()
    }
    
    private func setupView() {
        alertView.layer.cornerRadius = 15
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    }
    
    private func setOneButton() {
        cancelButtonView.removeFromSuperview()
    }
    
    private func animateView() {
        alertView.alpha = 0
        self.alertView.frame.origin.y += 50
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            self.alertView.alpha = 1.0
            self.alertView.frame.origin.y -= 50
        })
    }
    
    func comfirmMoreDidTap(_ handler: @escaping (Bool) -> Void) {
        self.confirmDidTapHandler = handler
    }
    
    @IBAction private func onTapCancelButton(_ sender: Any) {
        self.confirmDidTapHandler?(false)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func onTapOkButton(_ sender: Any) {
        self.confirmDidTapHandler?(true)
        self.dismiss(animated: true, completion: nil)
    }
}
