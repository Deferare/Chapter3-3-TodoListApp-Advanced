//
//  Todo.swift
//  TodoList-Advanced
//
//  Created by JiHoon K on 1/8/24.
//

import Foundation

struct Todo: Identifiable {
    var id = UUID()
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
        [[Todo(text: "Read a Book", category: .work),
          Todo(text: "Learn a New Skill", category: .work),
          Todo(text: "Team Meeting", category: .work),
          Todo(text: "Learn New Framework", category: .work),
          Todo(text: "Review latest iOS framework updates", category: .work),
          Todo(text: "Documentation", category: .work),
          Todo(text: "Plan tasks for the next day", category: .work)],
         
         [Todo(text: "Doctor's Appointment", category: .life),
          Todo(text: "Healthy Meal Planning", category: .life),
          Todo(text: "Hydration", category: .life),
          Todo(text: "Sleep Routine", category: .life),
          Todo(text: "Yoga", category: .life),
          Todo(text: "Journaling", category: .life),
          Todo(text: "Meditation", category: .life),
          Todo(text: "Exercise", category: .life),
          Todo(text: "Technology Research Topics", category: .life),
          Todo(text: "Weekly Sprint Objectives", category: .life),],
         
         [Todo(text: "Call a Friend", category: .etc),
          Todo(text: "Family Time", category: .etc),
          Todo(text: "Networking", category: .etc),
          Todo(text: "Volunteer", category: .etc),
          Todo(text: "Budget Review", category: .etc),
          Todo(text: "Savings Plan", category: .etc),
          Todo(text: "Budget Review", category: .etc),
          Todo(text: "Bill Payments", category: .etc),
          Todo(text: "Financial Learning", category: .etc),
          Todo(text: "Expense Tracking", category: .etc)]]
    }
}

