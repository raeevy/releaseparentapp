//
//  MCQScoreDetailVC.swift
//  Parent EdConnect
//
//  Created by Qamar Mansuri on 7/2/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import UIKit
import Alamofire

class MCQScoreDetailVC: UIViewController {

    @IBOutlet weak var imgErrow: UIImageView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var imgCorrect: UIButton!
    @IBOutlet weak var imgWrong: UIButton!
    @IBOutlet weak var imgSkipped: UIButton!
    @IBOutlet weak var btnWrongShow: UIButton!
    @IBOutlet weak var btnCorrectShow: UIButton!
    @IBOutlet weak var btnSkippedShow: UIButton!
    @IBOutlet weak var listTableView: UITableView! {
        
        didSet {
            self.listTableView.dataSource = self
            self.listTableView.delegate = self
        }
    }
    
    
//     var testID:String?
//     var userID:String?
//     var paperType:String?
    
    var isCommingFrom:String?
    var testID = "2"
    var userID = UserDefaults.standard.value(forKey: "USERID")
    var paperType = "Weekly Test"
    
    
    var paperName:String?
    var paperType2:String?
    var subjectTestName:String?
    var subjectName:String?
    var rightCount:String?
    var skipCount:String?
    var wrongCount:String?
    
 
    
    ///MARK:- View Life Cycle .
    override func viewDidLoad() {
        super.viewDidLoad()
        self.worksheetApi()
        
        if isCommingFrom == "Azeem"{
            
        }
        
        self.StatusBarSetup()
         listTableView.register(UINib.init(nibName: "McqScoreCell", bundle: nil), forCellReuseIdentifier: "mcqScore")
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    ///Mark:-Status Bar Change
      override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.imgWrong.layer.cornerRadius = 10
        self.imgCorrect.layer.cornerRadius = 10
        self.imgSkipped.layer.cornerRadius = 10
    }
    
    

    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

 //MARK: UITableView Delegate and UItableView DataSource
extension MCQScoreDetailVC : UITableViewDataSource,UITableViewDelegate {
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         
          return 5
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let mcqCell:McqScoreCell = tableView.dequeueReusableCell(withIdentifier:"mcqScore", for: indexPath) as! McqScoreCell
          
        
        
         return mcqCell
      }
      
}


extension MCQScoreDetailVC {
    
    func worksheetApi() {
        var action = "get_assignment_repor"
        var studentType = "2"
        var apiKey = "8FF8508F917BCC12FFDCD"
        var salt = "EF6C40ECBA"

        
        var checkSum =  "\(testID):\(userID):\(studentType):\(action):\(paperType):\(salt):\(apiKey)"
        var uparcaseChecksum = checkSum.uppercased()
        let myChecksum = MD5(uparcaseChecksum)


        let postData = [
            "weeklytest_Id":"4040",
            "user_id":"14078602",
           "student_type":"2",
            "action":"question_wise_analysis",
            "paper_type":"10",
            "checksum":"3ec09dcb93fa8717de30fe28d02362d9"
            ] as [String : Any]

        let headers: HTTPHeaders = [
            "accept": "application/json",
            "content-type": "application/json",
        ]

        print("the chceksum String", checkSum)
        print("uparcaseChecksum is",uparcaseChecksum)
        print("converted chceksum MD5 value ", myChecksum!)
        print("postData is",postData)

        if Reachability.isConnectedToNetwork() {
           showActivityIndicator()
            AF.request("http://lmstest.emscc.extramarks.com/school_lms/public/api/v1.0/weeklyv2", method: .post, parameters: postData, encoding: JSONEncoding.default, headers: headers)
                .responseJSON { (response) in
                    switch response.result {
                    case .success:
                        if let JSON = response.value as? [String: Any]  {
                            self.hideActivityIndicator()
                            print("THE JSON RESULT",JSON)
                            
                            self.paperName = JSON["paper_name"] as? String ?? ""
                            self.paperType2 = JSON["paper_type"] as? String ?? ""
                            self.subjectTestName = JSON["subject_test_name"] as? String ?? ""
                            self.subjectName = JSON["subject_name"] as? String ?? ""
                            self.rightCount = JSON["right_count"] as? String ?? ""
                            self.skipCount = JSON["skip_count"] as? String ?? ""
                            self.wrongCount = JSON["wrong_count"] as? String ?? ""
                            
                            print("paperName is",self.paperName ?? "")
                           
                            


                            self.listTableView.reloadData()

                        }
                    case .failure(let error):
                       self.hideActivityIndicator()
                        print("ERROR", error.localizedDescription)
                        self.alert(message: error.localizedDescription)
            }
          }
        }
        else {
            self.hideActivityIndicator()
            alert(message: "No Internet Connection!!")
        }
    }
}

