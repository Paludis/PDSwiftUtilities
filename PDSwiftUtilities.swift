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
   
}
