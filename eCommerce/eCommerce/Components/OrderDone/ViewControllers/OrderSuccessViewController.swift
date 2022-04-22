//
//  OrderSuccessViewController.swift
//  eCommerce
//
//  Created by Ajay Babu Singineedi on 22/04/22.
//

import UIKit

class OrderSuccessViewController: UIViewController {
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView(image: UIImage(systemName: "hand.thumbsup.circle.fill"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.tintColor = .systemGreen
        view.heightAnchor.constraint(equalToConstant: 78).isActive = true
        view.widthAnchor.constraint(equalToConstant: 78).isActive = true
        return view
    }()
    
    lazy var messageLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.numberOfLines = 0
        view.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        view.text = StringConstants.OrderSuccess.successMessage
        return view
    }()
    
    private lazy var closeButton: UIButton = {
        let view = UIButton(type: .custom)
        view.setImage(UIImage(systemName: "xmark"), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        
        view.contentVerticalAlignment = .fill
        view.contentHorizontalAlignment = .fill

        
        view.heightAnchor.constraint(equalToConstant: 24).isActive = true
        view.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubViews()
        configureAppearance()
    }
  
    func configureSubViews() {
        self.view.addSubview(imageView)
        self.view.addSubview(messageLabel)
        self.view.addSubview(closeButton)
        
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        NSLayoutConstraint.activate([
            messageLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            messageLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
            messageLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            closeButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10)
        ])
    }
    
    func configureAppearance() {
        self.view.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    @objc func closeButtonTapped() {
        NotificationCenter.default.post(name: Notification.Name.OrderPlacedWithSuccess, object: nil)
        self.navigationController?.popToRootViewController(animated: true)
    }
}
 
