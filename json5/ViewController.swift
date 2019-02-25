//
//  ViewController.swift
//  json5
//
//  Created by Mac on 25/02/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    var nameArray: [String] = [String]()
    var parentArray:[String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlstr = "https://api.myjson.com/bins/uv8ty"
        parsejson(urlString: urlstr)
    }

    func parsejson(urlString:String)
    {
        enum jsonError:String,Error
        {
            case responseError = "response not found"
            case dataerror = "data not found"
            case conversionEroor = "conversion Failed"
            
        }
        guard let endPoint = URL(string: urlString)
            else
        {
            print("end point not found")
            return
            
        }
        URLSession.shared.dataTask(with: endPoint) { (data , response, error)  in
            do
            {
                guard let response1 = response
                    else
                {
                    throw jsonError.responseError
                }
                print(response1)
                guard let data = data
                    else
                {
                    throw jsonError.dataerror
                }
                let firstDict: [String:Any] = try
                    JSONSerialization.jsonObject(with: data) as! [String:Any]
                let ResponseDic:[String:Any] = firstDict["RestResponse"] as! [String:Any]
                //print(ResponseDic)
                 let resultArray:[[String:Any]] = ResponseDic["result"] as! [[String:Any]]
                 //print(resultArray)
                for item2 in resultArray
                                    {
                                        let name:String = item2["name"] as! String
                                        self.parentArray.append(name)
                                        
                                        let alpha2_code:String = item2["alpha2_code"] as! String
                                        self.nameArray.append(alpha2_code)
                                        
                                    }
                print(self.parentArray)
                print(self.nameArray)
                
             
            }
            catch let error as jsonError
            {
                print(error.rawValue)
            }
            catch let error as NSError
            {
                print(error.localizedDescription)
            }
            }.resume()
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

