//
//  MainTabBarController.swift
//  AltoYou
//
//  Created by 정의찬 on 10/4/23.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        setSelf()
        addTab()
    }
    
    //MARK: - Function
    
    private func setSelf(){
        self.tabBar.tintColor = .blue
    }
    
    private func addTab(){
        let targetSize = CGSize(width: 60, height: 60)
        let selectedColor = UIColor(red: 0.53, green: 0.81, blue: 0.92, alpha: 1.00)
        
        let vc1 = MainViewController()
        let vc2 = SecondMainViewController()
        
        if let resizedHouseImage = UIImage(named: "house.png")?.resizeImage(targetSize: targetSize) {
            vc1.tabBarItem.image = resizedHouseImage.withRenderingMode(.alwaysOriginal)
            vc1.tabBarItem.title = "Home"
            vc1.tabBarItem.setTitleTextAttributes([.font: UIFont.boldSystemFont(ofSize: 20)], for: .normal)
        }
        
        if let resizedChatImage = UIImage(named: "chat.png")?.resizeImage(targetSize: targetSize) {
            vc2.tabBarItem.image = resizedChatImage.withRenderingMode(.alwaysOriginal)
            vc2.tabBarItem.title = "Conversation"
            vc2.tabBarItem.setTitleTextAttributes([.font: UIFont.boldSystemFont(ofSize: 20)], for: .normal)
        }
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        
        nav1.navigationBar.prefersLargeTitles = true
        nav2.navigationBar.prefersLargeTitles = true
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: selectedColor], for: .selected)
        
        setViewControllers([nav1, nav2], animated: true)
    }
    
    ///MARK: 애니메이션 기능
    private func animateTabBarItem(at index: Int){
        guard let tabBarItems = tabBar.items,
              index < tabBarItems.count,
              let imageView = tabBar.subviews[index + 1].subviews.first(where: { $0 is UIImageView}) as? UIImageView else{
            return
        }
        
        UIView.animate(withDuration: 0.2, animations: {
            imageView.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
        }) { _ in
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                imageView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            }, completion: nil)
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let index = viewControllers?.firstIndex(of: viewController) else{
            return true
        }
        
        animateTabBarItem(at: index)
        return true
    }
}
