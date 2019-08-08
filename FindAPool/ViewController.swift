//
//  ViewController.swift
//  FindAPool
//
//  Created by Mohit Doshi on 8/7/19.
//  Copyright © 2019 forty-two. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var LogoImageView: UIImageView!
    
    @IBOutlet weak var NameField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("In Segue\n")
            // pass data to next view
        let obj = segue.destination as!FindPoolViewController
            obj.sentName = NameField.text!

    }

}

