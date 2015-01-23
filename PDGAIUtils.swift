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
    class func sendView(view: String)
    {
        var tracker = GAI.sharedInstance().defaultTracker
        tracker.set(kGAIScreenName, value: view)
        tracker.send(GAIDictionaryBuilder.createAppView().build())
    }
   
}
