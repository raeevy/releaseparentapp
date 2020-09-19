//
//  constant.swift
//  Parent EdConnect
//
//  Created by Work on 05/07/20.
//  Copyright © 2020 BlueAppleTechnologiesPvtLtd. All rights reserved.
//

import Foundation
import UIKit

//let APIKey = "D842D0CFEFF072775AC880CC6"
//let APPDELEGATE = UIApplication.shared.delegate as! AppDelegate
import UIKit
import Foundation



/*For Emstage Server:
DOMAIN_NAME = "http://emstage.extramarks.com/";
WEEKLY_TEST_URL_V2 = "http://stagelearning.extramarks.com/school_lms/public/api/v1.0/weeklyv2";
 
Api Key and Salt for Emstage Server
apiKey = 8FF8508F917BCC12FFDCD
Salt = EF6C40ECBA*/


//*** BaseULR And ApiKey and Salt For Developer Server ***
//let baseUrl = "http://developer.extramarks.com/"
//let apikeyMain = "8FF8508F917BCC12FFDCD"
//let saltMain = "EF6C40ECBA"


//*** BaseULR And ApiKey and Salt For Emstage Server ***
let baseUrl = "http://emstage.extramarks.com/api/"
let apikeyMain = "0DEAD50C6BBA59FF22D33C994"
let saltMain = "p@rentapp$android@!2019"



//*** BaseULR And ApiKey and Salt For LMS Server ***
//*** Note: to all LMS server first convert chceksum string into upar case then convert into MD5
let baseUrlLMS = "http://stagelearning.extramarks.com/school_lms/public/"
let apikeyMainLMS = "8FF8508F917BCC12FFDCD"
let saltMainLMS = "EF6C40ECBA"


// API KEYS
var Saltj = "p@rentapp$ios@!2019"
var apiKeyj = "8DDAD308E555C2AA38BFF8DBE"

//MARK: Api String
let LANGUAGEID = "LanguageID"
let LANGUAGEPATH = "LanguagePath"
let DEVICE_TYPE = UIDevice.current.userInterfaceIdiom
let APPNAMEOBJ  = "Learning App"
let IPADDRESS = "IP_address"
let AppId = "1232323918"
let Salt = "ios#essa$2017"

//Create My Test
let Salt2 = "36384A9EA3"
let APIKey2 = "BEBB2FDD4A9A7205"

let APIKey = "D842D0CFEFF072775AC880CC6"
let AdaptiveSalt = "Qmn5s)d%S@oDZ%EEdCXdSjQWDkPeJOje56WG0v4!"
let onBoardingVideoUrl = "http://developer.extramarks.com/uploads/onboarding/onboarding.mp4"

let developmentServer = "http://developer.extramarks.com/api/"
let liveServer = "http://www.extramarks.com/api/"
let testServer = "http://test-www.extramarks.com/api/"

let devweeklyImgUrl = "http://test.emscc.extramarks.com"
let liveweeklyImgUrl = "http://emscc.extramarks.com"
let testweeklyImgUrl = "http://test-www.extramarks.com"
let localImgUrl = "http://emstage.extramarks.com"
let amazonDevSever = "https://mvdgpk6a8l.execute-api.ap-south-1.amazonaws.com/getstagingdata"
let amazonProductionSever = "https://8n60k32bve.execute-api.ap-south-1.amazonaws.com/getdata"

let emsscBetaURL  = "http://stagelearning.extramarks.com/school_lms/public/api/v1.0/"
let emsscDevURL   = "http://lmstest.emscc.extramarks.com/school_lms/public/api/v1.0/"
let emsscLiveURL  = "http://learning.extramarks.com/school_lms/public/api/v1.0/"
let localServer = "http://emstage.extramarks.com/api/"
let calenderDevUrl  = "http://dev-sma.extramarks.com/webview/calender/lead/"
let calenderLiveUrl = "http://oms.extramarks.com/webview/calender/lead/"
var GoogleApiKey = "AIzaSyBGTr38YlHprVugeISDekZtYW0GcuWTEo0"
let SchoolAtHomeURL = "https://www.extramarks.com/school-at-home"
let SchoolAtHomeUpcomingSeriesURL = "https://www.extramarks.com/school-at-home-live-sessions"

let GTSBuypackageHeader  = "Extramarks"
let GtsBuyPackgeMessage  = "Explore more features and learning options.Visit https://www.extramarks.com and subscribe to your favourite package."
var isGTsUser  = false

//Add By Saurabh For Temp, lease remove after weekly working fine
let emsscTempLiveURL = "http://stagelearning2.extramarks.com"
//TODO:Comment/Uncomment to Dev Server
//Development
//var currentServer = developmentServer
//let ImgweeklyUrl  = devweeklyImgUrl
//var emssBaseURL   = emsscDevURL
//let wssSocketUrl  = "wss://dmadwwk1i4.execute-api.us-east-1.amazonaws.com/beta"
//let calenderUrl   = calenderDevUrl
//var irtUrl = "http://irt.extramarks.com/calculateAbility"

//// amazonDev
var currentServer = amazonDevSever
let ImgweeklyUrl  = devweeklyImgUrl
var emssBaseURL   = emsscDevURL
let wssSocketUrl  = "wss://dmadwwk1i4.execute-api.us-east-1.amazonaws.com/beta"
let calenderUrl   = calenderDevUrl
var irtUrl = "http://irt.extramarks.com/calculateAbility"


