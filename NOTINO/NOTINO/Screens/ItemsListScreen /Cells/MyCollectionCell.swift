//
//  MyCollectionCell.swift
//  NOTINO
//
//  Created by Jozef Gmuca on 03/09/2022.
//

import Foundation
import UIKit
class MyCollectionCell : UICollectionViewCell {
    var data: ProductWrapper?
    var delegate: CellInteractionDelegate?
    
    var favorite: UIButton = UIButton()
    var image: UIImageView = UIImageView()
    var brand: UILabel = UILabel()
    var title: UILabel = UILabel()
    var annotation  : UILabel = UILabel()
    var price: UILabel = UILabel()
    var rating: UIView = UIView()
    var buy: UIButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public override func prepareForReuse()  {
        super.prepareForReuse()
        data = nil
        image.image = nil
        brand.text = nil
        title.text = nil
        annotation.text = nil
        price.text = nil
        rating.isHidden = true
        favorite.isHidden = true
        buy.isHidden = true
        delegate = nil
    }
    
    func setupCell() {
        
        favorite = favButton()
        favorite.addTarget(self, action: #selector(self.favoriteButtonClik(button:)), for: .touchUpInside)
        image = productImage()
        brand = brandNameLabel(data?.productItem.brand.name ?? "")
        title = titleLabel(data?.productItem.name ?? "")
        annotation = annotationLabel(data?.productItem.annotation ?? "")
        
        price = titleLabel(priceString())
        rating = ratingElement()
        buy = buyButton()
        buy.addTarget(self, action: #selector(self.buyButtonClik(button:)), for: .touchUpInside)
        self.addSubview(favorite)
        self.addSubview(image)
        self.addSubview(brand)
        self.addSubview(title)
        self.addSubview(annotation)
        self.addSubview(price)
        self.addSubview(rating)
        self.addSubview(buy)
        setUI()
    }
    func setUI(){
        favorite.frame.origin.x = self.frame.width - favorite.frame.width
        favorite.frame.origin.y = 0
        image.frame.origin.x = 0
        image.frame.origin.y = favorite.frame.maxY
        brand.frame.origin.x = 0
        brand.frame.origin.y = image.frame.maxY + 12
        title.frame.origin.x = 0
        title.frame.origin.y = brand.frame.maxY + 4
        annotation.center.x = self.image.center.x
        annotation.frame.origin.y = title.frame.maxY + 0
        rating.center.x = self.image.center.x
        rating.frame.origin.y = annotation.frame.maxY + 12
        price.frame.origin.x = 0
        price.frame.origin.y = rating.frame.maxY + 12
        buy.center.x = self.image.center.x
        buy.frame.origin.y = price.frame.maxY + 12
    }
    func titleLabel(_ string: String ) -> UILabel {
        let view = UILabel()
        view.frame.size.width = self.frame.width
        view.frame.size.height =  20
        view.textColor = .black
        view.font = .SF_PRO_SEMIBOLD_14
        view.text = string
        view.textAlignment = .center
        return view
        
    }
    
    func brandNameLabel(_ string: String) -> UILabel {
        let view = UILabel()
        
        view.frame.size.width = self.frame.width
        view.frame.size.height =  20
        view.backgroundColor = .white
        view.textColor = .GRAY1
        view.font = .SF_PRO_REGULAR_14
        view.textAlignment = .center
        view.text = string
        return view
    }
    func annotationLabel(_ string: String) -> UILabel {
        let view = UILabel()
        view.frame.size.width = self.frame.width - 20
        view.frame.size.height = string.computedHeight(width: self.frame.width, font: view.font!)
        view.backgroundColor = .white
        view.textColor = .GRAY2
        view.font = .SF_PRO_REGULAR_14
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        
        view.textAlignment = .center
        view.text = string
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1.0
        
        return view
    }
    func favButton()->UIButton {
        let button = UIButton()
        var buttonImage = UIImage(named:"heart")
        
        if data?.userInteractionData.isFavorite == true {
            buttonImage = UIImage(named:"heart-filled")
        }
        button.setImage(buttonImage, for: .normal)
        button.frame.size.width = 48
        button.frame.size.height = 48
        return button
    }
    func buyButton()->UIButton {
        let button = MyButton()
        button.titleLabel?.font = .SF_PRO_SEMIBOLD_14
        button.titleLabel?.textAlignment = .center
        if data?.userInteractionData.isInBasket == true  {
            button.setTitle("button_in_basket".localized(), for: .normal)
            button.setTitleColor(.GRAY1, for: .normal)
        } else {
            button.setTitle("button_to_basket".localized(), for: .normal)
            button.setTitleColor(.black, for: .normal)
        }
        
        button.frame.size.height = 36
        button.frame.size.width = 92
        return button
    }
    
    func ratingElement() -> UIView {
        let view = UIView()
        let fillStarImage = UIImage(named: "star-filled")
        let starImage = UIImage(named: "star")
        let score:Int = Int(data?.productItem.reviewSummary.score.rounded() ?? 0)
        var rate:[UIImageView] = []
        for i in 0..<5 {
            var starView: UIImageView  =  UIImageView(image: starImage)
            if score > i {
                starView = UIImageView(image: fillStarImage)
            }
            starView.frame.size.width = 12
            starView.frame.size.height = 12
            starView.frame.origin.y = 0
            starView.frame.origin.x = 0
            rate.append(starView)
        }
        for i in 0..<5 {
            if i > 0 {
                rate[i].frame.origin.y = 0
                rate[i].frame.origin.x = rate[i-1].frame.maxX + 1
            }
            view.addSubview(rate[i])
        }
        view.frame.size.width = 13*5
        view.frame.size.height = 12
        return view
    }
    func productImage() -> UIImageView {
        let image:UIImageView = UIImageView()
        if let data = data {
            image.downloaded(from:ServerAPI.URL.imageBase.string() + data.productItem.imageUrl)
        }
        
        image.frame.size.height = self.frame.width
        image.frame.size.width = self.frame.width
        image.backgroundColor = .white
        return image
    }
    
    
    @objc func favoriteButtonClik(button: UIButton){
        if let data = data {
            self.delegate?.onFavButtonClick(data.productItem.masterId)
        }
    }
    @objc func buyButtonClik(button: UIButton){
        if let data = data {
            self.delegate?.onBuyButtonClick(data.productItem.masterId)
        }
    }
    
    func priceString() -> String {
        var price = ""
        if (data?.productItem.price.value ?? 0) > 0 {
            price =    ("price_from".localized() + String(data?.productItem.price.value ?? 0) + " " + (data?.productItem.price.currency ?? "-"))
        }
        return price
    }
}

