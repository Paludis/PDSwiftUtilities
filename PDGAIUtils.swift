//
//  PDGAIUtils.swift
//  animeinterest
//
//  Created by Peter Denniss on 23/01/2015.
//  Copyright (c) 2015 Tattva Inc. All rights reserved.
//

import UIKit

class PDGAIUtils: NSObject
{
    class func sendView(view: String?)
    {
        if let viewString = view
        {
            var tracker = GAI.sharedInstance().defaultTracker
            tracker.set(kGAIScreenName, value: view)
            tracker.send(GAIDictionaryBuilder.createScreenView().build() as [NSObject : AnyObject])
        }
    }
    
    class func sendEvent(category: String, action: String, label: String?, value: NSNumber?)
    {
        GAI.sharedInstance().defaultTracker.send(GAIDictionaryBuilder.createEventWithCategory(category, action: action, label: label, value: value).build() as [NSObject : AnyObject])
    }
}