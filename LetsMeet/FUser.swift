//
//  FUser.swift
//  LetsMeet
//
//  Created by Mavin on 9/12/21.
//

import Foundation
import Firebase
import UIKit

class FUser: Equatable{
    static func == (lhs: FUser, rhs: FUser) -> Bool {
        lhs.objectId == rhs.objectId
    }
    
    let objectId   : String
    var email      : String
    var username   : String
    var dateofBirth: Date
    var isMale     : Bool
    var avartar    : UIImage?
    var profession : String
    var jobTitle   : String
    var about      : String
    var city       : String
    var country    : String
    var height     : Double
    var lookingFor : String
    var avatarLink : String
    
    var likedIdArray  : [String]?
    var ImageLinks    : [String]?
    let registeredDate = Date()
    var pushId        : String?
    
    var userDictionary : NSDictionary{
        return NSDictionary(objects: [
                                self.objectId,
                                self.email,
                                self.username,
                                self.dateofBirth,
                                self.isMale,
                                self.profession,
                                self.jobTitle,
                                self.about,
                                self.city,
                                self.country,
                                self.height,
                                self.lookingFor,
                                self.avatarLink,
                                self.likedIdArray ?? [],
                                self.ImageLinks ?? [],
                                self.registeredDate,
                                self.pushId ?? ""
                            ], forKeys: [
                                kOBJECTID as NSCopying,
                                kEMAIL as NSCopying,
                                kUSERNAME as NSCopying,
                                kDATEOFBIRTH as NSCopying,
                                kISMALE as NSCopying,
                                KPROFESSION as NSCopying,
                                kJOBTITLE as NSCopying,
                                kABOUT as NSCopying,
                                kCITY as NSCopying,
                                kCOUNTRY as NSCopying,
                                kHEIGHT as NSCopying,
                                kLOOKINGFOR as NSCopying,
                                kAVATARLINK as NSCopying,
                                kLIKEIDARRAY as NSCopying,
                                kIMAGELINKS as NSCopying,
                                kREGISTEREDDATE as NSCopying,
                                kPUSHID as NSCopying
                            ])
    }
    
    //MARK: - Inits
    init(_objectId: String, _email: String, _username: String,_city: String , _dateofBirth: Date, _isMale: Bool) {
        self.objectId    = _objectId
        self.email       = _email
        self.username    = _username
        self.dateofBirth = _dateofBirth
        self.isMale      = _isMale
        self.profession  = ""
        self.jobTitle    = ""
        self.about       = ""
        self.city        = _city
        self.country     = ""
        self.height      = 0.0
        self.lookingFor  = ""
        self.avatarLink  = ""
        self.likedIdArray = []
        self.ImageLinks   = []
    }
    
    //MARK: - LOGIN
    class func loginUserWith(email: String, password: String, completion: @escaping (_ error: Error?, _ isEmailVerified: Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authData, error in
         
            if error == nil {
                if authData!.user.isEmailVerified {
                    
                    
                    completion(error,true)
                }else{
                    print("Email not verified")
                    completion(error,false)
                }
            }else{
                completion(error,false)
            }
        }
    }
    
    
    //MARK: - Register
    class func registerUserWith(email: String, password: String, userName: String, city: String, isMale: Bool, dateOfBirth: Date, completion: @escaping (_ error: Error?)-> Void){
        
        print("Register Clicked")
        
        Auth.auth().createUser(withEmail: email, password: password) { (authData, error) in
            completion(error)
            if error == nil {
                
                authData!.user.sendEmailVerification { error in
                    if error != nil {
                        print("error",error!.localizedDescription)
                    }
                }
                
                //Save User to Database
                if authData?.user != nil {
                    let user = FUser(_objectId: authData!.user.uid, _email: email, _username: userName, _city: city, _dateofBirth: dateOfBirth, _isMale: isMale )
                
                }
                
                
            }
            
        }
    }
    
    func saveUserLocally(){
        userDefaults.setValue(self.userDictionary as! [String:Any], forKey: kCURRENTUSER)
        userDefaults.synchronize()
    }
}
