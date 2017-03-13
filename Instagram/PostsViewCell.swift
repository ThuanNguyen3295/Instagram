//
//  PostsViewCell.swift
//  Instagram
//
//  Created by Thuan Nguyen on 3/9/17.
//  Copyright © 2017 Thuan Nguyen. All rights reserved.
//

import UIKit
import ParseUI
import Parse

class PostsViewCell: UITableViewCell {

    @IBOutlet weak var caption: UILabel!
    @IBOutlet weak var photoView: PFImageView!
        
    var instagramPost: PFObject!  {
        didSet{
            caption.text = instagramPost["caption"] as? String
            photoView.file = instagramPost["media"] as? PFFile
            photoView.loadInBackground()
        }
    
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
