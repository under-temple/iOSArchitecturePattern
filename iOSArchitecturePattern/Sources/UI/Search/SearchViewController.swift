//
//  ViewController.swift
//  iOSArchitecturePattern
//
//  Created by shoki terashita on 2018/03/19.
//  Copyright © 2018年 shokiterasita. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController {

    @IBOutlet weak var totalCountLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    

    
    private var totalCount: Int = 0 {
        didSet {
            // 取得した記事数を後ほど表示する。
            totalCountLabel.text = "\(totalCount) / \(totalCount)"
        }
    }
    
    
    var favoriteModel: FavoriteModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Article.init(name: "test", url: URL(string: "https://yahoo.co.jp")!, title: "QiitaTitle")
        
        searchBar.placeholder = "記事を検索する"
        setupTableView(with: tableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    private func setupTableView(with tableView: UITableView) {
        tableView.dataSource = self
        tableView.delegate = self
            }
    
    
}


extension SearchViewController: UISearchBarDelegate {
    
}


extension SearchViewController: UITableViewDataSource {
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    
    
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Qiitaで取得した記事を掲載する。
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
            
    }
    
}
        


extension SearchViewController: UITableViewDelegate {
    
}












