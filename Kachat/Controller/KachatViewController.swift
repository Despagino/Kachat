//
//  KachatViewController.swift
//  Kachat
//
//  Created by Gino Tasis on 3/8/22.
//

import UIKit

class KachatViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = ""
        var charIndex = 0.0
        var loop = 0.0
        var titleText = "Kachat"
        for letter in titleText  {
            Timer.scheduledTimer(withTimeInterval: 0.4 * charIndex, repeats: false) { timer in
                self.titleLabel.text?.append(letter)
            }
            charIndex += 1
        }
        Timer.scheduledTimer(withTimeInterval: 4.6, repeats: false) { timer in
            for letter in self.titleLabel.text! {
                Timer.scheduledTimer(withTimeInterval: 0.32 * loop, repeats: false) { timer in
                    self.titleLabel.text?.removeLast()
                }
                loop += 1
            }
        }
        
        Timer.scheduledTimer(withTimeInterval: 6.6, repeats: false) { timer in
            charIndex = 0.0
            for letter in titleText {
                Timer.scheduledTimer(withTimeInterval: 0.4 * charIndex, repeats: false) { timer in
                    self.titleLabel.text?.append(letter)
                }
                charIndex += 1
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
