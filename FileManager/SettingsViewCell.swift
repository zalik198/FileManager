//
//  SettingsViewCell.swift
//  FileManager
//
//  Created by Shom on 13.07.2022.
//

import UIKit

class SettingsViewCell: UITableViewCell {
    
    lazy var mySwitch: UISwitch = {
        let mySwitch = UISwitch()
        mySwitch.translatesAutoresizingMaskIntoConstraints = false
        mySwitch.addTarget(self, action: #selector(toggleSwitch), for: .valueChanged)
       return mySwitch
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(mySwitch)
        initialLayout()
        mySwitch.isOn = UserDefaults.standard.bool(forKey: "sorted")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Initial layout
    func initialLayout() {
        NSLayoutConstraint.activate([
            mySwitch.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mySwitch.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)

        ])
    }
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    @objc func toggleSwitch() {
        UserDefaults.standard.setValue(mySwitch.isOn, forKey: "sorted")
    }
 

}
