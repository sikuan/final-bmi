//
//  TableViewController.swift
//  final-bmi
//
//  Created by Cadence Kuan on 16/12/2022.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableList: UITableView!
    let defaults = UserDefaults.standard
    
    // table view list
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var list = defaults.object(forKey: "arrayList") as? [[String:String]] ?? [[String:String]]()
        print("list.count is:\(list.count)")
        return list.count
    }
    
    // table view cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var arrayList = defaults.object(forKey: "arrayList") as? [[String:String]] ?? [[String:String]]()
        let list =  arrayList[indexPath.row]
        let cell =  tableList.dequeueReusableCell(withIdentifier: "cell",for:indexPath) as? TableViewCell
        
        cell!.labelBMI.text = list["BMI"]
        if list["measurement"] == "metric"{
            cell!.labelWeight.text = (list["weight"] ?? "") + " Kg"
        }else{
            cell!.labelWeight.text = (list["weight"] ?? "") + " Lb"
        }
        cell!.labelDate.text = list["date"]
        cell?.buttonEdit.tag = indexPath.row
        cell!.buttonEdit.addTarget(self, action: #selector(updateScreen(sender:)), for: .touchUpInside)
        return cell!
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableList.delegate = self
        tableList.dataSource = self
    }
    
    // update screen
    @objc func updateScreen(sender: UIButton){
        print("sender.tag is: \(sender.tag)")
        let vc = storyboard?.instantiateViewController(identifier: "updateScreen") as! EditViewController
        let nc = UINavigationController(rootViewController: vc)
        vc.selectedItem = sender.tag
        present(nc, animated: true,completion: nil)
    }
    
    // back button
    @IBAction func backBtn_Pressed(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "mainView") as! ViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    // edit button
    @IBAction func editBtn_Pressed(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "editView") as! EditViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}
