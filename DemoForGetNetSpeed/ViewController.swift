//
//  ViewController.swift
//  DemoForGetNetSpeed
//
//  Created by Vikram Singh on 8/9/18.
//  Copyright © 2018 Vikram Singh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnNetSpeedTest(_ sender: Any) {
         self.testSpeed()
    }
    //MARK:- Test NEt speed
    func testSpeed()  {
          let url = URL(string: "https://www.pixelstalk.net/wp-content/uploads/2016/07/3D-HD-Nature-Images-For-Desktop.jpg")
          let request = URLRequest(url: url!)
          let session = URLSession.shared
          let startTime = Date()
          let task =  session.dataTask(with: request) { (data, resp, error) in
            guard error == nil && data != nil else{
                print("connection error or data is nill")
                return
            }
            guard resp != nil else{
                
                print("respons is nill")
                return
            }
            let length  = CGFloat( (resp?.expectedContentLength)!) / 1000000.0
            print("length: \(length)")
            let elapsed = CGFloat( Date().timeIntervalSince(startTime))
            print("elapsed: \(elapsed)")
            print("Speed: \(length/elapsed) Mb/sec")
            let speed = length/elapsed
            let actual_speed = abs(speed)
            print("actual_speed: \(actual_speed) Mb/sec")// megabit
            
            
            if actual_speed > 4e-10 //0.05 mb = 4e-10 pitabit
            {
                let val1 = actual_speed*10000000
                let val = String(format:"%.4f", val1)
                self.ShowPopUp(strMSG: "Net Speed is:\(val)Mb/sec")
            }else if actual_speed < 4e-10
            {
                 let val1 = actual_speed*10000000
                 let val = String(format:"%.4f", val1)
                 self.ShowPopUp(strMSG: "Internet Speed is Poor,Speed is:\(val)Mb/sec")
            }
        }
        task.resume()
    }
    
    //MARK:- Show Speed
    func ShowPopUp(strMSG:String){
        let alertController = UIAlertController(title: "Internet Speed Testing", message: strMSG, preferredStyle: .alert)
        let yesPressed = UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.navigationController?.dismiss(animated: true, completion: {
            });
        })
        alertController.addAction(yesPressed)
               self.present(alertController, animated: true, completion: nil)
    }
}

