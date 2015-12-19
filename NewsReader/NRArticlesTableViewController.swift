//
//  NRArticlesTableViewController.swift
//  NewsReader
//
//  Created by David Tucito on 12/8/15.
//  Copyright © 2015 David Tucito. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import PullToRefreshSwift

class NRArticlesTableViewController: UITableViewController {
    
    var news: JSON = JSON.null
    var selectedArticles : [NSIndexPath] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        
        // call the new york times api
        self.callAPI()
        
        // pull to refresh
        self.tableView.addPullToRefresh({ [weak self] in
            self?.callAPI()
            self?.tableView.stopPullToRefresh()
        })
    }
    
    func callAPI() {
        Alamofire.request(.GET, "https://api.nytimes.com/svc/mostpopular/v2/mostshared/all-sections/7?api-key=6c3146a0a8c229cb9bcfc5dbb63c9256:19:73663250")
            .responseJSON { (request, response, data) in
                // when I get a result, I plug the data to my tableview
                self.news = JSON((data.value?.valueForKey("results"))!)
                self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return news.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath) as UITableViewCell
        
        // Configure the cell...
        let article : JSON = news[indexPath.row]
        
        cell.textLabel?.text = article["title"].string
        cell.detailTextLabel?.text = article["abstract"].string

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedArticles.append(indexPath)
        self.tableView.cellForRowAtIndexPath(indexPath)?.contentView.backgroundColor = UIColor.yellowColor()
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.cellForRowAtIndexPath(indexPath)?.contentView.backgroundColor = UIColor.yellowColor()
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        var input : String = ""
        
        // Let's look at selected articles
        for var i=0; i<self.selectedArticles.count; i++ {
            if let title = self.tableView.cellForRowAtIndexPath(selectedArticles[i])?.textLabel?.text
            {
                input = input + title + " "
            }
            if let abstract = self.tableView.cellForRowAtIndexPath(selectedArticles[i])?.detailTextLabel?.text
            {
                input = input + abstract + " "
            }
        }
        
        (segue.destinationViewController as! ReadTextViewController).textToRead = input
    }
    

}
