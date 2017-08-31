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
        scrollView.delegate = self
        
        
        
        indicator = Indicator(frame: CGRect(x: scrollView.frame.size.width - 50, y: 0, width: 50, height: 50))
        scrollView.addSubview(indicator)
        indicator.backgroundColor = .black
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(dragging(sender:)))
        indicator.addGestureRecognizer(pan);
    }
    
    func dragging(sender:UIPanGestureRecognizer) {
        print(sender)
        switch sender.state {
        case .changed:
            let offset = sender.translation(in: indicator.superview!)
            indicator.center.y += offset.y
            sender.setTranslation(.zero, in: indicator.superview!)
        default:
            break;
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        guard scrollView.superview != nil else {
            return
        }
        
        let maxOffset = scrollView.contentSize.height - scrollView.frame.size.height
        let currentOffset = scrollView.contentOffset.y
        let offsetPercentage = currentOffset / maxOffset
        
        let maxIndicatorOffset = scrollView.frame.size.height - indicator.frame.height
        indicator.frame.origin.y = maxIndicatorOffset * offsetPercentage
        indicator.frame = scrollView.superview!.convert(indicator.frame, to: scrollView)
    }
}

