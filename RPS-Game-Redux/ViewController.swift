//
//  ViewController.swift
//  RPS-Game-Redux
//
//  Created by Sameh Farouk on 7/16/19.
//  Copyright © 2019 Sameh Farouk. All rights reserved.
//

import UIKit
import ReSwift

class ViewController: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var borderView1: UIView!
    @IBOutlet weak var placeholderImageView1: UIImageView!
    @IBOutlet weak var borderView2: UIView!
    @IBOutlet weak var placeholderImageView2: UIImageView!
    @IBOutlet weak var rockButton: UIButton!
    @IBOutlet weak var paperButton: UIButton!
    @IBOutlet weak var scissorsButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        store.subscribe(self)
    }
    
    // MARK: - IBActions
    
    @IBAction func choosenAction(_ sender: UIButton) {
        if sender === rockButton {
            store.dispatch(ChooseWeaponAction(weapon: .rock))
        }
        else  if sender === paperButton {
            store.dispatch(ChooseWeaponAction(weapon: .paper))
        }
        else  if sender === scissorsButton {
            store.dispatch(ChooseWeaponAction(weapon: .scissors))
        }
    }
    
    @IBAction func restartAction(_ sender: Any) {
        store.dispatch(RestarWeaponAction())
    }
    
}

extension ViewController: StoreSubscriber {
    
    func newState(state: AppState) {
        
        messageLabel.text = state.message.rawValue
        
        if state.player2Play.chosen {
            borderView2.layer.removeAllAnimations()
            borderView2.layer.borderColor = UIColor.clear.cgColor
            placeholderImageView1.image = UIImage(named: "\(state.player1Play.weapon?.rawValue ?? "Chosen")")
            placeholderImageView2.image = UIImage(named:"\(state.player2Play.weapon?.rawValue ?? "Chosen")")
        } else {
            if state.player1Play.chosen {
                borderView1.layer.removeAllAnimations()
                borderView1.layer.borderColor = UIColor.clear.cgColor
                placeholderImageView1.image = UIImage(named:"Chosen")
                borderView2.layer.borderColor = UIColor.black.cgColor
                borderView2.animateBorderColor(toColor: UIColor.white, duration: 0.75)
            }
            else {
                borderView1.layer.borderColor = UIColor.black.cgColor
                borderView2.layer.removeAllAnimations()
                borderView2.layer.borderColor = UIColor.clear.cgColor
                borderView1.animateBorderColor(toColor: UIColor.white, duration: 0.75)
                placeholderImageView1.image = UIImage(named:"Choose")
            }
            placeholderImageView2.image =  UIImage(named:"Choose")
        }
    }
}

extension UIView {
    func animateBorderColor(toColor: UIColor, duration: Double) {
        let animation:CABasicAnimation = CABasicAnimation(keyPath: "borderColor")
        animation.fromValue = layer.borderColor
        animation.toValue = toColor.cgColor
        animation.duration = duration
        animation.repeatCount = 10000000
        layer.add(animation, forKey: "borderColor")
        layer.borderColor = toColor.cgColor
    }
}
