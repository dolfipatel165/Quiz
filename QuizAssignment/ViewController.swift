//
//  ViewController.swift
//  QuizAssignment
//
//  Created by Yogesh Chalodiya on 2015-10-10.
//  Copyright (c) 2015 Yogesh Chalodiya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var btnOption1: UIButton!
    @IBOutlet weak var btnOption2: UIButton!
    @IBOutlet weak var btnOption3: UIButton!
    @IBOutlet weak var btnOption4: UIButton!
    @IBOutlet weak var btnAnswer: UIButton!
    @IBOutlet weak var lblQuestions: UITextView!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var lblNumber: UILabel!
    
    //private var resultViewConroller: ResultViewController!
    
    var arrQuizQues : [String] = ["For which of the following disciplines is Nobel Prize awarded?",
        "The ozone layer restricts",
        "Headquarters of UNO are situated at",
        "For purifying drinking water alum is used",
        "John F. Kennedy was",
        "Name the instrument used to measure relative humidity",
        "Neil Armstrong and Edwin Aldrin were the first to",
        "Leonardo da Vinci",
        "Of the blood groups A, B, AB and O, which one is transfused into a person whose blood group is A?","Light Year is related to"]
    
    var arrQuizAns: [Int : Array<String>] = [0 : ["Physics and Chemistry","Physiology or Medicine","Literature, Peace and Economics","All of the above","All of the above"],
        1 : ["Visible light","Infrared radiation","X-rays and gamma rays","Ultraviolet radiation","Ultraviolet radiation"],
        2 : ["New York, USA","Haque (Netherlands)","Geneva","Paris","New York, USA"],
        3 : ["for coagulation of mud particles","to kill bacteria","to remove salts","to remove gases","for coagulation of mud particles"],
        4 : ["one the most popular Presidents of USA","the first Roman Catholic President","writer of Why England slept and Profile in Courage","All the above","All the above"],
        5 : ["Hydrometer","Hygrometer","Barometer","Mercury Thermometer","Hygrometer"],
        6 : ["step on the moon","circle the moon","walk in space","journey into space","step on the moon"],
        7 : ["was a great Italian painter, sculptor and architect","got universal fame form his masterpiece Monalisa","drew models of organs such as the heart, lungs and womb","All of the above","All of the above"],
        8 : ["Group A only","Group B only","Group A and O","Group AB only","Group A and O"],
        9 : ["energy","speed","distance","intensity","distance"]]
    var arrSelectedQuesNo:[Int] = []
    var arrSelectedQuizQues = [String]()
    var arrSelectedQuizAns = [Int : Array<String>]()
    var answerIndex = 0
    
    var correctAns: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        selectRandomQuestions()
        
        LoadQuestions(answerIndex)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func btnNextPressed(sender: UIButton) {
        
        var ansSelected = "Incorrect answer"
        var message = "Correct answer"
        
        if btnOption1.selected{
            ansSelected = btnOption1.titleForState(.Normal)!
        }
        else if btnOption2.selected{
            ansSelected = btnOption2.titleForState(.Normal)!
        }
        else if btnOption3.selected{
            ansSelected = btnOption3.titleForState(.Normal)!
        }
        else if btnOption4.selected{
            ansSelected = btnOption4.titleForState(.Normal)!
        }
        
        if ansSelected != btnAnswer.titleForState(.Normal){
            //wrongAns++
            message = "Incorrect answer!\nCorrect answer is \(btnAnswer.titleForState(.Normal)!)"
            // UIImage(named: "star")
        }
        else{
            correctAns++
        }
        
        var controller = UIAlertController(title: "", message: message, preferredStyle: .Alert)
        
        var action = UIAlertAction(title: "OK", style: .Default, handler: { act in
            
            self.answerIndex++
            self.LoadQuestions(self.answerIndex)
        })
        
        controller.addAction(action)
        presentViewController(controller, animated: true, completion: nil)
    }
    
    private func LoadQuestions(answerNo: Int){
        if answerNo < 5{
            lblNumber.text = "\(answerIndex+1)."
            lblQuestions.text = arrSelectedQuizQues[answerNo]
            
            var arrOptions: [String] = arrSelectedQuizAns[arrSelectedQuesNo[answerNo]]!
            
            btnOption1.setTitle(arrOptions[0], forState: UIControlState.Normal)
            btnOption2.setTitle(arrOptions[1], forState: UIControlState.Normal)
            btnOption3.setTitle(arrOptions[2], forState: UIControlState.Normal)
            btnOption4.setTitle(arrOptions[3], forState: UIControlState.Normal)
            btnAnswer.setTitle(arrOptions[4], forState: UIControlState.Normal)
        }
        else{
            var resMessage: String = "You scored \(correctAns)/5\n"
            var titleMessage: String = "Congratulations!!!"
            var actionTitle = "Great!"
            
            if correctAns == 5{
                resMessage += "You are a genius!"
            }
            else if correctAns == 4{
                resMessage += "Excellent work!"
            }
            else if correctAns == 3{
                resMessage += "Good Job!"
            }
            else{
                resMessage += ""
                titleMessage = ""
                actionTitle = "Please try again!"
            }
            
            var controller = UIAlertController(title: titleMessage, message: resMessage, preferredStyle: .Alert)
            var passAction = UIAlertAction(title: actionTitle, style: .Default, handler: nil)
            
            if actionTitle == "Please try again!" {
                passAction = UIAlertAction(title: actionTitle, style: .Default, handler: { act in
                    self.answerIndex = 0
                    self.correctAns = 0
                    self.arrSelectedQuesNo = []
                    self.arrSelectedQuizQues = []
                    self.arrSelectedQuizAns = [Int : Array<String>]()
                    self.selectRandomQuestions()
                    self.LoadQuestions(self.answerIndex)
                })
            }
            else{
                btnNext.enabled = false
            }
            
            controller.addAction(passAction)
            
            presentViewController(controller, animated: true, completion: nil)
        }
    }
    
    private func selectRandomQuestions(){
        while (arrSelectedQuesNo.count < 5) {
            var rn: Int = Int(arc4random_uniform(UInt32(arrQuizQues.count)))
            
            arrSelectedQuesNo.append(rn)
        }
        
        for i in 0..<arrSelectedQuesNo.count {
            arrSelectedQuizQues.append(arrQuizQues[arrSelectedQuesNo[i]])
            arrSelectedQuizAns.updateValue(arrQuizAns[arrSelectedQuesNo[i]]!, forKey: arrSelectedQuesNo[i])
        }
    }
    
    @IBAction func btnPressed(sender: UIButton) {
        if sender.tag == 1{
            btnOption1.selected = true
            btnOption2.selected = false
            btnOption3.selected = false
            btnOption4.selected = false

        }
        else if sender.tag == 2{
            btnOption1.selected = false
            btnOption2.selected = true
            btnOption3.selected = false
            btnOption4.selected = false
        }
        else if sender.tag == 3{
            btnOption1.selected = false
            btnOption2.selected = false
            btnOption3.selected = true
            btnOption4.selected = false
        }
        else if sender.tag == 4{
            btnOption1.selected = false
            btnOption2.selected = false
            btnOption3.selected = false
            btnOption4.selected = true
        }
    }
    
}



