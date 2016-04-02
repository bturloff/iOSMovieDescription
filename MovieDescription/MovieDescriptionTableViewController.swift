//
//  MovieDescriptionTableViewController.swift
//  MovieDescription
//

/*
* Copyright 2016 Brian Turloff,
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
* http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.

* @author Brian Turloff mailto:bturlof@asu.edu
*         Computer Science, CIDSE, ASU - Tempe
* @version March 2016
*/

import UIKit

class MovieDescriptionTableViewController: UITableViewController {
    
    // MARK: Properties
    
    var movies:MovieLibrary = MovieLibrary()
    var titles:[String] = []
    var table_view = self
    
    override func viewWillAppear(animated: Bool){
        super.viewWillAppear(animated)
        print("in viewWillAppear")
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        movies.movie_list.removeAll()
        loadSampleMeals()
        
        navigationItem.leftBarButtonItem = editButtonItem()
        
        let aConnect:MovieCollectionStub = MovieCollectionStub(urlString: "http://localhost:8080")
        var response:String = ""
        let resTitles:Bool = aConnect.getTitles({ (res: String, err: String?) -> Void in
            if err != nil {
                print(err)
            }else{
                response = res
                print(response)
                let jsonString = response.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
                
                let jsonObj = JSON(data: jsonString!)
                if jsonObj != JSON.null {
                    let thisvar:[JSON] = jsonObj["result"].arrayValue
                    
                      for title:JSON in thisvar{
                          let newTitle = title.rawString()!
                            self.titles.append(newTitle)
                      }
                    self.tableView.reloadData()
                    print("after reload")
                }

            }
        })
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    func loadSampleMeals() {
        let movie = [MovieDescription(title: "The Bourne Identity"), MovieDescription(title: "Inside Out")]
        movies.movie_list.appendContentsOf(movie)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("num rows: \(self.titles.count)")
        return self.titles.count
    }
    

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        
        
        let cellIdentifier = "MovieTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! MovieTableViewCell
        // Fetches the appropriate meal for the data source layout.
        let title = self.titles[indexPath.row]
        cell.label_title.text  = title

        // Configure the cell...

        return cell
    }
    
    
    
    @IBAction func unwindToMovieDescription(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? AddViewController {
            // Add a new meal.
            let movie = sourceViewController.titl
            let newIndexPath = NSIndexPath(forRow: movies.movie_list.count, inSection: 0)
            titles.append(movie)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
        }
    }


    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }


    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            
            let aConnect:MovieCollectionStub = MovieCollectionStub(urlString: "http://192.168.1.107:8080")
            var response:String = ""
            //let index = tableView.indexPathForCell(cell)?.indexAtPosition(1)
            let ix = String(indexPath.indexAtPosition(1))
            let resTitles:Bool = aConnect.delete(ix, callback: { (res: String, err: String?) -> Void in
                if err != nil {
                    print(err)
                }else{
                    response = res
                    print(response)
                    let jsonString = response.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
                    print("string............"  + response)
                    
                }
            })
            titles.removeAtIndex(indexPath.indexAtPosition(1))

            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

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
        if segue.identifier == "segue_detail"{
            let cont = segue.destinationViewController as! DetailViewController
            let cell = sender as! MovieTableViewCell
            let index = tableView.indexPathForCell(cell)?.indexAtPosition(1)
            let movie = titles[index!]
            cont.incoming_index = index!
        }
        
        
        
        // Pass the selected object to the new view controller.
    }
    

}
