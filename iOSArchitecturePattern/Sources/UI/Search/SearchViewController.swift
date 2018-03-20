//
//  ViewController.swift
//  iOSArchitecturePattern
//
//  Created by shoki terashita on 2018/03/19.
//  Copyright © 2018年 shokiterasita. All rights reserved.
//

import UIKit
import Alamofire

final class SearchViewController: UIViewController {

    @IBOutlet weak var totalCountLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    private var api = APIClient()

    private var totalCount: Int = 0 {
        didSet {
            totalCountLabel.text = "\(articles.count) / \(totalCount)"
        }
    }
    fileprivate var articles: [Article] = [] {
        didSet {
            totalCountLabel.text = "\(articles.count) / \(totalCount)"
            tableView.reloadData()
        }
    }
    
    fileprivate var query: String = "" {
        didSet {
            if query != oldValue {
                articles.removeAll()
                pageInfo = nil
                totalCount = 0
            }
            task?.cancel()
            task = nil
            fetchArticles()

        }
    }

    fileprivate let debounce: (_ action: @escaping () -> ()) -> () = {
        var lastFireTime: DispatchTime = .now()
        let delay: DispatchTimeInterval = .milliseconds(500)
        return { [delay] action in
            let deadline: DispatchTime = .now() + delay
            lastFireTime = .now()
            DispatchQueue.global().asyncAfter(deadline: deadline) { [delay] in
                let now: DispatchTime = .now()
                let when: DispatchTime = lastFireTime + delay
                if now < when { return }
                lastFireTime = .now()
                DispatchQueue.main.async {
                    action()
                }
            }
        }
    }()
    
    fileprivate var isFetchingArticles = false {
        didSet {
            tableView.reloadData()
        }
    }

    // 後ほど、実装
    // fileprivate let loadingView = LoadingView.makeFromNib()
    
    fileprivate var isReachedBottom: Bool = false {
        didSet {
            if isReachedBottom && isReachedBottom != oldValue {
                api.fetchArticles()
            }
        }
    }
    
    // URLSessionTask
    private var task: URLSessionTask? = nil
    private var pageInfo: PageInfo? = nil
    private var favoriteModel: FavoriteModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        edgesForExtendedLayout = []
        searchBar.placeholder = "記事を検索する"
        setupTableView(with: tableView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if searchBar.isFirstResponder {
            searchBar.resignFirstResponder()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    private func setupTableView(with tableView: UITableView) {
        
        // UIのセットアップを1つのメソッドに集約させる方法はいいかも。また、UIに限らず。
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func fetchArticles() {
        if query.isEmpty || task != nil { return }
        if let pageInfo = pageInfo, !pageInfo.hasNextPage || pageInfo.endCursor == nil { return }
        
        isFetchingArticles = true
        
        let request = SearchUserRequest(query: query, after: pageInfo?.endCursor)
        self.task = ApiSession.shared.send(request) { [weak self] in
            switch $0 {
            case .success(let value):
                DispatchQueue.main.async {
                    self?.pageInfo = value.pageInfo
                    self?.users.append(contentsOf: value.nodes)
                    self?.totalCount = value.totalCount
                }
            case .failure(let error):
                if case .emptyToken? = (error as? ApiSession.Error) {
                    DispatchQueue.main.async {
                        guard let me = self else { return }
                        let message = "\"Github Personal Access Token\" is Required.\n Please set it in ApiSession.extension.swift!"
                        let alert = UIAlertController(title: "Access Token Error",
                                                      message: message,
                                                      preferredStyle: .alert)
                        me.present(alert, animated: false, completion: nil)
                    }
                }
            }
            DispatchQueue.main.async {
                self?.isFetchingUsers = false
            }
            self?.task = nil
        }
        
        
        
    }
    
    

    fileprivate func showUserArticle(with article: Article) {
        guard let favoriteModel = favoriteModel else { return }
        let vc = UserArticleViewController(article: article, favoriteModel: favoriteModel)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}


extension SearchViewController: UISearchBarDelegate {
    
    
    func searchBarCancelButtonClicked(_ : UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
        print("searchBarCancelButtonClicked")

    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
        print("searchBarSearchButtonClicked")
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        tableView.reloadData()
        print("searchBarTextDidBeginEditing")


    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        debounce { [weak self] in
            self?.query = searchText
            print("textDidChange")
        }
    }
    
}


extension SearchViewController: UITableViewDataSource {
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
}
        


extension SearchViewController: UITableViewDelegate {
    
}












