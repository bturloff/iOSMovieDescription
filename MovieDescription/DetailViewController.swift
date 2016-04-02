//
//  DetailViewController.swift
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

class DetailViewController: UIViewController {
    
    @IBOutlet weak var label_title: UILabel!
    @IBOutlet weak var label_year: UILabel!
    @IBOutlet weak var label_rated: UILabel!
    @IBOutlet weak var label_released: UILabel!
    @IBOutlet weak var label_runtime: UILabel!
    @IBOutlet weak var label_genre: UILabel!
    @IBOutlet weak var label_actors: UILabel!
    @IBOutlet weak var label_plot: UILabel!
    
    var movie:MovieDescription?
    var incoming_index:Int = -1
    
    override func viewDidLoad(){
        
        
        self.title = "Description"
        
        label_title.text = movie?.title
        label_year.text = movie?.year
        label_rated.text = movie?.rated
        label_released.text = movie?.released
        label_runtime.text = movie?.runtime
        label_genre.text = movie?.genre
        label_actors.text = movie?.actors
        label_plot.text = movie?.plot
        
        let aConnect:MovieCollectionStub = MovieCollectionStub(urlString: "http://localhost:8080")
        var response:String = ""
        let ix = String(incoming_index)
        let resTitles:Bool = aConnect.getMovie(ix, callback: { (res: String, err: String?) -> Void in
            if err != nil {
                print(err)
            }else{
                response = res
                print(response)
                let jsonString = response.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
                print("string............"  + response)
                
                let jsonObj = JSON(data: jsonString!)
                if jsonObj != JSON.null {
                    print(jsonObj.rawString())
                    let thisvar = jsonObj["result"].dictionary
                    self.label_title.text = thisvar!["Title"]!.stringValue
                    self.label_year.text = thisvar!["Year"]!.stringValue
                    self.label_rated.text = thisvar!["Rated"]!.stringValue
                    self.label_released.text = thisvar!["Released"]!.stringValue
                    self.label_runtime.text = thisvar!["Runtime"]!.stringValue
                    self.label_genre.text = thisvar!["Genre"]!.stringValue
                    self.label_actors.text = thisvar!["Actors"]!.stringValue
                    self.label_plot.text = thisvar!["Plot"]!.stringValue                  
                }
                
            }
        })

        
    }

}
