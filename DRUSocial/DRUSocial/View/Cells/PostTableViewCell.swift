//
//  PostTableViewCell.swift
//  DRUsocial
//
//  Created by Захар on 31.05.2018.
//  Copyright © 2018 Захар. All rights reserved.
//

import UIKit

protocol PostTableViewCellDelegate {
    func likeTapped(cell: UITableViewCell)
}

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: CIrcularImageWithShadow!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var captionTextView: UITextView!
    @IBOutlet weak var likesCountLabel: UILabel!
    @IBOutlet weak var likeImage: UIImageView!
    
    public var delegate: PostTableViewCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setTapRecognizerTo(image: likeImage)
    }
    
    private func setTapRecognizerTo(image: UIImageView) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(likeTapped))
        image.addGestureRecognizer(tap)
    }
    
    @objc func likeTapped() {
        delegate.likeTapped(cell: self)
    }
}
