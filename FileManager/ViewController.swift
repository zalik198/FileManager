//
//  ViewController.swift
//  FileManager
//
//  Created by Shom on 06.07.2022.
//

import UIKit
import Locksmith

class ViewController: UIViewController {
    
    let imagePicker = UIImagePickerController()
    var images = [MyImages]()
    
    //MARK: Initial tableView
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 100
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.tabBarController?.tabBar.isHidden = false
        
        view.addSubview(tableView)
        self.view.backgroundColor = .white
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "myCell")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(tapAddButton))
        
        initialLayout()
        myLibrary()
    }
    
    @objc func tapAddButton() {
        
        let alert = UIAlertController(title: "Изображение", message: nil, preferredStyle: .actionSheet)
        let actionPhoto = UIAlertAction(title: "С фотогалереи", style: .default) { (alert) in
            
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true)
        }
        let actionCamera = UIAlertAction(title: "С камеры", style: .default) { (alert) in
            guard UIImagePickerController.isSourceTypeAvailable(.camera) else { return }
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true)
        }
        let actionCancel = UIAlertAction(title: "Отмена", style: .cancel)
        
        alert.addAction(actionPhoto)
        alert.addAction(actionCamera)
        alert.addAction(actionCancel)
        present(alert, animated: true, completion: nil)
    }
    
    func myLibrary() {
        self.images.removeAll()
        
        let manager = FileManager.default
        guard let docUrl = try? manager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false),
              let contents = try? FileManager.default.contentsOfDirectory(at: docUrl, includingPropertiesForKeys: nil, options: [.skipsHiddenFiles])
        else { return }
        //print(docUrl)
        
        for i in contents {
            let myPath = i.path
            do {
                try FileManager.default.attributesOfItem(atPath: myPath)
            } catch let error {
                print(error)
            }
            
            let image = UIImage(contentsOfFile: myPath)
            let fileName = (myPath as NSString).lastPathComponent
            images.append(MyImages(image: image ?? UIImage(),
                                   path: myPath, imageName: fileName))
        }
    }
    
    func saveImageInDocuments(image: UIImage) {
        let manager = FileManager.default
        guard let docUrl = try? manager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) else { return }
        
        let imageName = UUID().uuidString
        let imagePath = docUrl.appendingPathComponent("\(imageName).jpg")
        let data = image.jpegData(compressionQuality: 1.0)
        manager.createFile(atPath: imagePath.path, contents: data)
        myLibrary()
        tableView.reloadData()
    }
    
    private func removeImagesFromDocuments(_ fileImage: String) {
        do {
            try FileManager.default.removeItem(atPath: fileImage)
        } catch {
            print(error)
        }
    }
    
    //MARK: Initial layout
    func initialLayout() {
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                     tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                     tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
                                    ])
    }
}


//MARK: - Extensions ViewController

extension ViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        self.saveImageInDocuments(image: pickedImage)
        dismiss(animated: true, completion: nil)
    }
}


extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Documents"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            removeImagesFromDocuments(images[indexPath.row].path)
            myLibrary()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as? TableViewCell else { return UITableViewCell() }
        cell.configMyCell(images: images[indexPath.row])
        return cell
    }
    
}
