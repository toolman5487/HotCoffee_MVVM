//
//  AddOrderViewController.swift
//  HotCoffee_MVVM
//
//  Created by Willy Hsu on 2025/3/3.
//

import Foundation
import UIKit

class AddOrderViewController:UIViewController{
    
    private var vm = AddCoffeeOrderViewModel()
    private var coffeeSizesSegmentControl:UISegmentedControl!
    private var nameTextField:UITextField!
    private var emailTextField:UITextField!
    
    let mainColor:UIColor = UIColor(red: 3.0/255.0, green: 102.0/255.0, blue: 53.0/255.0, alpha: 1.0)
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        setupUI()
    }
    
    @IBAction func saveBar(){
        let name = self.nameTextField.text
        let email = self.emailTextField.text
        let selectedSize = self.coffeeSizesSegmentControl.titleForSegment(at: self.coffeeSizesSegmentControl.selectedSegmentIndex)
        guard let indexPath = self.tableView.indexPathForSelectedRow else{
            fatalError("Error in selected coffee")
        }
        
        self.vm.name = name
        self.vm.email = email
        self.vm.selectedSize = selectedSize
        self.vm.selectedType = self.vm.types[indexPath.row]
        
    }
    
    private func setupUI(){
        self.coffeeSizesSegmentControl = UISegmentedControl(items: self.vm.sizes)
        self.coffeeSizesSegmentControl.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.coffeeSizesSegmentControl)
        self.coffeeSizesSegmentControl.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 30).isActive = true
        self.coffeeSizesSegmentControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.coffeeSizesSegmentControl.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 20).isActive = true
        self.coffeeSizesSegmentControl.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
//        self.coffeeSizesSegmentControl.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        
        // 初始化 nameTextField
        self.nameTextField = UITextField()
        self.nameTextField.translatesAutoresizingMaskIntoConstraints = false
        self.nameTextField.placeholder = "請輸入姓名"
        self.nameTextField.borderStyle = .roundedRect
        self.view.addSubview(self.nameTextField)
        
        self.nameTextField.topAnchor.constraint(equalTo: self.coffeeSizesSegmentControl.bottomAnchor, constant: 15).isActive = true
        self.nameTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        self.nameTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        self.nameTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        // 初始化 emailTextField
        self.emailTextField = UITextField()
        self.emailTextField.translatesAutoresizingMaskIntoConstraints = false
        self.emailTextField.placeholder = "請輸入 Email"
        self.emailTextField.borderStyle = .roundedRect
        self.view.addSubview(self.emailTextField)
        
        self.emailTextField.topAnchor.constraint(equalTo: self.nameTextField.bottomAnchor, constant: 15).isActive = true
        self.emailTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        self.emailTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        self.emailTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
    }
    
}


extension AddOrderViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.types.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoffeeTypeTableViewCell", for: indexPath)
        cell.textLabel?.text = self.vm.types[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        cell.textLabel?.textColor = mainColor
        
        cell.imageView?.image = UIImage(systemName: "mug.fill")
        cell.imageView?.tintColor = mainColor
        cell.imageView?.contentMode = .scaleAspectFit
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
}
