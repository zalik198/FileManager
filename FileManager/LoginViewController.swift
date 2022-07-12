//
//  LoginViewController.swift
//  FileManager
//
//  Created by Shom on 10.07.2022.
//

import UIKit
import Locksmith

enum LoginState {
    case signUp
    case signIn
    case passEdit
}

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    private var loginState: LoginState
    private var newPass: String = ""
    
    lazy var passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.frame = CGRect(x:0, y:0, width:250, height:100)
        passwordTextField.layer.cornerRadius = 5
        passwordTextField.layer.borderWidth = 1
        passwordTextField.backgroundColor = .white
        passwordTextField.textColor = .black
        passwordTextField.minimumFontSize = 27
        passwordTextField.layer.borderColor = CGColor(gray: 0, alpha: 1)
        passwordTextField.placeholder = "Введите пароль"
        
        return passwordTextField
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.frame = CGRect(x:0, y:0, width:250, height:100)
        button.backgroundColor = UIColor.blue
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(enterButton), for: .touchUpInside)
        
        return button
    }()
    
    init(state: LoginState) {
        self.loginState = state
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordTextField.delegate = self
        
        stateButton()
        view.backgroundColor = .lightGray
        self.view.addSubview(button)
        self.view.addSubview(passwordTextField)
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        passwordTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: button.topAnchor, constant: -150).isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.tabBarController?.tabBar.isHidden = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.tabBarController?.tabBar.isHidden = false
        
    }
    
    @objc func enterButton() {
        switch loginState {
            
        case .signUp:
            if newPass == "" {
                newPass = passwordTextField.text!
                passwordTextField.text = ""
                button.setTitle("Повторите пароль", for: .normal)
            } else {
                if passwordTextField.text! == newPass {
                    do {
                        try Locksmith.saveData(data: ["pass" : passwordTextField.text!], forUserAccount: "user4")//forUserAccount поменять для создания нового usera
                        newPass = ""
                        self.navigationController?.setViewControllers([ViewController()], animated: true)
                    } catch {
                        print("error")
                    }
                } else {
                    let alertController = UIAlertController(title: "Внимание!", message: "Пароли не совпадают!", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alertController.addAction(action)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        case .signIn:
            guard let passwords = Locksmith.loadDataForUserAccount(userAccount: "user4") else { return }
            //вызов нового usera
            if passwordTextField.text! == passwords["pass"] as? String {
                self.navigationController?.setViewControllers([ViewController()], animated: true)
            } else {
                let alertController = UIAlertController(title: "Внимание!", message: "Неверный пароль!", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alertController.addAction(action)
                self.present(alertController, animated: true, completion: nil)
            }
            
        case .passEdit:
            print("Изменить пароль")
//            if newPass == "" {
//                newPass = passwordTextField.text!
//                passwordTextField.text = ""
//                button.setTitle("Повторите пароль", for: .normal)
//            } else {
//                if passwordTextField.text! == newPass {
//                    do {
//                        try Locksmith.updateData(data: ["[pass]" : passwordTextField.text!], forUserAccount: "user2") //поменять для изменения пароля, если создадим новый
//                        self.navigationController?.setViewControllers([ViewController()], animated: true)
//                    } catch {
//                        print("error")
//                    }
//                }
//            }
        }
        
    }
    
    
    
    @objc private func stateButton() {
        switch loginState {
        case .signUp:
            button.setTitle("Создать пароль", for: .normal)
        case .signIn:
            button.setTitle("Вход", for: .normal)
        case .passEdit:
            button.setTitle("Изменить пароль", for: .normal)
        }
        
    }
    
    
    
    
}

