//
//  MovieDescription.swift
//  MovieDescription


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



class MovieDescription {
    
    var title: String
    var year: String?
    var rated: String?
    var runtime: String?
    var released: String?
    var genre: String?
    var actors: String?
    var plot: String?
    
    init(title: String){
        self.title = title
    }
    
    init (jsonStr: String){
        
        self.title = ""
        self.year = ""
        self.rated = ""
        self.runtime = ""
        self.released = ""
        self.genre = ""
        self.actors = ""
        self.plot = ""
        
        
        if let data: NSData = jsonStr.dataUsingEncoding(NSUTF8StringEncoding){
            do{
                let dict = try NSJSONSerialization.JSONObjectWithData(data,options:.MutableContainers) as?[String:AnyObject]
                self.title = (dict!["Title"] as? String)!
                self.year = (dict!["Year"] as? String)!
                self.rated = (dict!["Rated"] as? String)!
                self.runtime = (dict!["Runtime"] as? String)!
                self.released = (dict!["Released"] as? String)!
                self.genre = (dict!["Genre"] as? String)!
                self.actors = (dict!["Actors"] as? String)!
                self.plot = (dict!["Plot"] as? String)!
                
            } catch {
                print("unable to convert to dictionary")
                
            }
        }
        
    }
    
    init (title: String, year: String, rated: String, runtime: String, released: String, genre: String, actors: String, plot: String){
        
        self.title = title
        self.year = year
        self.rated = rated
        self.runtime = runtime
        self.released = released
        self.genre = genre
        self.actors = actors
        self.plot = plot
    }

    func  toJsonString() -> String{
    
        var jo:JSON = [:]
        jo["Title"] = JSON(title)
        jo["Year"].string = year
        jo["Rated"].string = rated
        jo["Runtime"].string = runtime
        jo["Released"].string = released
        jo["Genre"].string = genre
        jo["Actors"].string = actors
        jo["Plot"].string = plot
        print("Json string:  \(jo.rawString()!)")
        
        return jo.rawString()!
    }
    
    
    
   
    
    
}