//
//  PDSwiftUtilities.swift
//  animeinterest
//
//  Created by Peter Denniss on 5/12/2014.
//  Copyright (c) 2014 Peter Denniss All rights reserved.
//

import UIKit
import AudioToolbox
import Photos

var kSharedPDSwiftUtilities = PDSwiftUtilities()

class PDSwiftUtilities: NSObject
{
    var soundID: SystemSoundID = 0
    
    /// Get the size of the keyboard from a UIKeyboard notification
    class func kbSizeFromNotification(notification: NSNotification, view: UIView) -> CGSize
    {
        var kbSize: CGSize?
        
        if let info = notification.userInfo
        {
            if let keyboardFrame = info[UIKeyboardFrameEndUserInfoKey]?.CGRectValue
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
    
    func playSound(filename: String, fileType: String)
    {
        if let path = NSBundle.mainBundle().pathForResource(filename, ofType: fileType)
        {
            AudioServicesCreateSystemSoundID(NSURL(fileURLWithPath: path), &soundID)
            AudioServicesPlaySystemSound(soundID)
        }
    }
    
    class func getImageForAsset(asset: PHAsset) -> UIImage?
    {
        let manager = PHImageManager.defaultManager()
        let option = PHImageRequestOptions()
        var image: UIImage?
        option.synchronous = true
        manager.requestImageDataForAsset(asset, options: option, resultHandler: { (imageData, dataUTI, UIImageOrientation, info) -> Void in
            if let data = imageData
            {
                image = UIImage(data: data)
            }
        })
        return image
    }
    
    class func getImageForAsset(asset: PHAsset, targetSize: CGSize) -> UIImage
    {
        let manager = PHImageManager.defaultManager()
        let option = PHImageRequestOptions()
        var thumbnail = UIImage()
        option.synchronous = true
        manager.requestImageForAsset(asset, targetSize: targetSize, contentMode: .AspectFit, options: option, resultHandler: {(result, info)->Void in
            if let result = result
            {
                thumbnail = result
            }
        })
        return thumbnail
    }
    
    class func addViewsToScrollView(views: [UIView], scrollView: UIScrollView, itemPadding: CGFloat, leftMargin: CGFloat, rightMargin: CGFloat, topMargin: CGFloat, bottomMargin: CGFloat)
    {
        var lastView: UIView?
        for (index, view) in views.enumerate()
        {
            scrollView.addSubview(view)
            
            if let prevView = lastView
            {
                // align to trailing edge of previous image if there is a previous view
                scrollView.addConstraint(NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: prevView, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: itemPadding))
            }
            else
            {
                // align to leading edge of scroll view if the first view.
                scrollView.addConstraint(NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: scrollView, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: leftMargin))
            }
            
            // hug top and bottom of scroll view
            scrollView.addConstraint(NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: scrollView, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: topMargin))
            scrollView.addConstraint(NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: scrollView, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: bottomMargin))
            
            if index == views.count - 1
            {
                // last view, so add a trailing constraint to the right edge of scroll view
                scrollView.addConstraint(NSLayoutConstraint(item: view, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: scrollView, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: rightMargin))
            }
            
            lastView = view
        }
    }
    
}
