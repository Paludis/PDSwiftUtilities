//
//  PDSwiftUtilities.swift
//  animeinterest
//
//  Created by Peter Denniss on 5/12/2014.
//  Copyright (c) 2014 Peter Denniss All rights reserved.
//

import UIKit

class PDSwiftUtilities: NSObject
{
    
    /// Get the size of the keyboard from a UIKeyboard notification
    class func kbSizeFromNotification(notification: NSNotification, view: UIView) -> CGSize
    {
        var kbSize: CGSize?
        
        if let info = notification.userInfo
        {
            if let keyboardFrame = info[UIKeyboardFrameEndUserInfoKey]?.CGRectValue()
            {
                var convertedFrame = view.convertRect(keyboardFrame, fromView: view.window)
                kbSize = convertedFrame.size
            }
        }
        
        if kbSize != nil
        {
            return kbSize!
        }
        else
        {
            return CGSizeZero
        }
    }
    
    /// Convert number like 1000 to string like "1,000"
    class func numberStringWithCommas(number: NSNumber) -> String
    {
        return self.numberStringWithCommas(number, hideNegativeSymbol: false)
    }
    
    class func numberStringWithCommas(number: NSNumber, hideNegativeSymbol: Bool) -> String
    {
        var numberFormatter = NSNumberFormatter()
        numberFormatter.formatterBehavior = NSNumberFormatterBehavior.Behavior10_4
        numberFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        if hideNegativeSymbol
        {
            numberFormatter.negativePrefix = ""
        }
        
        if let string = numberFormatter.stringFromNumber(number)
        {
            return string
        }
        else
        {
            return ""
        }
    }
    
    class func convertButtonImageToTemplate(button: UIButton?)
    {
        if let originalImage = button?.imageForState(UIControlState.Normal)
        {
            let templateImage = originalImage.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            button?.setImage(templateImage, forState: UIControlState.Normal)
        }
    }
   
}
