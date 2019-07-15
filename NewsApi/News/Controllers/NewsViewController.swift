//
//  ViewController.swift
//  NewsApi
//
//  Created by Nurzhigit Smailov on 7/15/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage
import SVProgressHUD

class NewsViewController: UIViewController {
    
    //MARK: - Properties
    let tableView = UITableView(frame: .zero)
    let cellId = "newsDescriptionCell"
    var articles = [Articles]()
    var articlesViewModel: ArticlesViewModel?
    
    //MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "News"
        self.navigationController?.navigationBar.barStyle = .blackTranslucent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        articlesViewModel = ArticlesViewModel()
        setupTableView()
        //loadInfo
        //retrieving from CoreData
        articles = ArticlesRepository.retrieveArticles()
        print(articles.count)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - SetupViews
    func setupTableView() {
        tableView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
    }
    
    func loadInfo() {
        articlesViewModel?.getListNews(success: { (news) in
            for i in  news {
                self.articles.append(i)
                
                // Cashing to CoreData
                
                do {
                    try? ArticlesRepository.createArticle(author: i.author, title: i.author, description: i.description,
                                                 urlToImage: i.urlToImage ?? "", url: i.url, publishedAt: i.publishedAt)
                }
            }
            self.tableView.reloadData()
            SVProgressHUD.dismiss()
        }, failure: { (error) in
            let alertController = UIAlertController(title: "There was an error fetching news details.!",
                                                    message: "\(error)",
                                                    preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(okAction)
            DispatchQueue.main.async {
                self.present(alertController, animated: true, completion: nil)
            }
            SVProgressHUD.dismiss()
        })
        
    }
    
}

//MARK: - TableViewExtensions
extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! NewsTableViewCell
        cell.selectionStyle = .none
        
        cell.newsTopicLabel.text = articles[indexPath.item].title
        cell.newsTextLabel.text = articles[indexPath.item].description
        cell.newsImageView.sd_setImage(with: URL(string: articles[indexPath.item].urlToImage!))
        
        return  cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            let spinner = UIActivityIndicatorView(style: .gray)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            self.tableView.tableFooterView = spinner
            self.tableView.tableFooterView?.isHidden = false
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = NewsDescriptionViewController()
        
        vc.newsTopicLabel.text = articles[indexPath.item].title
        vc.newsTextLabel.text = articles[indexPath.item].description
        vc.newsImageView.sd_setImage(with: URL(string: articles[indexPath.item].urlToImage ?? ""))
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height) {
            self.loadInfo()
            tableView.reloadData()
        }
    }
}
