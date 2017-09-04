
//
//  Drag.swift
//  DragScrollIndicator
//
//  Created by YangWeicheng on 04/09/2017.
//  Copyright © 2017 AO. All rights reserved.
//

import Foundation
import UIKit


private var isDraggingIndicatorKey:UInt8 = 0
private var indicatorKey:UInt8 = 0
private var showDragScrollIndicatorKey:UInt8 = 0
extension UIScrollView {
    var isDraggingIndicator:Bool {
        get {
            return objc_getAssociatedObject(self, &isDraggingIndicatorKey) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, &isDraggingIndicatorKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    var indicator:Indicator! {
        get {
            return objc_getAssociatedObject(self, &indicatorKey) as! Indicator
        }
        set {
            objc_setAssociatedObject(self, &indicatorKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func addDragScrollIndicator() {
        indicator = Indicator(frame: CGRect(x: self.frame.size.width - 50, y: 0, width: 50, height: 50))
        self.superview!.addSubview(indicator)
        indicator.backgroundColor = .black
        let pan = UIPanGestureRecognizer(target: self, action: #selector(dragging(sender:)))
        indicator.addGestureRecognizer(pan);
    }
    
    func dragging(sender:UIPanGestureRecognizer) {
        
        if sender.state == .began {
            isDraggingIndicator = true
        }
        
        if sender.state == .changed {
            let offset = sender.translation(in: indicator.superview!)
            indicator.center.y += offset.y
            sender.setTranslation(.zero, in: indicator.superview!)
            let currentOffsetY = indicator.frame.origin.y
            let maxOffsetY = self.frame.size.height - indicator.frame.height
            let offsetPercentage = currentOffsetY / maxOffsetY
            self.contentOffset.y = offsetPercentage * (self.contentSize.height - self.frame.size.height)
            
        }
        
        if sender.state == .ended {
            isDraggingIndicator = false
        }
        
    }
}

