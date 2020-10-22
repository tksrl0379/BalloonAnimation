//
//  ViewController.swift
//  animation
//
//  Created by a1111 on 2020/10/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
  
    @IBAction func buttontouch(_ sender: UIButton) {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        imageView.center = sender.center
        imageView.image = #imageLiteral(resourceName: "star.png")
        self.view.addSubview(imageView)
        
        let balloon = Balloon(imageView: imageView)
        let randomX = CGFloat.random(in: -30...30)
        let randomY = CGFloat.random(in: 250...350)
        balloon.animate(fromPoint: sender.layer.position, toPoint: CGPoint(x: sender.layer.position.x + randomX, y: sender.layer.position.y - randomY))
    }
    
}

