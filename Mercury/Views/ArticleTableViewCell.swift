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
    
    internal override func awakeFromNib()
        {
        super.awakeFromNib()
        self.pictureView.layer.cornerRadius = 10
        self.pictureView.layer.masksToBounds = true
        self.titleView.isUserInteractionEnabled = false
        }
        
    public override func prepareForReuse()
        {
        self.pictureView.image = nil
        self.titleView.text = nil
        self.dateView.text = nil
        }
    }
