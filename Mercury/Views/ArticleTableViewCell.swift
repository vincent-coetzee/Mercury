//
//  ArticleTableViewCell.swift
//  Mercury
//
//  Created by Vincent Coetzee on 16/10/21.
//

import UIKit

class ArticleTableViewCell: UITableViewCell
    {
    @IBOutlet var titleView: UITextView!
    @IBOutlet var dateView: UILabel!
    @IBOutlet var pictureView: UIImageView!
    
    public override func prepareForReuse()
        {
        self.pictureView.image = nil
        self.titleView.text = nil
        self.dateView.text = nil
        }
    }
