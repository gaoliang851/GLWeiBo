//
//  Date+Extension.swift
//  GLWeiBo_Swift
//
//  Created by gaoliang on 2021/11/21.
//

import Foundation

extension Date {
    /// 比较self是否在other之后
    /// - Parameter other: other
    /// - Returns: isLater
    func isLaterThan(_ other :Date) -> Bool {
        let timeInterval = timeIntervalSince1970
        let otherTimeInterval = other.timeIntervalSince1970
        return timeInterval > otherTimeInterval
    }
    
    /// 比较self是否在other之前
    /// - Parameter other: other
    /// - Returns: isEarlier
    func isEarlierThan(_ other :Date) -> Bool {
        return !isLaterThan(other)
    }
}
