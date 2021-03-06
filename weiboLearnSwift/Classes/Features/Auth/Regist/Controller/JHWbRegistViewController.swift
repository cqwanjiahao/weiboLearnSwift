//
//  JHWbRegistViewController.swift
//  weiboLearnSwift
//
//  Created by 万家豪 on 2017/8/22.
//  Copyright © 2017年 万家豪. All rights reserved.
//

import UIKit
import SVProgressHUD

class JHWbRegistViewController: UIViewController,JHWbMoblieRegistViewDelegate {
    private var didSetupConstraints = false
    //MARK: - lazyload
    lazy var mainScrollView = { () -> UIScrollView in
        let mainScrollView = UIScrollView()
        mainScrollView.backgroundColor = UIColor.white
        mainScrollView.contentSize = CGSize.init(width: 0, height: UIScreen.main.bounds.size.height - 19)
        return mainScrollView
    }()
    
    lazy var cancelBtn = { () -> UIButton in
       let cancelBtn = UIButton()
        cancelBtn.setTitleColor(UIColor.black, for: .normal)
        cancelBtn.setTitleColor(UIColor.jh_setColor(r: 255, g: 133, b: 5), for: .highlighted)
        cancelBtn.setTitle("取消", for: .normal)
        cancelBtn.titleLabel?.font = .systemFont(ofSize: jh_getLength(length: 16))
        cancelBtn .sizeToFit()
        cancelBtn.addTarget(self, action: #selector(JHWbRegistViewController.cancelButtonClick), for: .touchUpInside)
        return cancelBtn
    }()
    
    lazy var infoLabel = { () -> UILabel in
        let infoLabel = UILabel()
        infoLabel.text = "输入手机号，快速注册"
        infoLabel.textColor = UIColor.black
        infoLabel.font = .systemFont(ofSize: jh_getLength(length: 24))
        infoLabel.textAlignment = .center
        return infoLabel
    }()
    
    lazy var mobileRegistView = JHWbMoblieRegistView()
    lazy var otherRegistView = JHWbOtherRegistView()
    
    
    
    // MARK: - 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubView()
        otherRegistEvents()
        mobileRegistView.delegate = self
        addAGesutreRecognizerForScrollView()
        view .updateConstraints()
        view.setNeedsUpdateConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

// MARK:- setupView
extension JHWbRegistViewController {
    func setupSubView() {
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(cancelBtn)
        mainScrollView.addSubview(infoLabel)
        mainScrollView.addSubview(mobileRegistView)
        mainScrollView.addSubview(otherRegistView)
    }
}

// MARK:- constraints
extension JHWbRegistViewController {
    override func updateViewConstraints() {
        if !didSetupConstraints {
            didSetupConstraints = true

            mainScrollView.snp.makeConstraints { (make) -> Void in
                make.size.equalToSuperview()
                make.center.equalToSuperview()
            }

            cancelBtn.snp.makeConstraints { (make) -> Void in
                make.top.equalToSuperview().offset(jh_getLength(length: 15))
                make.leading.equalToSuperview().offset(jh_getLength(length: 10))
                make.height.equalTo(jh_getLength(length: 16))
            }
            
            infoLabel.snp.makeConstraints { (make) -> Void in
                make.top.equalToSuperview().offset(jh_getLength(length: 80))
                make.width.leading.equalToSuperview()
                make.height.equalTo(jh_getLength(length: 24))
            }

            mobileRegistView.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(infoLabel.snp.bottom).offset(jh_getLength(length: 53))
                make.width.leading.equalToSuperview()
                make.height.equalTo(jh_getLength(length: 250))
            }

            otherRegistView.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(UIScreen.main.bounds.height - 100 - 20)
                make.width.leading.equalToSuperview()
                make.height.equalTo(jh_getLength(length: 100))
            }
        }
        super .updateViewConstraints()
    }
}

// MARK: - Events
extension JHWbRegistViewController {
    func otherRegistEvents() {
        otherRegistView.qqBtn.addTarget(self, action: #selector(JHWbRegistViewController.qqBtnClick), for: .touchUpInside)
        otherRegistView.wechatBtn.addTarget(self, action: #selector(JHWbRegistViewController.wechatBtnClick), for: .touchUpInside)
        otherRegistView.mailBtn.addTarget(self, action: #selector(JHWbRegistViewController.mailBtnClick), for: .touchUpInside)
    }
    
    @objc func qqBtnClick() {
        SVProgressHUD.show(withStatus: "QQ暂未完成")
        SVProgressHUD.dismiss(withDelay: 2)
    }
    @objc func wechatBtnClick() {
        SVProgressHUD.show(withStatus: "微信暂未完成")
        SVProgressHUD.dismiss(withDelay: 2)
    }
    @objc func mailBtnClick() {
        SVProgressHUD.show(withStatus: "邮箱暂未完成")
        SVProgressHUD.dismiss(withDelay: 2)
    }
    
    @objc func cancelButtonClick() {
        dismiss(animated: true) {
        }
    }
    
//    退出键盘
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        mobileRegistView.mobileTextField.resignFirstResponder()
    }
    //MARK : 给scrollView添加手势
    func addAGesutreRecognizerForScrollView() {
        let tapGesture = UITapGestureRecognizer.init(target: self, action:#selector(JHWbRegistViewController.tapGestureClick))
        mainScrollView.addGestureRecognizer(tapGesture)
    }
    @objc func tapGestureClick(recognizer : UITapGestureRecognizer) {        mobileRegistView.mobileTextField.resignFirstResponder()
    }

}
//MARK:- 代理方法
extension JHWbRegistViewController {
    //JHWbMoblieRegistViewDelegate
    func areaPickBtnClick() {
        let areaPickVC = JHWbAreaPickViewController()
        //接收闭包传回的值
        areaPickVC.areaPickTableVC.areaInfoClosure = receiveTitleClosure;
        navigationController?.pushViewController(areaPickVC, animated: true)
    }
    
    //定义一个带字符串参数的闭包
    func receiveTitleClosure(title: String)->Void{
        mobileRegistView.areaPickBtn.setTitle(title, for: .normal)
    }
}


