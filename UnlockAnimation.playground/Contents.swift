import UIKit
import PlaygroundSupport

let containerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 300, height: 300))

PlaygroundPage.current.liveView = containerView

let background = UIImageView(image: #imageLiteral(resourceName: "bg_banner.png"))
background.center = CGPoint(x: 0.5*containerView.bounds.size.width, y: 0.5*containerView.bounds.size.height)
containerView.addSubview(background)

// Circle

let wrapper = UIView(frame: CGRect(x: 0, y: 0, width: 70, height: 70))
wrapper.alpha = 0.75
wrapper.layer.cornerRadius = 36
wrapper.layer.masksToBounds = true
wrapper.center = CGPoint(x: 0.5*containerView.bounds.size.width, y: 0.5*containerView.bounds.size.height)
containerView.addSubview(wrapper)

let lockContainer = UIView(frame: wrapper.bounds)
wrapper.addSubview(lockContainer)

wrapper.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)

// Padlock

let lockArchViewContainer = UIView(frame: CGRect(x: -5, y: -20, width: lockContainer.frame.size.width + 10, height: 50))
lockArchViewContainer.clipsToBounds = true
lockContainer.addSubview(lockArchViewContainer)

let lockArchView = UIImageView(image: #imageLiteral(resourceName: "lock_arch@2x.png"))
lockArchView.layer.anchorPoint = CGPoint(x: 22.0/70.0, y: 50.0/75.0)
lockArchView.frame = CGRect(x: 0, y: 0, width: lockArchView.frame.size.width, height: lockArchView.frame.size.height)
lockArchViewContainer.addSubview(lockArchView)

let lockSquareView = UIImageView(image: #imageLiteral(resourceName: "lock_square@2x.png"))
lockSquareView.frame = CGRect(x: -5, y: lockContainer.frame.size.height - lockSquareView.frame.size.height + 10, width: lockSquareView.frame.size.width, height: lockSquareView.frame.size.height)
lockContainer.addSubview(lockSquareView)

containerView.transform = CGAffineTransform(scaleX: 2, y: 2)

// Control animation duration

let slowdown = 3.0

let initialDelay = 2.0

let unlockTranslateArchAnimationDuration = 0.15 * slowdown
let unlockTranslateSquareAnimationDuration = 0.2 * slowdown

let unlockClickAnimationDelay = 0.1 * slowdown + initialDelay
let unlockClickAnimationDuration = 0.1 * slowdown

let unlockUnlockAnimationDelay = 0.1 * slowdown
let unlockUnlockAnimationDuration = 0.15 * slowdown

let unlockRotationAnimationDelay = 0.1 * slowdown
let unlockRotationAnimationDuration = 0.2 * slowdown

let unlockClickDelay = 0.1 * slowdown + initialDelay
let unlockClickDuration = 0.1 * slowdown
let unlockLockUnlockDelay = 0.1 * slowdown
let unlockZoomOutAnimationDuration = unlockClickDelay + unlockClickDuration + unlockLockUnlockDelay - initialDelay

let unlockZoomInAnimationDelay = 0.05 * slowdown
let unlockZoomInAnimationDuration = 0.15 * slowdown

let unlockZoomInOutAnimationDelay = 0.0 * slowdown
let unlockZoomInOutAnimationDuration = 0.15 * slowdown

let unlockFadeOutAnimationDelay = 0.1 * slowdown
let unlockFadeOutAnimationDuration = 0.3 * slowdown



// Animate Unlock
UIView.animate(withDuration: unlockClickAnimationDuration, delay: unlockClickAnimationDelay, options: .beginFromCurrentState,
               animations: {
                lockArchView.transform = CGAffineTransform(rotationAngle: CGFloat(0.01 * Double.pi))
    },
               completion: { _ in
                UIView.animate(withDuration: unlockUnlockAnimationDuration, delay: unlockUnlockAnimationDelay, options: .beginFromCurrentState,
                               animations: {
                                lockArchView.transform = CGAffineTransform(rotationAngle: CGFloat(-0.17 * Double.pi))
                    }, completion: nil)

})

// Animate Lock Rotation

UIView.animate(withDuration: unlockClickDuration, delay: unlockClickDelay, options: .beginFromCurrentState,
               animations: {
                lockContainer.transform = CGAffineTransform(rotationAngle: CGFloat(0.05 * Double.pi)).translatedBy(x: 0, y: -2)
}) { _ in

    UIView.animate(withDuration: unlockRotationAnimationDuration, delay: unlockRotationAnimationDelay, options: .beginFromCurrentState,
                   animations: {
                    lockContainer.transform = CGAffineTransform(rotationAngle: CGFloat(-0.1 * Double.pi)).translatedBy(x: 0, y: 5)
        },
                   completion: nil)
}

UIView.animate(withDuration: unlockZoomOutAnimationDuration, delay: initialDelay, options: .curveLinear,
               animations: {
                wrapper.transform = CGAffineTransform(scaleX: 0.82, y: 0.82)
}) { _ in
    UIView.animate(withDuration: unlockZoomInAnimationDuration, delay: unlockZoomInAnimationDelay,
                   options: .curveLinear, animations: {
                    wrapper.transform = CGAffineTransform(scaleX: 1.22, y: 1.22)
        }, completion: { _ in

            UIView.animate(withDuration: unlockZoomInOutAnimationDuration, delay: unlockZoomInOutAnimationDelay, options: .curveLinear, animations: {
                wrapper.transform = CGAffineTransform(scaleX: 1.12, y: 1.12)
                }, completion: { _ in

                    UIView.animate(withDuration: unlockFadeOutAnimationDuration, delay: unlockFadeOutAnimationDelay, options: .curveLinear, animations: {
                        wrapper.alpha = 0
                        }, completion: nil)
            })
    })
}
