//
//  InstagramViewController.swift
//  Instagram
//
//  Created by Thuan Nguyen on 3/7/17.
//  Copyright © 2017 Thuan Nguyen. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class InstagramViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var posts: [PFObject]?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = 320
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.delegate = self
        self.tableView.dataSource = self
    
        if let user = PFUser.current() {
            let query = PFQuery(className: "Post")
            query.order(byDescending: "createdAt")
            query.includeKey(user.username!)
            query.limit = 20
            
            // fetch data asynchronously
            query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) -> Void in
                if let posts = posts {
                       self.posts = posts as? [PFObject]
                    print(posts)
                        self.tableView.reloadData()
                    } else {
                    print("Error: \(error?.localizedDescription)")
                }
              
            }
           
        }
        // tableView.reloadData()
        
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let posts = posts {
            return posts.count
        }
        else {
        return 0
        }
        
            }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostsViewCell", for: indexPath) as! PostsViewCell
        let post = posts?[indexPath.row]
        cell.instagramPost = post
        return cell
    }

    
    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOutInBackground { (error: Error?) in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UserDidLogout"), object: nil)

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let user = PFUser.current() {
            let query = PFQuery(className: "Post")
            query.order(byDescending: "createdAt")
            query.includeKey(user.username!)
            query.limit = 20
            
            // fetch data asynchronously
            query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) -> Void in
                if let posts = posts {
                    self.posts = posts as? [PFObject]
                    print(posts)
                    self.tableView.reloadData()
                } else {
                    print("Error: \(error?.localizedDescription)")
                }
                
            }
            
        }
        

        
        tableView.reloadData()
        print("reloaded")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
