//
//  OrderSummaryCell.swift
//  eCommerce
//
//  Created by Ajay Babu Singineedi on 22/04/22.
//

import UIKit

class OrderSummaryCell: UITableViewCell {
    
    static let reuseIdentifier = String.init(describing: OrderSummaryCell.self)
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .left
        view.numberOfLines = 1
        view.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return view
    }()
    
    private lazy var priceLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .right
        view.numberOfLines = 1
        view.font = UIFont.systemFont(ofSize: 12, weight: .light)
        return view
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        view.textAlignment = .left
        view.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return view
    }()
    
    private lazy var iconView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 24).isActive = true
        view.widthAnchor.constraint(equalToConstant: 24).isActive = true
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureSubViews() {
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(subTitleLabel)
        self.contentView.addSubview(iconView)
        self.contentView.addSubview(priceLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: iconView.leftAnchor, constant: 40),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -40),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            subTitleLabel.leftAnchor.constraint(equalTo: iconView.leftAnchor, constant: 40),
            subTitleLabel.widthAnchor.constraint(equalToConstant: self.frame.width * 0.7),
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            subTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            priceLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            priceLabel.widthAnchor.constraint(equalToConstant: 100),
            priceLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            priceLabel.heightAnchor.constraint(equalToConstant: 20),
            
            iconView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            iconView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
    
    func configureCell(productOrder: (Product, Int)) {
        let product = productOrder.0
        let totalOrdered = productOrder.1
        titleLabel.text = "\(product.title)"
        subTitleLabel.text = product.detail
        if let price = Int(product.price) {
            priceLabel.text = " \(totalOrdered) Items - \(product.currency) \(price * totalOrdered)"
        }
        iconView.image = UIImage(systemName: product.image)
    }

    
}

