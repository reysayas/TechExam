//
//  ViewController.swift
//  TechnicalExam
//
//  Created by Klein Noctis on 10/30/20.
//  Copyright © 2020 Klein Noctis. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class ViewController: UIViewController {
    
    lazy var imgView:UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    lazy var qouteLbl:UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 5
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        /**
         *   Tasks
         *   1. Add a UIImageView and UILabel below it using autolayout
         *   2. Change the text to your favorite quote
         *   3. Set it to any image that best illustrate the quote provided
         *   4. Display this screen for 3 seconds and then using storyboard either with UINavigationController or any navigate to TaskViewController
         *
        **/
        
        setupUI()
        goToTaskViewController()
    }
    
    //MARK: Setup UI layout
    private func setupUI() {
        view.addSubview(imgView)
        view.addSubview(qouteLbl)
        
        qouteLbl.text = "If you live life by other people's standards, then your life is no longer yours."
        imgView.image = #imageLiteral(resourceName: "7676")
        
        [
            imgView.widthAnchor.constraint(equalToConstant: 100),
            imgView.heightAnchor.constraint(equalToConstant: 100),
            imgView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imgView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            
            qouteLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            qouteLbl.topAnchor.constraint(equalTo: imgView.bottomAnchor, constant: 10),
            qouteLbl.leadingAnchor.constraint(equalTo: imgView.leadingAnchor, constant: -50),
            qouteLbl.trailingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: 50)
        ].forEach({ $0.isActive = true })
    }

    //MARK: Countdown timer
    private func goToTaskViewController() {
        DispatchQueue.main.asyncAfter(deadline: .now()+3.0) {
            guard let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "rootNav") as? UINavigationController else { return }
            sb.modalPresentationStyle = .fullScreen
            sb.modalTransitionStyle = .crossDissolve
            
            self.present(sb, animated: true, completion: nil)
            
        }
    }
}

