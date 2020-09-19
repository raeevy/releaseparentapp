////
////  QuestionSelectionModel1.swift
////  Parent EdConnect
////
////  Created by Qamar Mansuri on 8/11/20.
////  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
////
//
//import Foundation
//
//class QuestionSelectionModel {
//    var weeklytestid: String?
//    var paperid: String?
//    var papertype: String?
//    var skipcount: String?
//    var papername: String?
//    var rightcount: String?
//    var subjecttestname: String?
//    var wrongcount: String?
//    var userid: String?
//    var questionwisedetail = [Question_wise_detail]()
//    var subjectname: String?
//
//    init(json: JSON) {
//        weeklytestid = json["weekly_test_id"].stringValue
//        paperid = json["paper_id"].stringValue
//        papertype = json["paper_type"].stringValue
//        skipcount = json["skip_count"].stringValue
//        papername = json["paper_name"].stringValue
//        rightcount = json["right_count"].stringValue
//        subjecttestname = json["subject_test_name"].stringValue
//        wrongcount = json["wrong_count"].stringValue
//        userid = json["user_id"].stringValue
//        questionwisedetail = json["question_wise_detail"].arrayValue.compactMap({ Question_wise_detail(json: $0)})
//        subjectname = json["subject_name"].stringValue
//    }
//}
//
//class Optiondata {
//    var teacherdesctext: String?
//    var rightoption: Right_option?
//    var attemptedoption: Attempted_option?
//    var attemptedtext: String?
//
//    init(json: JSON) {
//        teacherdesctext = json["teacher_desc_text"].stringValue
//        rightoption = Right_option(json: json["right_option"])
//        attemptedoption = Attempted_option(json: json["attempted_option"])
//        attemptedtext = json["attempted_text"].stringValue
//    }
//}
//
//class Attempted_option {
//    var optiontext: String?
//    var optionid: String?
//    var order: String?
//
//    init(json: JSON) {
//        optiontext = json["optiontext"].stringValue
//        optionid = json["optionid"].stringValue
//        order = json["order"].stringValue
//    }
//}
//
//class Right_option {
//    var optiontext: String?
//    var optionid: String?
//    var order: String?
//
//    init(json: JSON) {
//        optiontext = json["optiontext"].stringValue
//        optionid = json["optionid"].stringValue
//        order = json["order"].stringValue
//    }
//}
//
//class Question_wise_detail {
//    var explanatation: String?
//    var questionnumber: String?
//    var questionstatus: String?
//    var questionid: String?
//    var takentime: String?
//    var containername: String?
//    var containerid: String?
//    var markobtain: String?
//    var questionmarks: String?
//    var optiondata: Optiondata?
//    var questiontypemasterid: String?
//    var question: String?
//
//    init(json: JSON) {
//        explanatation = json["explanatation"].stringValue
//        questionnumber = json["question_number"].stringValue
//        questionstatus = json["question_status"].stringValue
//        questionid = json["question_id"].stringValue
//        takentime = json["taken_time"].stringValue
//        containername = json["container_name"].stringValue
//        containerid = json["container_id"].stringValue
//        markobtain = json["mark_obtain"].stringValue
//        questionmarks = json["question_marks"].stringValue
//        optiondata = Optiondata(json: json["optiondata"])
//        questiontypemasterid = json["question_type_master_id"].stringValue
//        question = json["question"].stringValue
//    }
//}
