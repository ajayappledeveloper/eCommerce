//
//  StoreHeaderView.swift
//  eCommerce
//
//  Created by Ajay Babu Singineedi on 22/04/22.
//

import UIKit

class StoreHeaderView: UIView {
    
    private lazy var vStack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var storeInfoStack: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.alignment = .leading
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.addArrangedSubview(storeNameLabel)
        view.addArrangedSubview(countryLabel)
        return view
    }()
    
    private lazy var userInfoStack: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.alignment = .leading
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.addArrangedSubview(nameLabel)
        view.addArrangedSubview(mobileLabel)
        return view
    }()
    
    private lazy var storeNameLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        view.widthAnchor.constraint(equalToConstant: 150).isActive = true
        return view
    }()
    
    private lazy var countryLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .right
        view.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        view.widthAnchor.constraint(equalToConstant: 150).isActive = true
        return view
    }()
    
    private lazy var mobileLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .right
        view.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return view
    }()
    
    var name: String? {
        return nameLabel.text
    }
    
    var mobile: String? {
        return mobileLabel.text
    }
    
    var country: String? {
        return countryLabel.text
    }
    
    var storeName: String? {
        return storeNameLabel.text
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureSubViews() {
        self.addSubview(vStack)
        
        vStack.addArrangedSubview(storeInfoStack)
        vStack.addArrangedSubview(userInfoStack)
        
        
        vStack.constraintsToFit(superview: self, insets: UIEdgeInsets(top: 5, left: 10, bottom: 0, right: 0))
        
        self.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    func updateUI(model: StoreInfo?) {
        guard let storeInfo = model else { return }
        storeNameLabel.text = storeInfo.storeName
        countryLabel.text = storeInfo.country
        nameLabel.text = "Hi \(storeInfo.user.name)!"
        mobileLabel.text = storeInfo.user.phone
    }
    
}
