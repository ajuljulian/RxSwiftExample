//
//  ViewController.swift
//  RxSwiftExample
//
//  Created by Ara Juljulian on 10/10/16.
//  Copyright © 2016 Ara Juljulian. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController, UITableViewDataSource {

    var shownFruits = [String]()
    let allFruits = ["Banana", "Strawberry", "Blueberry", "Kiwi", "Lemon", "Lime", "Raspberry"]
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        searchBar
            .rx.text
            .subscribe(onNext:{ [unowned self] (query) in
                self.shownFruits = self.allFruits.filter { $0.hasPrefix(query) }
                self.tableView.reloadData()
                } , onError: nil, onCompleted: nil, onDisposed: nil)
            .addDisposableTo(disposeBag)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shownFruits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fruitPrototypeCell", for: indexPath)
        cell.textLabel?.text = shownFruits[indexPath.row]
        
        return cell
    }
}

