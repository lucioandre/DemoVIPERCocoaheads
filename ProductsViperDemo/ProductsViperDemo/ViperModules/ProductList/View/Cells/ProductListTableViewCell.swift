//
//  RecipeListTableViewCell.swift
//  Recipes
//
//  Created by Avenue Brazil on 16/10/17.
//  Copyright © 2017 Lucio Fonseca. All rights reserved.
//

import UIKit

class ProductListTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var containerView: UIView! {
        didSet {
            self.containerView.layer.borderColor = UIColor.lightGray.cgColor
            self.containerView.layer.borderWidth = 1.0/UIScreen.main.scale
            self.containerView.layer.shadowColor = UIColor.lightGray.cgColor
            self.containerView.layer.shadowRadius = 4
            self.containerView.layer.shadowOpacity = 0.7
            self.containerView.layer.shadowOffset = CGSize.zero
            self.containerView.layer.shadowPath = UIBezierPath(rect: self.containerView.bounds).cgPath
        }
    }

    @IBOutlet weak var scoreRoundView: UIView! {
        didSet {
            self.scoreRoundView.layer.cornerRadius = self.scoreRoundView.frame.size.width/2
            self.scoreRoundView.layer.borderWidth = 2
            self.scoreRoundView.layer.borderColor = UIColor.white.cgColor
        }
    }
}
