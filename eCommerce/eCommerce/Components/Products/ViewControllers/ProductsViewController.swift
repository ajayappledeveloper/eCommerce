//
//  ViewController.swift
//  eCommerce
//
//  Created by Ajay Babu Singineedi on 22/04/22.
//

import UIKit

class ProductsViewController: UIViewController {
    
    var productViewModel: ProductViewModel!
    
    private lazy var spinner: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.center = self.view.center
        return view
    }()
    
    lazy var storeHeaderView: StoreHeaderView = {
        let view = StoreHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var productsTableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(ProductCell.self, forCellReuseIdentifier: ProductCell.reuseIdentifier)
        view.dataSource = self
        view.estimatedRowHeight = 80
        view.rowHeight = UITableView.automaticDimension
        view.tableHeaderView = storeHeaderView
        return view
    }()
    
    private lazy var orderButton: UIButton = {
        let view = UIButton(type: .custom)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.backgroundColor = .systemRed
        view.setTitle(StringConstants.Products.orderButtonTitle, for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        view.isEnabled = false
        view.isHidden = true
        view.alpha = 0.4
        view.addTarget(self, action: #selector(orderButtonTapped), for: .touchUpInside)
        return view
    }()
    
    
    init(viewModel: ProductViewModel) {
        self.productViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        configureSubViews()
        spinner.startAnimating()
        
        fetchStoreInfo()
        fetchProductsList()
        
        NotificationCenter.default.addObserver(self, selector: #selector(clearCart), name: Notification.Name.OrderPlacedWithSuccess, object: nil)
    }
    
    
    
    func configureSubViews() {
        view.addSubview(spinner)
        view.addSubview(productsTableView)
        view.addSubview(orderButton)
        
        productsTableView.constraintsToFit(superview: view, insets: UIEdgeInsets(top: 0, left: 0, bottom: -50, right: 0))
        
        NSLayoutConstraint.activate([
            orderButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            orderButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
            orderButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            orderButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        view.bringSubviewToFront(spinner)
    }
    
    func configureAppearance() {
        view.backgroundColor = .white
        title = StringConstants.Products.navBarTitie
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func fetchProductsList() {
        productViewModel.fetchProductList {[weak self] isSuccess in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                if isSuccess {
                    self.productsTableView.reloadData()
                    self.orderButton.isHidden = false
                    self.spinner.stopAnimating()
                }
            }
        }
    }
    
    func fetchStoreInfo() {
        productViewModel.fetchStoreInfo {[weak self] isSuccess in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                if isSuccess {
                    self.storeHeaderView.updateUI(model: self.productViewModel.storeInfo)
                }
            }
        }
    }
    
    func addToCart(item: Product) {
        if productViewModel.isItemAddedBefore(item: item) {
            self.displayAlert(title: StringConstants.Products.Alerts.itemPresentInCartTitle, message: StringConstants.Products.Alerts.itemPresentInCartMessage, cancelHandler: {
            }, okHandler: {
                self.productViewModel.addToCart(item: item)
            }, okTitle: StringConstants.Products.Alerts.add)
        } else {
            productViewModel.addToCart(item: item)
            self.displayAlert(title: StringConstants.Products.Alerts.itemAddedToCartTitle, message: "\(item.title) \(StringConstants.Products.Alerts.itemAddedToCartMessage)", cancelHandler: nil) {
                
            }
        }
        
        updateOrderButton()
    }
    
    func updateOrderButton() {
        if !productViewModel.cartItems.isEmpty {
            orderButton.isEnabled = true
            orderButton.alpha = 1
        } else {
            orderButton.isEnabled = false
            orderButton.alpha = 0.4
        }
    }
    
    func displayAlert(title: String, message: String, cancelHandler: (()-> Void)?, okHandler: @escaping () -> Void, okTitle: String = StringConstants.Products.Alerts.ok) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: okTitle, style: .default) { _ in
            okHandler()
        }
        let cancel = UIAlertAction(title: StringConstants.Products.Alerts.cancel, style: .default) { _ in
            cancelHandler?()
        }
        alertController.addAction(ok)
        
        if let _ = cancelHandler {
            alertController.addAction(cancel)
        }
        
        self.present(alertController, animated: true)
    }
    
    @objc func orderButtonTapped() {
        let orderSummaryVM = OrderSummaryViewModel(productsOrder: productViewModel.getOrderProducts(), dataProvider: LocalDataProvider())
        let orderSummaryVC = OrderSummaryViewController(viewModel: orderSummaryVM)
        self.navigationController?.pushViewController(orderSummaryVC, animated: true)
    }
    
    @objc func clearCart() {
        productViewModel.clearCart()
        updateOrderButton()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name.OrderPlacedWithSuccess, object: nil)
    }
}

extension ProductsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productViewModel.totalProducts
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.reuseIdentifier) as? ProductCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        let product = productViewModel.getProduct(for: indexPath.row)
        cell.configureCell(product: product)
        cell.addToCardHandler = {
            if let product = product  {
                self.addToCart(item: product)
            }
        }
        
        return cell
    }
}

extension ProductsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
