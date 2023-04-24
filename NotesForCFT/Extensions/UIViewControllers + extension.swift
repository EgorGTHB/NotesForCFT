import UIKit

extension UIViewController {
  
  func hideKeyboardWhenTappedAround() {
    let tap = UITapGestureRecognizer(target: self, action: #selector(endEditing))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
  }
  
  @objc func endEditing() {
    view.endEditing(true)
  }
   
  func animateButton(sender: UIButton, scaleX: CGFloat, scaleY: CGFloat) {
    sender.transform = CGAffineTransform(scaleX: scaleX, y: scaleX)
    UIView.animate(withDuration: 1,
                     delay: 0,
                   usingSpringWithDamping: 0.3,
                     initialSpringVelocity: 6.0,
                     options: UIView.AnimationOptions.allowUserInteraction,
                     animations: {
        sender.transform = CGAffineTransform.identity
      })
  }
  
  func shadow(_ sender: UIView) {
    sender.layer.shadowColor = UIColor.black.cgColor;
    sender.layer.shadowOffset = CGSize(width: 1, height: 0.5)
    sender.layer.shadowOpacity = 0.4
    sender.layer.shadowRadius = 10
    sender.layer.masksToBounds = false
  }
}


 
