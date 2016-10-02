/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 */

import Foundation

/**
 Types that conform to the QueryItemRepresentable protocol must implement properties that allow it to be saved as a query item in a URL.
 */
protocol QueryItemRepresentable {
    /// The query item associated with whatever is implementing this protocol
    var queryItem: URLQueryItem { get }
    
    /// The key for the query item of whatever is implementing this protocol
    static var queryItemKey: String { get }
}
