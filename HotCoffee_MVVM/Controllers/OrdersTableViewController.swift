//
//  OrdersTableViewController.swift
//  HotCoffee_MVVM
//
//  Created by Willy Hsu on 2025/3/3.
//

import Foundation
import UIKit

class OrdersTableViewController:UITableViewController {
    
    var orderListViewModel = OrderListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        // 初始化並設定 Refresh Control
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        self.refreshControl = refreshControl
        
        populateOrders()
    }
    
    private func populateOrders(){
        guard let CoffeeOrdersURL = URL(string: "https://warp-wiry-rugby.glitch.me/orders") else {
            fatalError( "Invalid URL" )
        }
        
        let resourceOrder = Resource<[Order]>(url: CoffeeOrdersURL)
        
        WebService().load(resource: resourceOrder){ result in
            switch result {
            case .success(let orders):
                DispatchQueue.main.async {
                    self.orderListViewModel.ordersViewModel = orders.map(OrderViewModel.init)
                    self.tableView.reloadData()
                    self.refreshControl?.endRefreshing()
                    print(orders)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.refreshControl?.endRefreshing()
                    print(error)
                }
            }
            
        }
        
    }
    @objc private func handleRefresh() {
        populateOrders()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.orderListViewModel.ordersViewModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vm = orderListViewModel.ordersViewModel[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell", for: indexPath)
        cell.textLabel?.text = vm.type
        
        cell.detailTextLabel?.text = vm.size
        
        return cell
    }
    
}
