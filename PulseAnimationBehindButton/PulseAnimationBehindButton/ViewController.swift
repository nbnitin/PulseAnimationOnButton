//
//  ViewController.swift
//  pp
//
//  Created by Nitin Bhatia on 22/11/22.
//

import UIKit

class PulseAnimation: CALayer {

    var animationGroup = CAAnimationGroup()
    var animationDuration: TimeInterval = 1.5
    var radius: CGFloat = 0
    var numebrOfPulse: Float = Float.infinity
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(numberOfPulse: Float = Float.infinity, radius: CGFloat, postion: CGPoint,frame:CGSize){
        super.init()
        self.backgroundColor = UIColor.black.cgColor
        self.contentsScale = UIScreen.main.scale
        self.opacity = 0
        self.radius = 0
        self.numebrOfPulse = numberOfPulse
        
        self.bounds = CGRect(origin: postion, size: CGSize(width: frame.width * 1.5, height: 100))
       // self.bounds = CGRect(x: 0, y: 0, width: radius * 2, height: radius * 2)
        self.position = postion
        DispatchQueue.global(qos: .default).async {
            self.setupAnimationGroup()
            DispatchQueue.main.async {
                self.add(self.animationGroup, forKey: "pulse")
           }
        }
    }
    
    func scaleAnimation() -> CABasicAnimation {
        let scaleAnimaton = CABasicAnimation(keyPath: "transform.scale.xy")
        scaleAnimaton.fromValue = NSNumber(value: 0)
        scaleAnimaton.toValue = NSNumber(value: 1)
        scaleAnimaton.duration = animationDuration
        return scaleAnimaton
    }
    
    func createOpacityAnimation() -> CAKeyframeAnimation {
        let opacityAnimiation = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimiation.duration = animationDuration
        opacityAnimiation.values = [0.4,0.8,0]
        opacityAnimiation.keyTimes = [0,0.3,1]
        return opacityAnimiation
    }
    
    func setupAnimationGroup() {
        self.animationGroup.duration = animationDuration
        self.animationGroup.repeatCount = numebrOfPulse
        let defaultCurve = CAMediaTimingFunction(name: .easeOut)
        self.animationGroup.timingFunction = defaultCurve
        self.animationGroup.animations = [scaleAnimation(),createOpacityAnimation()]
    }
    
    
}


class ViewController: UIViewController {

    @IBOutlet weak var v: UIView!
    @IBOutlet weak var btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        let x = PulseAnimation(radius: 10, postion: self.btn.center,frame: btn.frame.size)
//            self.view.layer.insertSublayer(x, below: self.view.layer)
//            view.insertSubview(btn, aboveSubview: view)
        
        
        UIView.animate(withDuration: 1.4, delay: 0, animations: {
            UIView.modifyAnimations(withRepeatCount: 50, autoreverses: false, animations: {
                self.v.transform = .init(scaleX: 1.03, y: 1.3)
                self.v.alpha = 0
            })
            
        }, completion: {_ in
            self.v.transform = .identity
            self.v.alpha = 1
        })
    }


}

