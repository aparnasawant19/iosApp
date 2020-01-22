//
//  LoginViewController.swift
//  client
//
//  Created by admin on 21/01/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import  Alamofire

class LoginViewController: BaseViewController{

    @IBOutlet weak var editEmail: UITextField!
    @IBOutlet weak var editPasword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onLogin() {
        if editEmail.text!.count == 0 {
                       showError(message: "Email is mandatory")
                   } else if editPasword.text!.count == 0 {
                       showError(message: "Password is mandatory")
                   } else {
                       print(editEmail.text!)
                       let body = [
                           "email": editEmail.text!,
                           "password": editPasword.text!
                       ]
                       
                       let url = "http://172.18.4.95:4000/user/login"
                       AF.request(url, method: .post, parameters: body,encoding: JSONEncoding())
                           .responseJSON(completionHandler: { response in
                                   let result = response.value as! [String: Any]
                                               let status = result["status"] as! String
                               print("\(result)")
                               
                               if status == "success" {

                                   let data = result["data"] as! [String: Any]
                                   let id = data["uid"] as! Int
                                   let name = data["uname"] as! String

                                   // persist the userId in user defaults
                                   let userDefaults = UserDefaults.standard
                                   userDefaults.setValue(id, forKey: "uid")
                                   userDefaults.setValue(name, forKey: "uname")
                                   userDefaults.synchronize()

                                   let Post_adViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "Post_adViewController")
                                   self.navigationController?.pushViewController(Post_adViewController, animated: true)

                               } else {
                                   self.showError(message: "Invalid email or pasword")
                              }
                           })
                   }
               }
    }
    
    


