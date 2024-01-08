//
//  ViewController.swift
//  TodoList-Advanced
//
//  Created by JiHoon K on 1/8/24.
//

import UIKit

class ViewController: UIViewController {
    var data:[[Todo]] = Todo.getTestData()
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigation()
        setUpTableView()
    }
    

}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell") as? TodoCell else { return UITableViewCell() }
        cell.todo = data[indexPath.section][indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let titles = ["Work", "Life", "ETC"]
        return titles[section]
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        UISwipeActionsConfiguration(actions: [.init(style: .destructive, title: "test", handler: { t,a,c  in
            
        })])
    }
}

//MARK: - Helpers
extension ViewController {
    private func setUpTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
    }
    
    private func setUpNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationController?.isToolbarHidden = false
//        navigationController?.isNavigationBarHidden = false
//        navigationItem.title = "Todo"
    }
    @IBAction func tappedAdd() {
         
    }
}

//@available(iOS 17.0, *)
//#Preview {
//    return ViewController()
//}

