//
//  Todo.swift
//  TodoList-Advanced
//
//  Created by JiHoon K on 1/8/24.
//

import Foundation

struct Todo {
    var text: String
    var category: Category
    
    enum Category {
        case work, life, etc
    }
}

extension Todo {
    static func getTestData() -> [[Todo]] {
        [[Todo(text: "Get ready working iOS", category: .work),
          Todo(text: "Meeting", category: .work)],
         [Todo(text: "Watching Netflix", category: .life)],
         [Todo(text: "Eating", category: .etc),
          Todo(text: "Sleeping", category: .etc),
          Todo(text: "Exercising", category: .etc)]]
    }
}
