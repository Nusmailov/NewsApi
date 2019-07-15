//
//  NewsTableViewCell.swift
//  NewsApi
//
//  Created by Nurzhigit Smailov on 7/15/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    // MARK: - Properties
    let constantEdge:Int = 8
    let constantImageWidth:Int = 100
    let newsImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    let newsTextLabel: UILabel = {
        let text = UILabel()
        text.numberOfLines = 0
        text.font = UIFont(name: "Helvetica", size: 14)
        return text
    }()
    let newsTopicLabel: UILabel = {
        let text = UILabel()
        text.numberOfLines = 0
        text.font = UIFont(name: "Helvetica-Bold", size: 15)
        return text
    }()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    func setupViews() {
        contentView.addSubview(newsImageView)
        contentView.addSubview(newsTextLabel)
        contentView.addSubview(newsTopicLabel)
        
        newsImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(constantEdge)
            make.right.bottom.equalToSuperview().offset(-constantEdge)
            make.width.equalTo(constantImageWidth)
        }
        
        newsTopicLabel.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(constantEdge)
            make.right.equalTo(newsImageView.snp.left).offset(-constantEdge)
            make.height.equalTo(15)
        }
        
        newsTextLabel.snp.makeConstraints { (make) in
            make.top.equalTo(newsTopicLabel.snp.bottom).offset(constantEdge)
            make.left.equalToSuperview().offset(constantEdge)
            make.bottom.equalToSuperview().offset(-constantEdge)
            make.right.equalTo(newsImageView.snp.left).offset(-constantEdge)
        }
    }
}