// Weekly test
let student_type  = "2"
let paper_type  = "10"
let Salt1 = "EF6C40ECBA"
let APIKey1 = "8FF8508F917BCC12FFDCD"
let grediantColor1                                     = UIColor.init(named: "#dbcf3e")
let grediantColor2                                     = UIColor.init(named: "#204197")
var weelyTestTimeWindowSize = 1800
var weelyTestAnalysisReporyEndTimeDelaySize = 0


//let kNavigationBarColor = UIColor(hex: 0x3E7CCC)
let statusBarColor = (UIColor.init(red: 37.0/255.0, green: 80.0/255.0, blue: 156.0/255.0, alpha: 1))
let skyBlueColor = (UIColor.init(red: 12.0/255.0, green: 34.0/255.0, blue: 213.0/255.0, alpha: 1)) // 0C22D5

let skyBlueColor2 = (UIColor.init(red: 85.0/255.0, green: 119.0/255.0, blue: 255.0/255.0, alpha: 1)) // 0C22D5

let lightGreen = (UIColor.init(red: 179.0/255.0, green: 224.0/255.0, blue: 226.0/255.0, alpha: 1)) 


let voiletColor = (UIColor.init(red: 83.0/255.0, green: 160.0/255.0, blue: 252.0/255.0, alpha: 1))
let blueColor = (UIColor.init(red: 0.0/255.0, green: 51.0/255.0, blue: 101.0/255.0, alpha: 1))
let QuestionAttemptedColorChall = UIColor.init(red: 106/255, green: 215/255, blue: 76/255, alpha: 0.9)//UIColor(hex: 0xC47207)
let QuestionActiveColorChall = UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)//UIColor(hex: 0x0A9AAD)
let QuestionSkippedColorChall = UIColor.init(red: 250/255, green: 64/255, blue: 72/255, alpha: 0.9)//UIColor(hex: 0xA9BBC6)

let redColor = UIColor(named: "#DE6A73")
let greenColor = UIColor(named: "#80DCAB")
let grayColor = UIColor(named: "#979797")
let whiteColor = UIColor(named: "#FFFFFF")
let darkGreenColor = UIColor(named: "#44D605")
//let QuestionMarkForRevieColor = UIColor(hex: 0x3a356e)//UIColor(hex: 0xA9BBC6)
let navyBlueColor  = UIColor.init(red: 45/255, green: 100/255, blue: 195/255, alpha: 1.0)
let orangeColor  = UIColor.init(red: 255/255, green: 180/255, blue: 14/255, alpha: 1.0)
let partialGreenColor = UIColor(named: "#64BF92")
let lightBlueColor = UIColor(named: "#5199F6")
let darkBlueColor = UIColor(named: "#1634CE")
let darkPinkColor  = UIColor.init(red: 251/255, green: 72/255, blue: 80/255, alpha: 1.0)
let lightPinkColor  = UIColor.init(red: 252/255, green: 131/255, blue: 84/255, alpha: 1.0)

//let QuestionAttemptedColor = UIColor(hex: 0xC47207)
//let QuestionActiveColor = UIColor(hex: 0x0A9AAD)
//let QuestionSkippedColor = UIColor(hex: 0xA9BBC6)

let APPDELEGATE = UIApplication.shared.delegate as! AppDelegate
let USER_PREF = UserDefaults.standard

let SCREEN_HEIGHT = UIScreen.main.bounds.height
let SCREEN_WIDTH = UIScreen.main.bounds.width
let IDIOM   =  UI_USER_INTERFACE_IDIOM()
let IS_IPAD =  UIUserInterfaceIdiom.pad
let IS_IPHONE = UIUserInterfaceIdiom.phone

// MARK: - Local Stored file name
let localizedStringFileName = "LanguageJson.txt"

// MARK: - App Name
var  kAppNameObj = "Learning App"

// MARK: - Alert
let kError = "Oops Something went wrong, please try again later"

// MARK: - Image
let placeholderImage = "EMLiveIcon.png"
let kProfileImage = "EMSSAUserProfilePic.jpg"
let KOldProfileImage = "OldEMSSAUserProfilePic.jpg"

let kEmptyString = ""
let charactersArray = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]

//MARK: Device Type
struct DeviceType
{    static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && SCREEN_HEIGHT < 568.0
    static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && SCREEN_HEIGHT == 568.0
    static let IS_IPHONE_6_7          = UIDevice.current.userInterfaceIdiom == .phone && SCREEN_HEIGHT == 667.0
    static let IS_IPHONE_6P_7P         = UIDevice.current.userInterfaceIdiom == .phone && SCREEN_HEIGHT == 736.0
    static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && SCREEN_HEIGHT == 1024.0
    static let IS_IPAD_PRO          = UIDevice.current.userInterfaceIdiom == .pad && SCREEN_HEIGHT == 1366.0
}

let ORIENTATION = UIApplication.shared.statusBarOrientation

//MARK: Completion Handler
typealias ActionHandler = (ActionType,Any)-> ()
enum ActionType : Int {
    /************************ used In Profile ***********************/
    case name                            = 0
    case school
    case birthday
    case gender
    case country
    case state
    case city
    case area
    case email
    case phoneNumber
    case password
    case retypePassword
    case back
    case connect
    case send
    case noUpdate
    case changeCountryCode
    case update
    /*********************** used In Profile ***************************/
    /*********************** used In DropDown ***************************/
    case logOut
    case settings
    /*********************** used In DropDown ***************************/
    /*********************** used In Reports ***************************/
    case shortSummary
    case sort
    case filter
    /*********************** used In Reports ***************************/
}

