//
//  AuthenticationViewController.swift
//  Mercury
//
//  Created by Vincent Coetzee on 17/10/21.
//

import UIKit
import Firebase

class AuthenticationViewController: UIViewController
    {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    
    internal var loggedInModel: LoggedInModel!
    
    override func viewDidLoad()
        {
        super.viewDidLoad()
        self.imageView.layer.cornerRadius = 30
        }
    
    @IBAction func onSignInTapped(_ sender: Any?)
        {
        Auth.auth().signIn(withEmail: self.emailField.text ?? "", password: self.passwordField.text ?? "")
            {
            (user,error) in
            if error.isNotNil
                {
                let controller = UIAlertController(title: "Sign In Error",message: error!.localizedDescription,preferredStyle: .alert)
                controller.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                self.present(controller,animated: true)
                }
            else
                {
                self.loggedInModel.loggedIn = true
                self.dismiss(animated: true)
                }
            }
        }
        
    @IBAction func onRegisterTapped(_ sender: Any?)
        {
        Auth.auth().createUser(withEmail: self.emailField.text ?? "", password: self.passwordField.text ?? "")
            {
            (user,error) in
            if error.isNotNil
                {
                let controller = UIAlertController(title: "Registration Error",message: error!.localizedDescription,preferredStyle: .alert)
                controller.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                self.present(controller,animated: true)
                }
            else
                {
                let controller = UIAlertController(title: "Success",message: "You were successfully registered.",preferredStyle: .alert)
                controller.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                self.present(controller,animated: true)
                self.loggedInModel.loggedIn = true
                self.dismiss(animated: true)
                }
            }
        }
    }
