//
//  TableViewCell.swift
//  FileManager
//
//  Created by Shom on 06.07.2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    private lazy var myImage: UIImageView = {
        let myImage = UIImageView()
        myImage.translatesAutoresizingMaskIntoConstraints = false
        myImage.backgroundColor = .black
        myImage.clipsToBounds = true
        myImage.contentMode = .scaleAspectFill
        return myImage
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(myImage)
        initialLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    func configMyCell(images: MyImages) {
        self.myImage.image = images.image
    }
    
    //MARK: Initial layout
    func initialLayout() {
        NSLayoutConstraint.activate([
            myImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 11),
            myImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            myImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -11),
            myImage.widthAnchor.constraint(equalTo: myImage.widthAnchor),
            myImage.heightAnchor.constraint(equalTo: myImage.widthAnchor)
            
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}
