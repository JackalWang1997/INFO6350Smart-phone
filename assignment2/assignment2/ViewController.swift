//
//  ViewController.swift
//  assignment2
//
//  Created by wang.zichu on 2021/3/13.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var logoView: UIImageView!
    @IBOutlet weak var diceLeft: UIImageView!
    @IBOutlet weak var diceRight: UIImageView!
    @IBOutlet weak var currentTip: UILabel!
    @IBOutlet weak var resultTip: UILabel!
    @IBOutlet weak var playBtn: UIButton!
    
    var sum:Int = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currentTip.text = "Please tap Play button"
        self.resultTip.text = "Your balance = \(self.sum)$"
    }

    @IBAction func playBtnClick(_ sender: Any) {
        let left = Int.random(in: 1...6)
        let right = Int.random(in: 1...6)
        self.diceLeft.image = UIImage.init(named: "Dice\(left)")
        self.diceRight.image = UIImage.init(named: "Red\(right)")

        var tip:String = ""
        var balance:Int = 0
        let result = left + right
        
        if (result == 7) {
            tip = "You won 3$"
            balance = 3
        } else if (result < 7) {
            tip = "You lost 1$"
            balance = -1
        } else {
            tip = "You won 1$"
            balance = 1
        }
        self.currentTip.text = tip
        self.sum = self.sum + balance
        self.resultTip.text = "Your balance = \(self.sum)$"
        
        if (self.sum <= 0) {
            self.playBtn.isEnabled = false
            self.currentTip.text = "Please restart app"
        }
    }
    
}

