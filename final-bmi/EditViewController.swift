//
//  EditViewController.swift
//  final-bmi
//
//  Created by Cadence Kuan on 16/12/2022.
//

import UIKit

class EditViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func doneBtn_Pressed(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "tableView") as! TableViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
}
