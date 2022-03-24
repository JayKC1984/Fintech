//
//  SecondVController.swift
//  Fintech
//
//  Created by User on 2022/3/22.
//

import UIKit

class SecondVController: UIViewController {

    @IBOutlet weak var clView: UICollectionView!
    @IBOutlet weak var icProcess: UIActivityIndicatorView!
    
    var NASAData = [DataCodable.Data]()
    var y = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUI()
        loadData()
    }
    
    func setUI(){
        
        if (UIApplication.shared.keyWindow?.safeAreaInsets.bottom)! > 0.0 {
            print("safeAreaInsets")
            y = 44
        }
        
        clView.dataSource = self
        clView.delegate = self
        
        let nib = UINib(nibName: "NASACollectionViewCell", bundle: nil)
        self.clView.register(nib, forCellWithReuseIdentifier: "NASACollectionViewCell")
        
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
        DispatchQueue.main.async {
            let jsonService = JSONService()
            jsonService.fetchNASAData(url: jsonUrl)
            { (status, data, error) in
                self.NASAData = data
                self.reloadData()
            }
        }
    }
    
    func reloadData(){
        DispatchQueue.main.async {
            self.clView.reloadData()
            self.icProcess.isHidden = true
        }
    }
    
}




extension SecondVController:UICollectionViewDelegate,UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.NASAData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = clView.dequeueReusableCell(withReuseIdentifier: "NASACollectionViewCell", for: indexPath) as! NASACollectionViewCell
        cell.imgCell.image = nil
        cell.txtCell.text = NASAData[indexPath.row].title
        
        let url = URL(string: NASAData[indexPath.row].url!)!
        
        DispatchQueue.global().async {
            HttpManager.shared.loadPic(url: url)
            { data in
                DispatchQueue.main.async {
                    cell.imgCell.image = UIImage(data: data)
                }
            }
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DispatchQueue.main.async {
                var vc = ThirdVController()
                
                vc.NASADetail = self.NASAData[indexPath.row]
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)

            
        }
    }
}
