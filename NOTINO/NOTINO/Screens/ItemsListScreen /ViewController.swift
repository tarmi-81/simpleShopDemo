//
//  ViewController.swift
//  NOTINO
//
//  Created by Jozef Gmuca on 03/09/2022.
//

import UIKit

public protocol CellInteractionDelegate{
    func onFavButtonClick(_ id: Int)
    func onBuyButtonClick(_ id: Int)
}

class ViewController: UIViewController, CellInteractionDelegate {
    var collectionView:UICollectionView?
    var viewModel = ViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "items_list_title".localized()
        
        viewModel.loadProducts(reloadCollectionView)
        let cellSize = CGSize(width: viewModel.cellWidth(self.view.frame.width) , height:viewModel.cellHeight(self.view.frame.height))
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical //.horizontal
        layout.itemSize = cellSize
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.minimumLineSpacing = 20.0
        layout.minimumInteritemSpacing = 8.0
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: self.view.bounds,collectionViewLayout: layout)
        
        self.collectionView?.register(MyCollectionCell.self, forCellWithReuseIdentifier: "MyCollectionCell")
        self.collectionView?.dataSource = self
        
        self.collectionView?.delegate = self
        
        self.collectionView?.alwaysBounceVertical = true
        self.collectionView?.backgroundColor = .white
        self.view.addSubview(collectionView ?? UICollectionView())
        
    }
    func reloadCollectionView() {
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
    func onFavButtonClick(_ id: Int) {
        
        if   let itemIndex = self.viewModel.product.firstIndex(where: {
            $0.productItem.masterId == id
        }) {
            self.viewModel.product[itemIndex].userInteractionData.isFavorite = !self.viewModel.product[itemIndex].userInteractionData.isFavorite
            self.collectionView?.reloadItems(at: [IndexPath(row: itemIndex, section: 0)])
        }
        
    }
    func onBuyButtonClick(_ id: Int) {
        if   let itemIndex = self.viewModel.product.firstIndex(where: {
            $0.productItem.masterId == id
        }) {
            self.viewModel.product[itemIndex].userInteractionData.isInBasket = !self.viewModel.product[itemIndex].userInteractionData.isInBasket
            self.collectionView?.reloadItems(at: [IndexPath(row: itemIndex, section: 0)])
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.productsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if  let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectionCell", for: indexPath) as? MyCollectionCell {
            cell.data = viewModel.dataForCell(indexPath.item)
            cell.delegate = self
            cell.setupCell()
            
            
            //cell.backgroundColor = .red
            return cell
        }
        fatalError("Unable to dequeue  cell")
    }
}
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        debugPrint("tap on cell")
    }
}

