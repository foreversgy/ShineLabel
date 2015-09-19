//
//  ViewController.swift
//  ShineLabelDemo
//
//  Created by ShiMac on 15/9/14.
//  Copyright © 2015年 guoyan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let label=ShineLabel(frame: CGRectMake(0, 0, 300, 200))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        label.center=self.view.center
        label.setAttriubteText("For something this complicated, it’s really hard to design products by focus groups. A lot of times, people don’t know what they want until you show it to them.")
        label.numberOfLines=0
        label.font=UIFont(name: "HelveticaNeue-Light", size: 24.0)
        label.textColor=UIColor.orangeColor()
        label.sizeToFit()
        self.view.addSubview(label)
        
        
        let gesture=UITapGestureRecognizer(target: self, action: "Animation")
        self.view.addGestureRecognizer(gesture)
    }
    
    func Animation(){
        label.startAnimation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    
    
}

