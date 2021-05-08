//
//  CityListViewController.swift
//  Weather1
//
//  Created by Artem Bazhanov on 07.05.2021.
//

import UIKit

private let reuseIdentifier = "cityCell"

class CityListViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CityListCell
        cell.labelInCell.text = "УРА!!!"
    
        return cell
    }
    
//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
    

}


extension CityListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 48, height: 100)
    }
}
