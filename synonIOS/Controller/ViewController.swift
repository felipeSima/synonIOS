//
//  ViewController.swift
//  synonIOS
//
//  Created by Felipe Silva Lima on 4/19/19.
//  Copyright © 2019 Felipe Silva Lima. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class ViewController: UIViewController {
    
    
//MARK : - StoryBoard Outlets and Variables Declarations
    
    //IBOutlet Declaration
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    
    //Instance Declaration
    let thesaurusDataModel = ThesaurusDataModel()
    
    //Constant Declaration
    let endPoint : String = "https://w602e30xq1.execute-api.us-east-1.amazonaws.com/dev/"
    let synonymQuery : String = "/synonym?word="
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Rounding the UIButton for better looking
        searchButton.layer.cornerRadius = 15
    }
    
    //Function for generate the final endpoint
    @IBAction func searchButtonPressed(_ sender: Any) {
        
        let finalUrl : String = endPoint + synonymQuery + textField.text!
        
        //calling the function for the api request with the final URL
        getSynonym(with: finalUrl)
        
    }
    
//MARK : - NETWORKING
    
    
    //API Request through Alamofire (CocoaPod for elegant Request)
    func getSynonym (with url : String) {
        Alamofire.request(url, method: .get).responseString { (response) in
            if response.result.isSuccess {
                
                //Encoding Result valeu of type string for use as JSON
                let encodedString = Data(response.result.value!.utf8)
                
                do {
                //Decoding the Result as a JSON for easy use, as said in the documentation of Swift 4.1
                    let finalJSON = try JSON(data: encodedString)
                    self.updateSynonymData(with: finalJSON)
                    
                } catch {return}

            }
            else {
                print("Error attempting to get data \(String(describing: response.result.error))")
            }
        }
           
    }
    
    //Updating the thesaurus object with the Json array.
    func updateSynonymData(with json : JSON) {
        
        for index in 0..<json.count{
            
            thesaurusDataModel.synonymArray.append(json[index]["word"].stringValue)
            
        }
        //Switching to the SecondViewController
        performSegue(withIdentifier: "goToSecondVC", sender: self)
    }
    
    //Preparing Information to be sent to the SecondViewController
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is SecondViewController {
            let destinationVC = segue.destination as? SecondViewController
            destinationVC?.textLabel = textField.text!
            destinationVC?.thesaurusModel = thesaurusDataModel.synonymArray
            //print("Tamanho: \(thesaurusDataModel.synonymArray.count)")
        }
    }
}

