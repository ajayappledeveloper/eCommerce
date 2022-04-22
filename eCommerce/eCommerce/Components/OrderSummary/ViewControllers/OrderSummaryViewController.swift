//
//  OrderSummaryViewController.swift
//  eCommerce
//
//  Created by Ajay Babu Singineedi on 22/04/22.
//

import UIKit

class OrderSummaryViewController: UIViewController {
    
    var viewModel: OrderSummaryViewModel
    
    private lazy var spinner: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.center = self.view.center
        return view
    }()
    
    private lazy var productsTableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(OrderSummaryCell.self, forCellReuseIdentifier: OrderSummaryCell.reuseIdentifier)
        view.dataSource = self
        view.estimatedRowHeight = 80
        view.rowHeight = UITableView.automaticDimension
        
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(dismissKeyBoard))
        view.addGestureRecognizer(tapGesture)
        
        return view
    }()
    
    private lazy var addressTextField: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.keyboardType = .asciiCapable
        view.borderStyle = .roundedRect
        view.placeholder = StringConstants.OrderSummary.addresssPlaceholder
        view.delegate = self
        return view
    }()
    
    lazy var orderButton: UIButton = {
        let view = UIButton(type: .custom)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isEnabled = false
        view.alpha = 0.4
        view.layer.cornerRadius = 8
        view.backgroundColor = .systemOrange
        view.setTitle(StringConstants.OrderSummary.orderButtonTitle, for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        view.addTarget(self, action: #selector(confirmOrderTapped), for: .touchUpInside)
        return view
    }()
    
    init(viewModel: OrderSummaryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func dismissKeyBoard() {
        addressTextField.resignFirstResponder()
        updateOrderButton(address: addressTextField.text)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        configureSubViews()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func configureSubViews() {
        view.addSubview(productsTableView)
        view.addSubview(addressTextField)
        view.addSubview(orderButton)
        view.addSubview(spinner)
        
        productsTableView.constraintsToFit(superview: view, insets: UIEdgeInsets(top: 50, left: 0, bottom: -50, right: 0))
        
        NSLayoutConstraint.activate([
            addressTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            addressTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
            addressTextField.bottomAnchor.constraint(equalTo: orderButton.topAnchor, constant: -20),
            addressTextField.heightAnchor.constraint(equalToConstant: 50),
            
            orderButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            orderButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
            orderButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            orderButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configureAppearance() {
        self.title = StringConstants.OrderSummary.navBarTitie
        self.view.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @objc func confirmOrderTapped() {
        spinner.startAnimating()
        guard let address = addressTextField.text else { return }
        viewModel.placeOrder(address: address) { isSuccess in
            DispatchQueue.main.async {
                self.spinner.startAnimating()
                if isSuccess {
                    let orderCompletionVC = OrderSuccessViewController()
                    orderCompletionVC.modalPresentationStyle = .fullScreen
                    self.navigationController?.pushViewController(orderCompletionVC, animated: true)
                }
            }
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else {return}
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        let keyboardFrame = keyboardSize.cgRectValue
        
        if self.view.bounds.origin.y == 0{
            self.view.bounds.origin.y += keyboardFrame.height
        }
    }
    
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.bounds.origin.y != 0 {
            self.view.bounds.origin.y = 0
        }
    }
    
    func updateOrderButton(address: String?) {
        guard let address = address, !address.isEmpty else {
            orderButton.isEnabled = false
            orderButton.alpha = 0.4
            return
        }
        orderButton.isEnabled = true
        orderButton.alpha = 1.0
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension OrderSummaryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.productsOrder.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OrderSummaryCell.reuseIdentifier) as? OrderSummaryCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        let productInfo = viewModel.productsOrder[indexPath.row]
        cell.configureCell(productOrder: productInfo)
        return cell
    }
}

extension OrderSummaryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension OrderSummaryViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        updateOrderButton(address: textField.text)
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        updateOrderButton(address: textField.text)
    }
}
