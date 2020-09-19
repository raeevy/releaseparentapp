//
//  McqScoreCell.swift
//  LearningApp
//
//  Created by Technology on 04/03/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit
class McqScoreCell: UITableViewCell {
   
    @IBOutlet weak var viewContainer: CustomView!
    @IBOutlet weak var lblQuestionSeries: UILabel!
    @IBOutlet weak var lblQuestionText: UILabel!
    @IBOutlet weak var lblAttemptedAnswer: UILabel!
    @IBOutlet weak var lblCorrectAnswer: UILabel!
    @IBOutlet weak var lblCorrectAnswerText: UILabel!
    @IBOutlet weak var lblAnswer: UILabel!
    @IBOutlet weak var btnQuestionResult: UIButton!
    @IBOutlet weak var btnCell : UIButton!
    
//    var arrayAllAnswers = [All]()
//    var _ActionHandler:ActionHandler!
    var selectedIndex:IndexPath!

    override func awakeFromNib() {
        super.awakeFromNib()
       
        btnQuestionResult.setTitleColor(UIColor.white
            , for: .normal)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        btnQuestionResult.layer.cornerRadius = btnQuestionResult.frame.size.height/2
        btnQuestionResult.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
//    func setUpMcqScoreValue(indexCell:IndexPath,data:All,actionHandler: @escaping ActionHandler)  {
//       _ActionHandler = actionHandler
//        selectedIndex = indexCell
//        if let dict = LocalizedStringManager.sharedObj.stringList {
//            if let question:String = dict["txt_question"] as? String  {
//                 lblQuestionSeries.text = question  + " " + String(indexCell.row+1)
//            }
//            lblAttemptedAnswer.text = dict["attempted_answer"] as? String ?? ""
//            lblCorrectAnswer.text = dict["correct_answer"] as? String ?? ""
//        }
//        lblAnswer.text = data.yourAnswer
//        lblCorrectAnswerText.text = data.rightAnswer
//        if let question:String = data.question {
//            let questionAttributed = question.htmlDecodedAttributed ?? NSAttributedString(string: kEmptyString)
//            let myAttributedString = NSMutableAttributedString()
//            let paragraphStyle: NSMutableParagraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
//            paragraphStyle.tabStops = [NSTextTab(textAlignment: .left, location: 10, options: [:])]
//            paragraphStyle.firstLineHeadIndent = 0
//            paragraphStyle.headIndent = 10
//            let item1 =  NSMutableAttributedString(string:questionAttributed.string,attributes: [.font: UIFont.systemFont(ofSize: 13.0), .paragraphStyle: paragraphStyle])
//            myAttributedString.append(item1)
//            lblQuestionText.attributedText = myAttributedString
//        }
//        if data.yourAnswer == data.rightAnswer {
//            btnQuestionResult.setTitle("✓" ,for: .normal)
//            btnQuestionResult.backgroundColor = UIColor.green
//        }else if data.yourAnswer == kEmptyString {
//            btnQuestionResult.setTitle("–" ,for: .normal)
//            btnQuestionResult.backgroundColor = grayColor
//        }else if data.yourAnswer != data.rightAnswer {
//            btnQuestionResult.setTitle("✕" ,for: .normal)
//            btnQuestionResult.backgroundColor = redColor
//        }
//    }
    
 //   func setData(indexCell:IndexPath,data:All)
//    {
//           selectedIndex = indexCell
////           if let dict = LocalizedStringManager.sharedObj.stringList {
////               if let question:String = dict["question"] as? String  {
////                    lblQuestionSeries.text = question  + " " + String(indexCell.row+1)
////               }
////           }
//        var questionCount = 0
//        for value in arrayAllAnswers{
//            questionCount = questionCount + 1
//            if value.questionId == data.questionId{
//                break
//            }
//        }
//        if let dict = LocalizedStringManager.sharedObj.stringList{
//        lblQuestionSeries.text = "\(dict["txt_question"] as? String ?? "")"  + " " + String(questionCount)
//            lblAttemptedAnswer.text = dict["attempted_answer"] as? String ?? ""
//            lblCorrectAnswer.text = dict["correct_answer"] as? String ?? ""
//        }
//           lblAnswer.text = data.yourAnswer
//           lblCorrectAnswerText.text = data.rightAnswer
//           if let question:String = data.question {
//
////            if (data.question ?? "").contains("&#"){
////                lblQuestionText.setHTML(html:  "<h2>\(data.question ?? "")</h2>")
////
////            }else{
//                lblQuestionText.attributedText = "<h2>\(data.question ?? "")</h2>".html2AttributedString
////            }
//            lblQuestionText.font = UIFont(name: "Helvetica Neue", size: 18)
//            let contenturl  =   UserDefaults.standard.value(forKey: "contentIP_address") as? String
//
//            if lblQuestionText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
//                var q = ""
//                if question.contains("src=") {
//                    q = (question.replacingOccurrences(of: "src=\"/", with: "src=\"\(contenturl ?? "")/"))
//                }
////                lblQuestionText.setHTML(html:  "<h2>\(q)</h2>")
////                if (q).contains("&#"){
////                    lblQuestionText.setHTML(html:  "<h2>\(q)</h2>")
////                }else{
//                    lblQuestionText.attributedText = "<h2>\(q)</h2>".html2AttributedString
////                }
//                lblQuestionText.font = UIFont(name: "Helvetica Neue", size: 18)
//            }else
//            {
//                var q = ""
//                if question.contains("src=")
//                {
//                    q = (question.replacingOccurrences(of: "src=\"/", with: "src=\"\(contenturl ?? "")/"))
////                    if (q).contains("&#"){
////                        lblQuestionText.setHTML(html:  "<h2>\(q)</h2>")
////                    }else{
//                        lblQuestionText.attributedText = "<h2>\(q)</h2>".html2AttributedString
////                    }
//                    lblQuestionText.font = UIFont(name: "Helvetica Neue", size: 18)
//                }
//
//            }
//
//           }
//           if data.yourAnswer == data.rightAnswer {
//               btnQuestionResult.setTitle("✓" ,for: .normal)
//               btnQuestionResult.backgroundColor = UIColor.green
//           }else if data.yourAnswer == kEmptyString {
//               btnQuestionResult.setTitle("–" ,for: .normal)
//               btnQuestionResult.backgroundColor = grayColor
//           }else if data.yourAnswer != data.rightAnswer {
//               btnQuestionResult.setTitle("✕" ,for: .normal)
//               btnQuestionResult.backgroundColor = redColor
//           }
//       }
       
    
    @IBAction func tapQustionResult(_ sender: UIButton)
        
    {
        
    }
}

//extension UILabel {
//    func setHTML(html: String) {
//        do {
//            let option = [NSAttributedString.DocumentReadingOptionKey(rawValue: NSAttributedString.DocumentAttributeKey.documentType.rawValue): NSAttributedString.DocumentType.html] as [NSAttributedString.DocumentReadingOptionKey : Any]
//            let attributedString: NSAttributedString = try NSAttributedString(data: html.data(using: .utf8)!, options:option , documentAttributes: nil)
//            self.attributedText = attributedString
//        } catch {
//            self.text = html
//        }
//    }
//}

