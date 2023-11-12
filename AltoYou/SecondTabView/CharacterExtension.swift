//
//  CharacterExtension.swift
//  AltoYou
//
//  Created by 정의찬 on 11/3/23.
//

import Foundation
import UIKit
import SwiftUI

extension SecondMainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CharacterInfo.CharacterList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.identifier, for: indexPath) as? CharacterCollectionViewCell else { return UICollectionViewCell() }
        cell.configuration(CharacterInfo.CharacterList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 269, height: 326)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CharacterCollectionViewCell else { return }
        
        if let previousIndexPath = currentIndexPath, let previousCell = collectionView.cellForItem(at: previousIndexPath) as? CharacterCollectionViewCell {
            previousCell.chracterBackgroundView.layer.borderColor = nil
            previousCell.chracterBackgroundView.layer.borderWidth = 0
        }
        
        cell.chracterBackgroundView.layer.borderColor = UIColor(red: 0.60, green: 0.97, blue: 0.59, alpha: 1.00).cgColor
        cell.chracterBackgroundView.layer.borderWidth = 5
        
        currentIndexPath = indexPath
        
        showPopUp(message: "학습을 진행해볼래요?", leftActionTitle: "Yes",rightActionTitle: "No", leftActionCompletion: { [weak self] in
            guard let strongSelf = self else { return }
            let contentView = ContentView()
            let hostingController = UIHostingController(rootView: contentView)
            
            hostingController.modalPresentationStyle = .fullScreen
            DispatchQueue.main.async{
                strongSelf.present(hostingController, animated: true, completion: nil)
            }
        })
    }
}