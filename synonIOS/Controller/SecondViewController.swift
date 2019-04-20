//
//  SecondViewController.swift
//  synonIOS
//
//  Created by Felipe Silva Lima on 4/19/19.
//  Copyright © 2019 Felipe Silva Lima. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

//MARK : - StoryBoard IBOutlet, variables and Constats.
    
    //IBOutlet
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var textBody: UITextView!
    
    let thesaurusDataModel = ThesaurusDataModel()
    
    //Variables Declaration
    var thesaurusModel = [String]()
    var textLabel: String = ""
    var textToPrint: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textBody.text = ""
        setupVC()
        
    }
    
    func setupVC() {
        
        //Setting the Head with the word chosen to find the Synonym
        wordLabel?.text = textLabel
        for index in 0..<thesaurusModel.count {
            textToPrint += "\n \(thesaurusModel[index])"
        }
        //Filling the TextView with the object data
        textBody.text = textToPrint
        textToPrint = ""
    }
}
