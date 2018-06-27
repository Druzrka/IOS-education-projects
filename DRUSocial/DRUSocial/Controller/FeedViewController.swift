//
//  FeedViewController.swift
//  DRUsocial
//
//  Created by Захар on 06.05.2018.
//  Copyright © 2018 Захар. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class FeedViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addImage: UIImageView!
    @IBOutlet weak var captionTextField: UITextField!

    // MARK: Properties
    private var posts: [Post] = []
    private var imagePicker = UIImagePickerController()
    private var imageChache: NSCache<NSString, UIImage> = NSCache()
    private var imageWasSet: Bool = false
    
    // MARK: Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        setupDataServiceObserver()
    }
    
    private func setupDataServiceObserver() {
        DataService.shared.REF_POSTS.observe(.value) { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                var posts = [Post]()
                for snap in snapshot {
                    if let postDict = snap.value as? Dictionary<String, Any> {
                        let key = snap.key
                        let post = Post(postKey: key, postData: postDict)
                        posts.append(post)
                    }
                }
                self.posts = posts
                self.tableView.reloadData()
            }
        }
    }
    
    private func uploadPost() {
        guard let caption = captionTextField.text, let postImage = addImage.image, let imageData = UIImageJPEGRepresentation(postImage, 0.2) else {
            return
        }
        
        let imageUid = NSUUID().uuidString
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        
        DataService.shared.REF_POST_PICTURES.child(imageUid).putData(imageData, metadata: metaData) { (metaData, error) in
            
            handleError(error)
            
            if let imageUrl = metaData?.downloadURL()?.absoluteString {
                self.post(imageUrl: imageUrl, caption: caption)
            }
        }
    }
    
    private func post(imageUrl: String, caption: String) {
        let post: Dictionary<String, Any> = [
            "caption": caption,
            "imageUrl": imageUrl,
            "likes": 0
        ]
        
        DataService.shared.REF_POSTS.childByAutoId().setValue(post)
        setDefaults()
    }
    
    private func requiredDataFilled() -> Bool {
        return captionTextField.text?.isEmpty == false && imageWasSet
    }
    
    private func setDefaults() {
        captionTextField.text = ""
        imageWasSet = false
        addImage.image = #imageLiteral(resourceName: "add-image")
    }
    
    // MARK: IB Actions
    @IBAction func signOutTapped() {
        KeychainWrapper.standard.set(false, forKey: KeychainKeys.isLogined.rawValue)
        try! Auth.auth().signOut()
        performSegue(withIdentifier: C.identifiers.segue.showAuthorizationController, sender: nil)
    }
    
    @IBAction func addImageTapped() {
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func postButtonTapped() {
        if requiredDataFilled() {
            uploadPost()
        }
    }
}

// MARK: Table view delagate and data source extension
extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: C.identifiers.cell.postTableViewCell, for: indexPath) as? PostTableViewCell {
            configureCell(cell, at: indexPath.row)
            return cell
        }
        
        return UITableViewCell()
    }
    
    private func configureCell(_ cell: PostTableViewCell, at row: Int) {
        
        let post = posts[row]
        cell.delegate = self
        
        cell.captionTextView.text = post.caption
        if let likesCount = post.likes {
            cell.likesCountLabel.text = "\(likesCount)"
        }
        
        if let image = imageChache.object(forKey: post.imageUrl! as NSString) {
            cell.postImage.image = image
            
        } else if let imageUrl = post.imageUrl, let url = URL(string: imageUrl), UIApplication.shared.canOpenURL(url) {
            let ref = Storage.storage().reference(forURL: imageUrl)
            ref.getData(maxSize: 2 * 1024 * 1024) { (data, error) in
                if let err = error {
                    print(err.localizedDescription)
                } else if let imageData = data, let image = UIImage(data: imageData) {
                    cell.postImage.image = image
                    self.imageChache.setObject(image, forKey: imageUrl as NSString)
                }
            }
        }
    }
}

// MARK: Post cell actions
extension FeedViewController: PostTableViewCellDelegate {
    
    func likeTapped(cell: UITableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        
        let post = posts[indexPath.row]
        
        if let cell = cell as? PostTableViewCell {
            let likesRef = DataService.shared.REF_CURRENT_USER.child("likes").child(post.postKey)
            likesRef.observeSingleEvent(of: .value) { (snapshot) in
                
                if let _ = snapshot.value as? NSNull {
                    cell.likeImage.image = #imageLiteral(resourceName: "filled-heart")
                    post.adjustLikes(addLike: true)
                    likesRef.setValue(true)
                    
                } else {
                    post.adjustLikes(addLike: false)
                    cell.likeImage.image = #imageLiteral(resourceName: "empty-heart")
                    likesRef.removeValue()
                }
            }
        }
    }
}

// MARK: Image pikcer delegate
extension FeedViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            addImage.image = image
            imageWasSet = true
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
}





