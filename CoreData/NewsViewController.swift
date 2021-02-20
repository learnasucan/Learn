//
//  ViewController.swift
//  CoreData
//
//  Created by Codewalla on 20/02/21.
//

import UIKit

enum URLError: Error {
    case SessionError
    case HttpError
}

class NewsViewController: UIViewController {
    
    @IBOutlet weak var newsTableView: UITableView!
    var articles = [Article]() {
        didSet{
            DispatchQueue.main.async { [ weak self] in
                self?.newsTableView.reloadData()
            }
           
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        callNEWSAPI()
    }
    
    
    func callNEWSAPI() {
        
        guard let url = URL(string: "http://newsapi.org/v2/everything?q=tesla&from=2021-01-20&sortBy=publishedAt&apiKey=af164c766337466e8af95321c97722d5") else {
            print("URL Failed")
            return
        }
        
        let request = URLRequest(url: url)
        let session = URLSession.shared.dataTask(with: request)  { (data, response, error) in
            
            if error != nil {
                print("Error")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("HTTP Response Error")
                return
            }
            
            guard let mime = response?.mimeType, mime == "application/json" else {
                print("Wrong MIME Type!")
                return
            }
            
            guard let jsonData = data else  {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let newsInfo = try decoder.decode(NewsInfo.self, from: jsonData)
                self.articles = newsInfo.articles ?? []
                print(self.articles)
            } catch {
                print("JSON Error: \(error.localizedDescription)")
            }
            
            
        }
        
        session.resume()
    }
    
    
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as! ArticleTableViewCell
        
        cell.configure(articles[indexPath.row])
        
        return cell
    }
    
    
    
    
    
    
}
