//
//  ViewController.swift
//  HW1
//
//  Created by apple on 2021/1/27.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var lblPressme: UILabel!
    
    @IBOutlet weak var imgview: UIImageView!
    
    var playBtnIsVisible : Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func btnAction(_ sender: Any) {
        lblPressme.text = "button pressed"
        print("press me button is pressed")
        if playBtnIsVisible == true{
            playBtnIsVisible = false
            imgview.image = UIImage(named: "wang")
        }
        else{playBtnIsVisible = true
            imgview.image = UIImage(named: "zichun")
        }
    }
    
}

