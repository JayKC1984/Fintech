//
//  ThirdVController.swift
//  Fintech
//
//  Created by User on 2022/3/22.
//

import UIKit

class ThirdVController: UIViewController {

    @IBOutlet weak var icProcess: UIActivityIndicatorView!
    @IBOutlet weak var txtDate: UILabel!
    @IBOutlet weak var imgPic: UIImageView!
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var txtCopyRight: UILabel!
    @IBOutlet weak var txtContent: UILabel!
    
    var NASADetail : DataCodable.Data?
    var y = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        loadData()
    }
    
    func setUI(){
        if (UIApplication.shared.keyWindow?.safeAreaInsets.bottom)! > 0.0 {
            y = 44
        }
        
        let navBar:UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: y, width: Int(UIScreen.main.bounds.width) , height: 80))
        self.view.addSubview( navBar )
        let navItem = UINavigationItem()
        let back = UIBarButtonItem(title: "Back", style: .plain , target: nil, action: #selector(goBack))
        navItem.leftBarButtonItem = back
        navBar.setItems([navItem], animated: false)
        icProcess.startAnimating()
    }
    
    @objc func goBack(){
        DispatchQueue.main.async {
            self.dismiss(animated: false)
            {

            }
        }
    }
    
    func loadData(){
        DispatchQueue.main.async { [self] in
            txtDate.text = dateFormate(date: (NASADetail?.date)! )
            txtTitle.text = NASADetail?.title
            txtCopyRight.text = NASADetail?.copyright
            txtContent.text = NASADetail?.description
            
            loadImage( url: URL(string: (NASADetail?.hdurl)!)! )

        }
    }
    
    func loadImage(url:URL)
    {
        DispatchQueue.main.async {
            HttpManager.shared.loadPic(url: url)
            { data in
                DispatchQueue.main.async {
                    self.imgPic.image = UIImage(data: data)
                    self.icProcess.isHidden = true
                }
            }
        }
    }
    
    func dateFormate(date:String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let showDate = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "yyyy MMM. dd"
        return dateFormatter.string(from: showDate!)
    }
}

