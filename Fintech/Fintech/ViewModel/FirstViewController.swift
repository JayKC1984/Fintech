//
//  ViewController.swift
//  Fintech
//
//  Created by User on 2022/3/19.
//
import CoreFoundation
import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var btnNext: UIButton!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        btnNext.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)

    }

    @objc func buttonClicked(_ sender: AnyObject?) {
        if sender === btnNext {
            DispatchQueue.main.async {

                    let vc = SecondVController()
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                
            }
        }
    }
}

