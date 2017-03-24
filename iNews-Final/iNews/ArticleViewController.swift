//
//  ArticleViewController.swift
//  iNews
//
//  Created by Sagar Punhani on 3/24/17.
//  Copyright © 2017 Sagar Punhani. All rights reserved.
//

import UIKit
import SafariServices

class ArticleViewController: UIViewController {
    
    //UIElements
    @IBOutlet weak var articleImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var fullArticleButton: UIButton!
    
    //Model Data
    public var article: Article?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Making image UI a bit prettier
        articleImageView.layer.cornerRadius = 2
        articleImageView.layer.borderColor = UIColor.black.cgColor
        articleImageView.layer.borderWidth = 1
        
        //Making button prettier
        fullArticleButton.layer.cornerRadius = 10
        fullArticleButton.layer.borderWidth = 2
        fullArticleButton.layer.borderColor = UIColor.black.cgColor
        
        //load image from article
        articleImageView.image = UIImage(data: (article?.image)!)
        
        //load text from article
        titleLabel.text = "\(article!.title)"
        authorLabel.text = "Author: \(article!.author)"
        dateLabel.text = "Date: \(article!.date)"
        descriptionLabel.text = "Description: \(article!.des)"
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func fullArticleButton(_ sender: UIButton) {
        //open safari web browswer
        let url = URL(string: (article?.url)!)!
        let svc = SFSafariViewController(url: url)
        self.present(svc, animated: true, completion: nil)
    }
    


}
