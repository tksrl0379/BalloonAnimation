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
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        imageView.center = self.view.center
        imageView.center.y = self.view.center.y + 200
        imageView.image = #imageLiteral(resourceName: "star.png")
        self.view.addSubview(imageView)
            
        let balloon = Balloon(imageView: imageView)
        
        balloon.animate(fromPoint: sender.layer.position, toPoint: CGPoint(x: sender.layer.position.x, y: sender.layer.position.y - 500))
    }
    
}

