//
//  ShineLabel.swift
//  ShineLabelDemo
//
//  Created by ShiMac on 15/9/14.
//  Copyright © 2015年 guoyan. All rights reserved.
//

import UIKit

class ShineLabel: UILabel {

    var shineDuration:CGFloat=2.5
    
    var displayLink:CADisplayLink!
    
    var chracterDuration=[CGFloat]()
    
    var chracterDelay=[CGFloat]()
    
    var attributeString:NSMutableAttributedString
    
    var isShow=false
    
    var beginTime=CACurrentMediaTime()
    
    var endTime=CACurrentMediaTime()
    
    override init(frame: CGRect) {
        
        attributeString=NSMutableAttributedString()
        super.init(frame: frame)
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAttriubteText(text:NSString){
        
        attributeString=NSMutableAttributedString(string: text as String)
        
        attributeString.addAttribute(NSForegroundColorAttributeName, value: self.textColor.colorWithAlphaComponent(0), range: NSMakeRange(0, attributeString.length))
        
        attributedText=attributeString
        
        for _ in 1 ... attributeString.length{
        
             let random = arc4random_uniform(UInt32(shineDuration*50.0))
            
            let delayFloat = CGFloat(random)/(100.0)
            
            chracterDelay.append(delayFloat)
            
            let remain = arc4random_uniform(UInt32(( self.shineDuration - delayFloat)*100.0))
            
            let remainFloat = CGFloat(remain)/100.0
            
            chracterDuration.append(remainFloat)
        }
        
        configure()
    }
    
    func configure(){
        
        displayLink=CADisplayLink(target: self, selector: "updateAttribute")
        displayLink.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
        displayLink.paused=true
    }
    
    func updateAttribute()->(){
        

        let nowTime=CACurrentMediaTime()
        
        for index in 1 ... attributeString.length{
            
            attributeString.enumerateAttribute(NSForegroundColorAttributeName, inRange: NSMakeRange(index-1, 1), options: NSAttributedStringEnumerationOptions.LongestEffectiveRangeNotRequired, usingBlock: { (value, range, objectbool) -> Void in
                
                if let color = value as? UIColor {
                    
                    let apla = CGColorGetAlpha(color.CGColor)
   
                    let shouldUpdateApla = (!self.isShow && apla < 1) || (CGFloat(nowTime - self.beginTime) > self.chracterDelay[index-1])
                    
                    if !shouldUpdateApla   {
                        return
                    }
                    
                    if (CGFloat(nowTime - self.beginTime) > (self.chracterDelay[index-1]) + self.chracterDuration[index-1] ){

                        //防止动画太长，出现文字折行动画
                        return
                    }
                    
                    let percent =  (CGFloat(nowTime - self.beginTime) - self.chracterDelay[index-1])/CGFloat(self.chracterDuration[index-1])
                    
                    let txtcolor = self.textColor.colorWithAlphaComponent(percent)
                    
                    self.attributeString.addAttribute(NSForegroundColorAttributeName, value: txtcolor, range: range)
                    
                }
                
            })
        }
        self.attributedText=self.attributeString
        if nowTime > self.endTime{
            self.isShow=true
            self.displayLink.paused=true
        }
    }
    
    func startAnimation(){
        
        self.isShow=false
        self.beginTime=CACurrentMediaTime()
        
        self.endTime=self.beginTime + CFTimeInterval(self.shineDuration)
        self.displayLink!.paused=false
    }
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
