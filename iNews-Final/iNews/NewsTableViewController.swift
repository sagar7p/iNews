//
//  NewsTableViewController.swift
//  iNews
//
//  Created by Sagar Punhani on 3/24/17.
//  Copyright © 2017 Sagar Punhani. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    //model
    var model = NewsModel()
    
    
    //table data
    var articles = [Article]()
    
    //different ways to sort
    let sortedBy = ["latest","top"]
    
    //UI Element
    @IBOutlet weak var sortSegment: UISegmentedControl!
    
    //Action when segment changes
    @IBAction func changedSegment(_ sender: UISegmentedControl) {
        updateArticles()
    }
    
    //call model api
    func updateArticles() {
        //get articles
        model.getArticles(source: "techcrunch", sort: sortedBy[sortSegment.selectedSegmentIndex]) { (articles) in
            self.articles = articles
            DispatchQueue.main.async {
                //reload data once you get articles
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        updateArticles()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return articles.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "news", for: indexPath)
        
        let article = articles[indexPath.row]
        
        //Add title of article to cell
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.textLabel?.text = article.title
        
        //add image
        cell.imageView?.image = UIImage(data: article.image)
        
        //change size of image
        let itemSize = CGSize(width: 40, height: 40)
        UIGraphicsBeginImageContextWithOptions(itemSize, false, UIScreen.main.scale);
        let imageRect = CGRect(origin: .zero, size: itemSize)
        cell.imageView?.image!.draw(in: imageRect)
        cell.imageView?.image! = UIGraphicsGetImageFromCurrentImageContext()!;
        UIGraphicsEndImageContext();
        
        //add border to image
        cell.imageView?.layer.cornerRadius = 2
        cell.imageView?.layer.borderColor = UIColor.black.cgColor
        cell.imageView?.layer.borderWidth = 1

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //when you click on a cell segue to the next uiviewcontroller
        performSegue(withIdentifier: "article", sender: articles[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let avc = segue.destination as? ArticleViewController {
            //if segue is the article view controller, pass data to the next controller
            avc.article = sender as? Article
        }
    }

}
