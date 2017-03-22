//
//  ViewController.swift
//  Clock
//
//  Created by Kenneth Debruyn on 6/03/17.
//  Copyright © 2017 kN3TT3R. All rights reserved.
//


import UIKit

class ViewController: UIViewController {
    
    
    
    // MARK: - IBOutlets
    @IBOutlet weak var displayLabel: UILabel!
    
    
    
    // MARK: - Properties
    var clock = Clock()
    var timer: Timer?
    
    
    
    // MARK: - Overridden Fucntions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
                WEAK REFERENCE
                    Instead of passing a strong reference to self in the initialisation of the timer object,
                    I’m going to pass a weak reference
         */
        weak var weakSelf = self
        timer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: weakSelf!,
            selector: #selector(weakSelf!.updateDisplaylabel),
            userInfo: nil,
            repeats: true
        )
        
        /*
                STRONG REFERENCE
                    The VC holds a strong reference to the Timer object
         */
        //         timer = Timer.scheduledTimer(
        //            timeInterval: 1.0, 
        //            target: self, 
        //            selector: #selector(ViewController.updateDisplaylabel), 
        //            userInfo: nil, 
        //            repeats: true
        //        )
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateDisplaylabel()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    /*
            SUPPORT ALL INTERFACE ORIENTATIONS
                -> add supportedInterfaceOrientations
                -> in the deployment target you will also have to check the upside down checkbox
    */
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        if UIDevice.current.orientation != .portrait {
            self.displayLabel.font = UIFont.systemFont(ofSize: 40.0)
        } else {
            self.displayLabel.font = UIFont.systemFont(ofSize: 20.0)
        }
    }
    
    /*
            Hide the status bar for this VC
    */
    //    override var prefersStatusBarHidden: Bool {
    //        return true
    //    }
    
    
    
    // MARK: - Functions
    func updateDisplaylabel() {
        
        // set initial String
        displayLabel.text = "Current time"
        
        //print(Locale.current)
        
        // create a formatter to work with date and time
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        let timeString = formatter.string(from: clock.currentDate as Date)
        displayLabel.text = String(describing: timeString)
        
        print(clock.currentDate)
        print(timeString)
    }
    
    deinit {
        if let timer = self.timer {
            timer.invalidate()
        }
    }
    
}


