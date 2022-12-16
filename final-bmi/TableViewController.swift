//
//  TableViewController.swift
//  final-bmi
//
//  Created by Cadence Kuan on 16/12/2022.
//

import UIKit

class TableViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    @IBAction func backBtn_Pressed(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "mainView") as! ViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @IBAction func editBtn_Pressed(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "editView") as! EditViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}
