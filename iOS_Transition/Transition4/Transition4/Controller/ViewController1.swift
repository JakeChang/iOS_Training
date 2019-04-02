//
//  ViewController.swift
//  Transition4
//
//  Created by jake on 2019/1/19.
//  Copyright © 2019年 Jake. All rights reserved.
//

import UIKit

class ViewController1: UIViewController {
    
    //View
    @IBOutlet weak var tableView: UITableView!
    
    //
    var selectCell: TableViewCell?
    var selectCellRect: CGRect?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //View
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
    }
    
}

extension ViewController1: UITableViewDataSource, UITableViewDelegate {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath as IndexPath) as! TableViewCell
        cell.tag = indexPath.row
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        selectCell = (tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell)
        
        let cellRect = tableView.rectForRow(at: indexPath)
        let rectInScreen = self.tableView.convert(cellRect, to: view)
        print(rectInScreen)
        
        selectCellRect = rectInScreen
        
        let controller = storyboard!.instantiateViewController(withIdentifier: "ViewController2") as! ViewController2
        controller.selectCellRect = selectCellRect
        present(controller, animated: true, completion: nil)
    }
}
