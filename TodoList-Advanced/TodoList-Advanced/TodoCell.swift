//
//  TodoCell.swift
//  TodoList-Advanced
//
//  Created by JiHoon K on 1/8/24.
//

import UIKit

class TodoCell: UITableViewCell {
    var todo: Todo!
    
    @IBOutlet var title: UILabel!

//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        title.text = todo.text
    }
}

extension TodoCell {
    @IBAction func tappedComplete(_ button: UIButton) {
        
    }
}
