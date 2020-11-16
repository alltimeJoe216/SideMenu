//
//  MainContainer.swift
//  SideMenuFeature
//
//  Created by Joseph Veverka on 11/16/20.
//

import UIKit

class MainContainer: UIViewController {
    
    var menuController: SideMenuController!
    var centerViewController: UIViewController!
    var isExpanded = false
    var homePageController: HomePageController!
//
//    let button: UIButton = {
//        let button = UIButton(type: .system)
//        button.tintColor = .blue
//        button.setImage(UIImage(named: "plus"), for: .normal)
//        button.addTarget(self, action: #selector(homePageController.handleMenuToggle), for: .touchUpInside)
//        return button
//    }()
    
    //MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHomeController()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    override var prefersStatusBarHidden: Bool {
        return isExpanded
    }
    
    //MARK: - Class methods
    
    func configureHomeController() {
        let homeController = HomePageController()
        homeController.delegate = self
        centerViewController = UINavigationController(rootViewController: homeController)
        
        view.addSubview(centerViewController.view)
        addChild(centerViewController)
        centerViewController.didMove(toParent: self)
    }
    
    func configureMenuController() {
        if menuController == nil {
            menuController = SideMenuController()
            menuController.delegate = self
            view.insertSubview(menuController.view, at: 0)
            addChild(menuController)
            menuController.didMove(toParent: self)
        }
    }
    
    func didSelectMenuOption(menuOption: MenuOption) {
        switch menuOption {
        case .Profile:
            print("Show profile")
        case .Discover:
            print("Show Discover")
        case .Post:
            print("Show Post")
//        case .Settings:
//            let controller = SettingsController()
//            controller.username = "Batman"
//            present(UINavigationController(rootViewController: controller), animated: true, completion: nil)
        }
    }
    
    func animatePanel(shouldExpand: Bool, menuOption: MenuOption?) {
        
        if shouldExpand {
            // show menu
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.centerViewController.view.frame.origin.x = self.centerViewController.view.frame.height - 120
            }, completion: nil)
            
        } else {
            // hide menu
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.centerViewController.view.frame.origin.x = 0
            }) { (_) in
                guard let menuOption = menuOption else { return }
                self.didSelectMenuOption(menuOption: menuOption)
            }
        }
        
        animateStatusBar()
    }
    
    func animateStatusBar() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.setNeedsStatusBarAppearanceUpdate()
        }, completion: nil)
    }
    
}

extension MainContainer: HomeControllerDelegate {
    func handleMenuToggle(forMenuOption menuOption: MenuOption?) {
        if !isExpanded {
            configureMenuController()
        }
        
        isExpanded = !isExpanded
        animatePanel(shouldExpand: isExpanded, menuOption: menuOption)
    }
}
