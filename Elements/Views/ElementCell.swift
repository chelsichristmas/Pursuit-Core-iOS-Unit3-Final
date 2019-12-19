//
//  ElementCell.swift
//  Elements
//
//  Created by Chelsi Christmas on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementCell: UITableViewCell {

    var element: Element?

  
    @IBOutlet weak var elementImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func configureCell(for element: Element) {
        nameLabel.text = element.name
        descriptionLabel.text = "\(element.symbol)(\(element.number)) \(element.atomic_mass)"
        var elementID = ""
        if element.number < 10 {
            elementID = "00\(element.number)"
        } else if element.number >= 10 && element.number < 100 {
            elementID = "0\(element.number)"
        } else if element.number >= 100 {
            elementID = "\(element.number)"
        }
        
        let urlString = "http://www.theodoregray.com/periodictable/Tiles/\(elementID)/s7.JPG"
        
        elementImageView.getImage(with: urlString)  {[weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.elementImageView.image = UIImage(systemName: "exclamationmark.triangle")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.elementImageView.image = image
                }
            }
        }
    }
    
}
