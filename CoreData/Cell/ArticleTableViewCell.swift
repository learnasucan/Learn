//
//  ArticleTableViewCell.swift
//  CoreDataDemo
//
//  Created by Codewalla on 20/02/21.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(_ article: Article) {
        authorLabel.text = article.author ?? ""
        titleLabel.text = article.title ?? ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
