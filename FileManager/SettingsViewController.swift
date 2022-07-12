//
//  SettingsViewController.swift
//  FileManager
//
//  Created by Shom on 10.07.2022.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(tapAddButton))
    }
    
    @objc func tapAddButton() {
        DispatchQueue.main.async {
            let loginVC = LoginViewController(state: .passEdit)
                loginVC.modalPresentationStyle = .automatic
            self.navigationController?.present(loginVC, animated: true)
        }
    }

   

}
