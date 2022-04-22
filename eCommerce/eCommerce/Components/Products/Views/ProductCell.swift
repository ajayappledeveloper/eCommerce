//
//  ProductCell.swift
//  eCommerce
//
//  Created by Ajay Babu Singineedi on 22/04/22.
//

import UIKit

class ProductCell: UITableViewCell {
    static let reuseIdentifier = String.init(describing: ProductCell.self)
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
        view.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
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
    
    private lazy var cartView: UIImageView = {
        let view = UIImageView(image: UIImage(systemName: "cart.fill.badge.plus"))
        view.tintColor = .systemOrange
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 24).isActive = true
        view.widthAnchor.constraint(equalToConstant: 24).isActive = true
        view.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(addToCartTapped))
        view.addGestureRecognizer(tapGesture)
        return view
    }()
    
    var addToCardHandler: () -> Void = {}
    
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
        self.contentView.addSubview(cartView)
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
            
            priceLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -50),
            priceLabel.widthAnchor.constraint(equalToConstant: 100),
            priceLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            priceLabel.heightAnchor.constraint(equalToConstant: 20),
            
            iconView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            iconView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            cartView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12),
            cartView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func configureCell(product: Product?) {
        guard let product = product else { return }
        titleLabel.text = "\(product.title)"
        subTitleLabel.text = product.detail
        priceLabel.text = "\(product.currency) \(product.price)"
        iconView.image = UIImage(systemName: product.image)
    }
    
    @objc func addToCartTapped() {
        addToCardHandler()
    }
    
}
