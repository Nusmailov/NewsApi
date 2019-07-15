//
//  NewsDescriptionViewController.swift
//  NewsApi
//
//  Created by Nurzhigit Smailov on 7/15/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//

import UIKit

class NewsDescriptionViewController: UIViewController {
    
    //MARK: - Properties
    let constantEdge:Int = 8
    let imageHeight:Int = 200
    
    let newsImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    let newsTopicLabel: UILabel = {
        let text = UILabel()
        text.numberOfLines = 0
        text.font = UIFont(name: "Helvetica-Bold", size: 15)
        return text
    }()
    let newsTextLabel: UILabel = {
        let text = UILabel()
        text.numberOfLines = 0
        text.font = UIFont(name: "Helvetica", size: 14)
        return text
    }()
    let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    //MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barStyle = .blackTranslucent
        self.navigationController?.navigationBar.tintColor = .white
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        setupScrollView()
        setupViews()
    }
   
    func setupScrollView() {
        view.backgroundColor = .white
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        view.addSubview(scrollView)
        scrollView.snp_makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        scrollView.addSubview(contentView)
        contentView.snp_makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalTo(view)
        }
    }
    
    func setupViews() {
        contentView.addSubview(newsImageView)
        contentView.addSubview(newsTopicLabel)
        contentView.addSubview(newsTextLabel)
        
        newsImageView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(constantEdge)
            make.right.equalToSuperview().offset(-constantEdge)
            make.height.equalTo(imageHeight)
        }
        
        newsTopicLabel.snp.makeConstraints { (make) in
            make.top.equalTo(newsImageView.snp.bottom).offset(constantEdge)
            make.left.equalToSuperview().offset(constantEdge)
            make.right.equalToSuperview().offset(-constantEdge)
        }
        
        newsTextLabel.snp.makeConstraints { (make) in
            make.top.equalTo(newsTopicLabel.snp.bottom).offset(constantEdge)
            make.left.equalToSuperview().offset(constantEdge)
            make.right.equalToSuperview().offset(-constantEdge)
            make.bottom.equalToSuperview()
        }
    }
}
