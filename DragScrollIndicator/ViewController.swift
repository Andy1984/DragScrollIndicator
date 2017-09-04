//
//  ViewController.swift
//  DragScrollIndicator
//
//  Created by YangWeicheng on 24/08/2017.
//  Copyright © 2017 AO. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    var scrollView:UIScrollView!
    
    var indicator:Indicator!
    
    var isDraggingIndicator:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView = UIScrollView(frame: view.frame)
        view.addSubview(scrollView)
        
        let randomRGB:()->CGFloat = {
            return CGFloat(arc4random()%255)/255.0;
        }
        let h:CGFloat = 30
        let count = 1000
        for i in 0..<count {
            let colorViewFrame = CGRect(x: 0.0, y: CGFloat(i) * h, width: view.frame.width, height: h)
            let colorView = UIView(frame: colorViewFrame)
            colorView.backgroundColor = UIColor(red: randomRGB(), green: randomRGB(), blue: randomRGB(), alpha: 1)
            scrollView.addSubview(colorView)
        }
        scrollView.contentSize = CGSize(width: 0, height: CGFloat(count) * h)
        scrollView.addDragScrollIndicator()
        scrollView.delegate = self
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        NotificationCenter.default.post(Notification(name: DragScrollIndicatorDidScroll))
        NotificationCenter.default.post(name: DragScrollIndicatorDidScroll, object: self, userInfo: ["scrollView":scrollView])
    }
}

