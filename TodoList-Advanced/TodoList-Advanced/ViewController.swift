//
//  ViewController.swift
//  TodoList-Advanced
//
//  Created by JiHoon K on 1/8/24.
//

import UIKit

class ViewController: UIViewController {
    var todoData:[[Todo]] = Array(repeating: [], count: Category.allCases.count)
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTodoData()
        setUpNavigation()
        setUpTableView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        saveTodoData()
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Category.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoData[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell") as? TodoCell else { return UITableViewCell() }
        cell.todo = todoData[indexPath.section][indexPath.row]
        cell.action = { id in
            if let id = id {
                let newIndexPath = self.getCurrentIndexPath(id, indexPath.section)
                self.todoData[indexPath.section].remove(at: newIndexPath.row)
                tableView.deleteRows(at: [newIndexPath], with: .fade)
            }
        }
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
    // Swipe from left
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (action, view, completionHandler) in
            self.toEdit(indexPath, self.todoData[indexPath.section][indexPath.row])
            completionHandler(true)
        }
        let configuration = UISwipeActionsConfiguration(actions: [editAction])
        return configuration
    }
    
    // Swipe from right
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            self.todoData[indexPath.section].remove(at: indexPath.row)
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
                            self.todoData[section].append(newTodo)
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
    
    private func toEdit(_ indexPath: IndexPath,_ todo: Todo) {
        guard let addEditNaviVC = storyboard?.instantiateViewController(identifier: "AddEditNaviViewController") as? UINavigationController else { return }
        
        if let addEditVC = addEditNaviVC.topViewController as? AddEditViewController {
            addEditVC.data = todo
            addEditVC.complete = { newTodo in
                if let newTodo = newTodo {
                    if self.todoData[indexPath.section][indexPath.row].category == newTodo.category {
                        self.todoData[indexPath.section][indexPath.row] = newTodo
                    } else {
                        var section = 0
                        for c in Category.allCases {
                            if newTodo.category == c {
                                self.todoData[section].append(newTodo)
                                break
                            }
                            section += 1
                        }
                        self.todoData[indexPath.section].remove(at: indexPath.row)
                    }
                    self.tableView.reloadData()
                }
            }
        }
        
        addEditNaviVC.modalPresentationStyle = .formSheet
        self.present(addEditNaviVC, animated: true)
    }
    
    private func getCurrentIndexPath(_ id: UUID,_ section: Int) -> IndexPath {
        var new = IndexPath(row: 0, section: section)
        for i in 0..<self.todoData[section].count {
            if self.todoData[section][i].id == id {
                new = IndexPath(row: i, section: section)
                break
            }
        }
        return new
    }
    
    private func saveTodoData() {
        if let data = try? JSONEncoder().encode(todoData) {
            UserDefaults.standard.set(data, forKey: "todoData")
        }
    }
    
    private func loadTodoData() {
        if let data = UserDefaults.standard.data(forKey: "todoData") {
            if let todo = try? JSONDecoder().decode([[Todo]].self, from: data) {
                self.todoData = todo
            }
        }
    }
}

//@available(iOS 17.0, *)
//#Preview {
//    return ViewController()
//}
