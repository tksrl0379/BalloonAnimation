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
        balloon.animate(fromPoint: sender.layer.position)
        //sender.layer.position(이건 layer) vs center(이건 uiview)
    }
    
}

