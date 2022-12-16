//
//  EditViewController.swift
//  final-bmi
//
//  Created by Cadence Kuan on 16/12/2022.
//

import UIKit

class EditViewController: UIViewController {

    //IBOutlet declearation
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var ageText: UITextField!
    @IBOutlet weak var genderText: UITextField!
    @IBOutlet weak var weightText: UITextField!
    @IBOutlet weak var heightText: UITextField!
    @IBOutlet weak var bmiLable: UILabel!
    @IBOutlet weak var statusLable: UILabel!
    
    var InfoArr = [[String:String]]() //DB
    var selectedItem = 0
    let InputArray:[Character] = ["0","1","2","3","4","5","6","7","8","9","."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //DB
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initDetails()
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    // init detail setting
    func initDetails(){
        InfoArr =  UserDefaults.standard.object(forKey: "arrayList") as? [[String:String]] ?? [[String:String]]()
        let selectedItem = InfoArr[selectedItem]
        let measurement = selectedItem["measurement"]
        nameText.text = selectedItem["name"]
        ageText.text = selectedItem["age"]
        genderText.text = selectedItem["gender"]
        statusLable.text = selectedItem["category"]
        bmiLable.text = selectedItem["BMI"]
        
        if measurement == "metric"{
            weightText.text = selectedItem["weight"]! + " Kg"
            heightText.text = selectedItem["height"]! + " Meters"
        }else{
            weightText.text = selectedItem["weight"]! + " Lb"
            heightText.text = selectedItem["height"]! + " Inches"
        }

    }
    
    //edit button
    @IBAction func updateCal_Pressed(_ sender: UIButton) {
        // string Checker

        
        // pop up alert for number
        let alertNum = UIAlertController(title: "Alert", message: "Number Please", preferredStyle: UIAlertController.Style.alert)
        alertNum.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        
        if !strChecker(str: weightText.text!) || !strChecker(str: heightText.text!){
            self.present(alertNum, animated: true, completion: nil)
            return
        }
        
        // pop up alert for empty
        let alertEmp = UIAlertController(title: "Alert", message: "Can't Empty", preferredStyle: UIAlertController.Style.alert)
        alertEmp.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        
        if weightText.text == "" || heightText.text == ""{
            self.present(alertEmp, animated: true, completion: nil)
            return
        }
        
        let item = InfoArr[selectedItem]
        let name = nameText.text ?? ""
        let age = ageText.text ?? ""
        let weight = weightText.text ?? ""
        let height = heightText.text ?? ""
        let gender = genderText.text ?? ""
        var BMI:Double! = Double(bmiLable.text!)
        let measurement = item["measurement"]
        var weightUp:Double! = 0.0
        var heightUp:Double! = 0.0
        if weight != item["weight"] || height != item["height"]{
            //recalculate BMI
            weightUp = Double(weightText.text!)
            heightUp = Double(heightText.text!)
            if measurement == "metrix"{
                BMI = weightUp/((heightUp)*(heightUp))
            }else{
                BMI = (weightUp*703)/(heightUp * heightUp)
            }
        }
        
        func strChecker(str:String)->Bool{
            for char in str {
                if !InputArray.contains(char){
                    return false
                }
            }
            return true
        }
        
        var category:String = BMIrange(BMI: BMI)
        var formatBMI = String(format:"%.2f", BMI)
        
        InfoArr[selectedItem]["name"] = name
        InfoArr[selectedItem]["age"] = age
        InfoArr[selectedItem]["weight"] = weight
        InfoArr[selectedItem]["height"] = height
        InfoArr[selectedItem]["category"] = category
        InfoArr[selectedItem]["gender"] = gender
        InfoArr[selectedItem]["BMI"] = formatBMI
        UserDefaults.standard.set(InfoArr,forKey:"arrayList")
        let vc = storyboard?.instantiateViewController(identifier: "tableScreen") as! TableViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true,completion: nil)
    }
    
    
    // BMI range
    func BMIrange(BMI:Double)->String{
        if BMI<16{
            return "Severe Thinness"
        }else if BMI >= 16 && BMI < 17{
            return "Moderare Thinness"
        }else if BMI >= 17 && BMI < 18.5{
            return "Mild Thinness"
        }else if BMI >= 18.5 && BMI < 25{
            return "Normal"
        }else if BMI >= 25 && BMI < 30{
            return "Overweight"
        }else if BMI >= 30 && BMI < 35{
            return "Obese Class I"
        }else if BMI >= 35 && BMI < 40{
            return "Obese Class II"
        }else{
            return "Obese Class III"
        }
    }
    
    // save and return btn
    @IBAction func doneBtn_Pressed(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "tableView") as! TableViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
}
