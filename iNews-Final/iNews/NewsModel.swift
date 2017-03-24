//
//  NewsModel.swift
//  iNews
//
//  Created by Sagar Punhani on 3/24/17.
//  Copyright © 2017 Sagar Punhani. All rights reserved.
//

import Foundation

//Model object to grab from api call
struct Article {
    let author: String
    let title: String
    let review: String
    let des: String
    let url: String
    let image: Data
    let date: String
    init(a: String, t: String, r: String, d: String, u: String, i: Data, dt: String) {
        author = a
        title = t
        review = r
        des = d
        url = u
        image = i
        date = dt
    }
    var description: String {
        get {
            return "Author: \(author) Title: \(title) Review: \(review) Description: \(des) Url: \(url) Image: \(image) Date: \(date)"
        }
    }
}

//Model class
class NewsModel {
    
    func getArticles(source: String, sort: String, completion:@escaping ([Article]) -> Void) {
        
        //call api to get articles
        let urlString = URL(string: "https://newsapi.org/v1/articles?source=\(source)&sortBy=\(sort)&apiKey=b1206464ab9545cab349afe9a763c866")
        if let url = urlString {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print("ERROR")
                    print(error!.localizedDescription)
                } else {
                    //if api resolves
                    if let usableData = data {
                        if let result = String(data: usableData, encoding: String.Encoding.utf8) {
                            //parse json string
                            let articles = self.parseJson(result: result)
                            //complete with the object
                            completion(articles)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    private func parseJson(result: String) -> [Article]{
        var articles = [Article]()
        
        // convert String to NSData
        let data = result.data(using: String.Encoding.utf8)!
        
        // convert NSData to 'AnyObject'
        let obj = try! JSONSerialization.jsonObject(with: data, options:[])
        
        if let dictionary = obj as? [String: Any] {
            //go through articles array
            if let allArticles = dictionary["articles"] as? [[String:Any]] {
                for json in allArticles {
                    //grab json data and put into model
                    let author = json["author"] as? String ?? ""
                    let title = json["title"] as? String ?? ""
                    let review = json["review"] as? String ?? ""
                    let description = json["description"] as? String ?? ""
                    let url = json["url"] as? String ?? ""
                    let image = json["urlToImage"] as? String ?? ""
                    let imageUrl = URL(string: image)!
                    let imageData = try! Data(contentsOf: imageUrl)
                    var date = json["publishedAt"] as? String ?? ""
                    date = date.components(separatedBy: "T")[0]
                    let article = Article(a: author, t: title, r: review, d: description, u: url, i: imageData, dt: date)
                    //add article to list
                    articles.append(article)
                }
            }
        }
        //return list
        return articles
    }
}


