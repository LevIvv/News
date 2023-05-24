//
//  NewsViewController.swift
//  News
//
//

import UIKit

class NewsViewController: UIViewController {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    var article:Article!

    @IBOutlet weak var lblSource: UILabel!
    @IBOutlet weak var btnOpen: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: article.publishedAt)
        
        lblTitle.text = article.title
        lblDescription.text = article.description
        if date != nil {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateWithoutTime = dateFormatter.string(from: date!)
            lblDate.text = "Опубликовано: \(dateWithoutTime)"
        }
        else {
            lblDate.text = "Нет даты"
        }
        lblSource.text = "Источник: \(article.source)"
       
        
        
   
        if let url = URL(string: article.urlToImage) {
            let task = URLSession.shared.dataTask(with: url) {  data, response, error in
                guard let data = data, error == nil else {
                    return
                }
                
                DispatchQueue.main.async {
                    self.imgView.layer.cornerRadius = 8.0
                    self.imgView.clipsToBounds = true
                    self.imgView.image = UIImage(data: data)
                    
                }
            }
            
            
            task.resume()
        }
        
        if URL(string: article.url) == nil {
            btnOpen.isEnabled = false
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            guard segue.identifier == "goToWeb" else { return }
            guard let destination = segue.destination as? WebKitViewController else { return }
            destination.urlSite = article.url
        }


}
