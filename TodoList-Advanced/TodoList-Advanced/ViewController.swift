//
//  ViewController.swift
//  TodoList-Advanced
//
//  Created by JiHoon K on 1/8/24.
//

import UIKit

class ViewController: UIViewController {
    var data:[[Todo]] = Todo.getTestData()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigation()
        setUpTableView()
    }
    

}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Category.allCases.count
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
        return Category.allCases[section].text
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (action, view, completionHandler) in
            self.goToEdit(indexPath, self.data[indexPath.section][indexPath.row])
            completionHandler(true)
        }
        let configuration = UISwipeActionsConfiguration(actions: [editAction])
        return configuration
    }
    
    
    // 오른쪽에서 스와이프
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            self.data[indexPath.section].remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)
        }
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
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
        navigationController?.isToolbarHidden = false
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = "Todo"
    }
    
    @IBAction func tappedAdd() {
        guard let addEditNaviVC = storyboard?.instantiateViewController(identifier: "AddEditNaviViewController") as? UINavigationController else { return }
        
        
        if let addEditVC = addEditNaviVC.topViewController as? AddEditViewController {
            addEditVC.complete = { newTodo in
                if let newTodo = newTodo {
                    var section = 0
                    for c in Category.allCases {
                        if newTodo.category == c {
                            self.data[section].append(newTodo)
                            break
                        }
                        section += 1
                    }
                    self.tableView.reloadData()
                }
            }
        }
        
        addEditNaviVC.modalPresentationStyle = .formSheet
        self.present(addEditNaviVC, animated: true)
    }
    
    private func goToEdit(_ indexPath: IndexPath,_ todo: Todo) {
        guard let addEditNaviVC = storyboard?.instantiateViewController(identifier: "AddEditNaviViewController") as? UINavigationController else { return }
        
        if let addEditVC = addEditNaviVC.topViewController as? AddEditViewController {
            addEditVC.data = todo
            addEditVC.complete = { newTodo in
                if let newTodo = newTodo {
                    if self.data[indexPath.section][indexPath.row].category == newTodo.category {
                        self.data[indexPath.section][indexPath.row] = newTodo
                    } else {
                        var section = 0
                        for c in Category.allCases {
                            if newTodo.category == c {
                                self.data[section].append(newTodo)
                                break
                            }
                            section += 1
                        }
                        self.data[indexPath.section].remove(at: indexPath.row)
                    }
                    self.tableView.reloadData()
                }
            }
        }
        
        addEditNaviVC.modalPresentationStyle = .formSheet
        self.present(addEditNaviVC, animated: true)
    }
}

//@available(iOS 17.0, *)
//#Preview {
//    return ViewController()
//}
