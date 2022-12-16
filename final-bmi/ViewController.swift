//
//  ViewController.swift
//  final-bmi
//
//  Created by Cadence Kuan on 13/12/2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var NameText: UITextField!
    @IBOutlet weak var AgeText: UITextField!
    @IBOutlet weak var WeightText: UITextField!
    @IBOutlet weak var HeightText: UITextField!
    @IBOutlet weak var GenderText: UITextField!
    @IBOutlet weak var ResultStatus: UILabel!
    @IBOutlet weak var BMIResult: UILabel!
     // M: kg/m^2  I: p*703/inch^2
    @IBOutlet weak var mBtn: UIButton!
    @IBOutlet weak var iBtn: UIButton!
    
    let defaults = UserDefaults.standard // DB
    var InfoArr = [[String:String]]() //DB
    var MeasurementStatus:String = "Metric"
    let InputArray:[Character] = ["0","1","2","3","4","5","6","7","8","9","."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MeasurementStatus = "metric"
        WeightText.placeholder = "kg"
        HeightText.placeholder = "m"
        if(UserDefaults.standard.object(forKey: "arrayList") == nil){
            defaults.set(InfoArr,forKey:"arrayList")}
    }
    
    @IBAction func mBtn_Pressed(_ sender: UIButton) {
        MeasurementStatus = "metric"
        WeightText.placeholder = "kg"
        HeightText.placeholder = "m"
    }
    
    @IBAction func iBtn_Pressed(_ sender: UIButton) {
        MeasurementStatus = "imperial"
        WeightText.placeholder = "pound"
        HeightText.placeholder = "inch"
    }
    
    @IBAction func calBtn_Pressed(_ sender: UIButton){
        
        func strChecker(str:String)->Bool{
            for char in str {
                if !InputArray.contains(char){
                    return false
                }
            }
            return true
        }
        
        let alertNum = UIAlertController(title: "Alert", message: "Number Please", preferredStyle: UIAlertController.Style.alert)
        alertNum.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        
        if !strChecker(str:WeightText.text!) || !strChecker(str:HeightText.text!){
            self.present(alertNum, animated: true, completion: nil)
            return
        }
        
        let alertEmp = UIAlertController(title: "Alert", message: "Can't Empty", preferredStyle: UIAlertController.Style.alert)
        alertEmp.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        
        if WeightText.text == "" || HeightText.text == ""{
            self.present(alertEmp, animated: true, completion: nil)
            return
        }
        
        if !strChecker(str:WeightText.text!) || !strChecker(str:HeightText.text!){
            self.present(alertNum, animated: true, completion: nil)
            return
        }
        
        var weight:Double! = 0.0
        var height:Double! = 0.0
        var BMIresult:Double! = 0.0
        var resultStatus:String = ""
        
        weight = Double(WeightText.text!)
        height = Double(HeightText.text!)
        
        if MeasurementStatus == "metric"{
            BMIresult = weight/((height)*(height))
        }else{
            BMIresult = (weight*703)/(height*height)
        }
        
        resultStatus = BMIrange(BMI: BMIresult)
        let formatBMI = String(format:"%.2f", BMIresult)
        BMIResult.text = formatBMI
        ResultStatus.text = resultStatus
        
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
        
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let dateStr = dateFormatter.string(from: now)
        
        let weightStr:String = String(weight)
        let heightStr:String = String(height)
        let BMIstr = String(BMIresult)
        
        InfoArr = defaults.object(forKey: "arrayList") as? [[String:String]] ?? [[String:String]]()
        var dict = [String:String]()
        dict["height"] = heightStr
        dict["weight"] = weightStr
        dict["date"] = dateStr
        dict["BMI"] = formatBMI
        if NameText.text != ""{
            dict["name"] = NameText.text
        }else{
            dict["name"] = ""
        }
        if AgeText.text != ""{
            dict["age"] = AgeText.text
        }else{
            dict["age"] = ""
        }
        if GenderText.text != ""{
            dict["gender"] = GenderText.text
        }else{
            dict["gender"] = ""
        }
        if MeasurementStatus == "metric"{
            dict["measurement"] = "metric"
        }else{
            dict["measurement"] = "imperial"
        }
        dict["range"] = BMIResult.text
        InfoArr.append(dict)
        print("InfoArr.count is: \(InfoArr.count)")
        defaults.set(InfoArr, forKey:"arrayList")
        
    }
    
    @IBAction func doneBtn_Pressed(_ sender: UIButton) {
        // convert weight and height to double
        let vc = storyboard?.instantiateViewController(identifier: "tableView") as! TableViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @IBAction func clrBtn_Pressed(_ sender: UIButton) {
        NameText.text = ""
        AgeText.text = ""
        GenderText.text = ""
        WeightText.text = ""
        HeightText.text = ""
        BMIResult.text = "BMI to be calculated"
        ResultStatus.text = "--Your Status to be show--"
    }
    
    
}

