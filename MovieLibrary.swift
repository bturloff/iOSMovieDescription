//
//  MovieLibrary.swift
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

import Foundation

class MovieLibrary{
    
    var movie_list:[MovieDescription]
    
    
    
    init(list: [MovieDescription]){
        movie_list = [MovieDescription]()
        self.movie_list = list
    }
    
    
    
    init(){
        movie_list = []
        
        if let path = NSBundle.mainBundle().pathForResource("movies", ofType: "json") {
            do {
                let data = try NSData(contentsOfURL: NSURL(fileURLWithPath: path), options: NSDataReadingOptions.DataReadingMappedIfSafe)
                let jsonObj = JSON(data: data)
                if jsonObj != JSON.null {
                    
                    //print("jsonData:\(jsonObj["Interstellar", "Plot"].string)")
                    let obj = jsonObj.dictionary
                    for (_,subJson):(String, JSON) in obj!{
                        let newMovie = MovieDescription(jsonStr:subJson.rawString()!)
                        movie_list.append(newMovie)
                    }
                } else {
                    print("could not get json from file, make sure that file contains valid json.")
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } else {
            print("Invalid filename/path.")
        }
    
    
    
    }
}