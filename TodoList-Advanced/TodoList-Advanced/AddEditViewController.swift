//
//  AddEditViewController.swift
//  TodoList-Advanced
//
//  Created by JiHoon K on 1/10/24.
//

import UIKit

class AddEditViewController: UIViewController {
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    
    var data: Todo?
    var complete: ((Todo?) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        UserDefaults.standard.set(self.data[0][1], forKey: self.data?.id.uuidString!)
        setUpNavigation()
        setUpCategoryButtonView()
        setUpTextFieldView()
    }
}

extension AddEditViewController {
    private func setUpNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.isNavigationBarHidden = false
        navigationItem.setRightBarButton(UIBarButtonItem(systemItem: .done, primaryAction: UIAction(handler: { a in
            self.data?.text = self.textField.text ?? ""
            self.complete?(self.data)
            self.dismiss(animated: true)
        })), animated: true)
        
        if data == nil {
            navigationItem.title = "Add"
            data = Todo(text: "", category: .work)
        } else {
            navigationItem.title = "Edit"
        }
    }
    
    private func setUpCategoryButtonView() {
        categoryButton.setTitle(data?.category.text, for: .normal)
        
        var children: [UIAction] = []
        for type in Category.allCases {
            children.append(UIAction(title: type.text, handler: { _ in
                self.categoryButton.setTitle(type.text, for: .normal)
                self.data?.category = type
            }))
        }
        let menu = UIMenu(title: "", children: children)
        
        categoryButton.menu = menu
        categoryButton.showsMenuAsPrimaryAction = true
    }
    
    private func setUpTextFieldView() {
        textField.text = data?.text
    }
}
