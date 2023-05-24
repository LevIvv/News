//
//  TableViewController.swift
//  News
//
//  Created by Лев Ивлев on 26.04.2023.
//

import UIKit

class TableViewController: UITableViewController {
    
    @IBAction func refreshTable(_ sender: Any) {
        getNews {
            DispatchQueue.main.async {
                self.refreshControl?.endRefreshing()
                self.tableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getNews {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        let article = articles[indexPath.row]
        cell.titleLabel.text = article.title
        if let url = URL(string: article.urlToImage) {
            let task = URLSession.shared.dataTask(with: url) {  data, response, error in
                guard let data = data, error == nil else {
                    return
                }
                DispatchQueue.main.async {
                    cell.imageUrlView.layer.cornerRadius = 10.0
                    cell.imageUrlView.clipsToBounds = true
                    cell.imageUrlView.image = UIImage(data: data)
                }
            }


            task.resume()
        }
        return cell
    }
    
    
    @objc func loadTable(){
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToNews", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToNews"{
            (segue.destination as? NewsViewController)?.article = articles[tableView.indexPathForSelectedRow!.row]
            tableView.deselectRow(at: tableView.indexPathForSelectedRow!, animated: true)
           
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            tableView.reloadData()
          
    }
    
    
}

