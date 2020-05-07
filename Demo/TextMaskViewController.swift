//
//  TextMaskViewController.swift
//  Demo
//
//  Created by Vinay Jain on 07/05/20.
//

import UIKit
import Patterns

class TextMaskViewController: UIViewController {
    
    @IBOutlet weak var checksView: ChecksView!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checksView.mask = label
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
