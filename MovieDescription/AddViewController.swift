//
//  ViewController.swift
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

import UIKit

class AddViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate {
    
    
    // MARK: Properties
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var text_title: UITextField!
    @IBOutlet weak var text_year: UITextField!
    @IBOutlet weak var text_rated: UITextField!
    @IBOutlet weak var text_released: UITextField!
    @IBOutlet weak var text_runtime: UITextField!
    @IBOutlet weak var text_genre: UITextField!
    @IBOutlet weak var text_actors: UITextField!
    @IBOutlet weak var text_plot: UITextField!
    @IBOutlet weak var picker_rated: UIPickerView!
    
    var movie:MovieDescription?
    let ratings = ["G", "PG", "PG-13", "R"]
    var titl:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker_rated.delegate = self
        self.text_rated.inputView = picker_rated
        picker_rated.removeFromSuperview()
    }
    
    // This method lets you configure a view controller before it's presented.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            let title = text_title.text ?? ""
            
            // Set the meal to be passed to MealTableViewController after the unwind segue.
            movie = MovieDescription(
                title: title, year: text_year.text!, rated: text_rated.text!, runtime: text_runtime.text!,
                released: text_released.text!, genre: text_genre.text!, actors: text_actors.text!, plot: text_plot.text!);
            self.titl = title
            let jsonString = movie?.toJsonString()
            
            let aConnect:MovieCollectionStub = MovieCollectionStub(urlString: "http://192.168.1.107:8080")
            var response:String = ""
            let resTitles:Bool = aConnect.getMovie(jsonString!, callback: { (res: String, err: String?) -> Void in
                if err != nil {
                    print(err)
                }else{
                    response = res
                    print(response)
                    
                }
            })

            
        }
        else if cancelButton === sender {
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: -- UIPickerVeiwDelegate methods
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.text_rated.text = ratings[row]
        self.text_rated.resignFirstResponder()
        
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ratings.count
    }
    
    func pickerView (pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ratings[row]
    }

}

