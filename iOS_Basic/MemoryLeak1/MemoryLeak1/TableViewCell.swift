//
//  TableViewCell.swift
//  MemoryLeak1
//
//  Created by jake on 2019/3/11.
//  Copyright © 2019 Jake. All rights reserved.
//

import UIKit

protocol TableViewCellDelegate: NSObjectProtocol {
    func tableViewCellClickButton(tag: Int)
}

class TableViewCell: UITableViewCell {
    
    weak var delegate: TableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)        
    }
    
    @IBAction func clickButton(_ sender: Any) {
        self.delegate?.tableViewCellClickButton(tag: self.tag)
    }
}
