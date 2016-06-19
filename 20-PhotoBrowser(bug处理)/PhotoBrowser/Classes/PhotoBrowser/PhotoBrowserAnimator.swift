//
//  PhotoBrowserAnimator.swift
//  PhotoBrowser
//
//  Created by xmg on 16/1/15.
//  Copyright © 2016年 yyzx. All rights reserved.
//

import UIKit

protocol PresentedProtocol : class {
    func getImageView(indexPath : NSIndexPath) -> UIImageView
    func getStartRect(indexPath : NSIndexPath) -> CGRect
    func getEndRect(indexPath : NSIndexPath) -> CGRect
}

protocol DismissProtocol : class {
    func getImageView() -> UIImageView
    func getIndexPath() -> NSIndexPath
}


class PhotoBrowserAnimator: NSObject {
    var isPresented : Bool = false
    var indexPath : NSIndexPath?
    
    weak var presentedDelegate : PresentedProtocol?
    weak var dismissDelegate : DismissProtocol?
}

// MARK:- 实现photoBrowser的转场代理方法
extension PhotoBrowserAnimator : UIViewControllerTransitioningDelegate {
    // 告诉弹出的动画交给谁去处理
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        isPresented = true
        
        return self
    }
    
    // 告诉消失的动画交给谁去处理
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        isPresented = false
        
        return self
    }
}


// MARK:- 实现photoBrowser的转场的动画
extension PhotoBrowserAnimator : UIViewControllerAnimatedTransitioning {
    // 1.决定动画执行的时间
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 2.0
    }
    
    // 2.决定动画如何实现
    // transitionContext : 可以通过转场上下文去获取弹出的View和即将消失的View
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        if isPresented {
            // 0.nil值校验
            guard let indexPath = indexPath, presentedDelegate = presentedDelegate else {
                return
            }
            
            // 1.获取弹出的View
            let presentedView = transitionContext.viewForKey(UITransitionContextToViewKey)!
            
            // 3.执行动画
            // 3.1.获取执行动画的imageView
            let imageView = presentedDelegate.getImageView(indexPath)
            transitionContext.containerView()?.addSubview(imageView)
            
            // 3.2.设置imageView的起始位置
            imageView.frame = presentedDelegate.getStartRect(indexPath)
            
            // 3.3.执行动画
            transitionContext.containerView()?.backgroundColor = UIColor.blackColor()
            UIView.animateWithDuration(transitionDuration(transitionContext), animations: { () -> Void in
                imageView.frame = presentedDelegate.getEndRect(indexPath)
                }) { (_) -> Void in
                    // 2.将弹出的View添加到containerView中
                    transitionContext.containerView()?.addSubview(presentedView)
                    transitionContext.containerView()?.backgroundColor = UIColor.clearColor()
                    imageView.removeFromSuperview()
                    transitionContext.completeTransition(true)
            }
        } else {
            // 0.控制校验
            guard let dismissDelegate = dismissDelegate, presentedDelegate = presentedDelegate else {
                return
            }
            
            // 1.取出消失的View
            let dismissView = transitionContext.viewForKey(UITransitionContextFromViewKey)
            
            // 2.执行动画
            // 2.1.获取执行动画的imageView
            let imageView = dismissDelegate.getImageView()
            transitionContext.containerView()?.addSubview(imageView)
            
            // 2.2.取出indexPath
            let indexPath = dismissDelegate.getIndexPath()
            
            // 2.3.获取结束的位置
            let endRect = presentedDelegate.getStartRect(indexPath)
            
            dismissView?.alpha = endRect == CGRectZero ? 1.0 : 0.0
            
            // 2.4.执行动画
            UIView.animateWithDuration(transitionDuration(transitionContext), animations: { () -> Void in
                if endRect == CGRectZero {
                    imageView.removeFromSuperview()
                    dismissView?.alpha = 0.0
                } else {
                    imageView.frame = endRect
                }
                
                }, completion: { (_) -> Void in
                    
                    dismissView?.removeFromSuperview()
                    transitionContext.completeTransition(true)
            })
        }
    }
}

