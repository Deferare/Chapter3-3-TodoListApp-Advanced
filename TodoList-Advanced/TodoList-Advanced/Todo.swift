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
    
    
}

enum Category: CaseIterable {
    case work, life, etc
    
    var text : String {
        switch self {
        case .work:
            return "Work"
        case .life:
            return "Life"
        case .etc:
            return "Etc."
        }
    }
}

//MARK: - ETC.
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
