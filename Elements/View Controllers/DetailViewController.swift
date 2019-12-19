//
//  DetailViewController.swift
//  Elements
//
//  Created by Chelsi Christmas on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var element: Element?
    
    
    
    @IBOutlet weak var elementImageView: UIImageView!
    
    @IBOutlet weak var symbolLabel: UILabel!
    
    
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBOutlet weak var weightLabel: UILabel!
    
    
    @IBOutlet weak var meltingPointLabel: UILabel!
    
    @IBOutlet weak var boilingPointLabel: UILabel!
    
    
    @IBOutlet weak var discoveredByLabel: UILabel!
    
    
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        
        
    }
    
    
    
    
    func loadData() {
        
        
        symbolLabel.text = element!.symbol
        numberLabel.text = "\(element!.number)"
        weightLabel.text = "Weight: \(element!.atomic_mass)"
        
        
        
        
        if element!.melt != nil {
            meltingPointLabel.text = "Melting Point: \(element!.melt ?? 0.0)"
        } else {
            meltingPointLabel.text = "Melting Point: N/A"
        }
        
        
        if element!.boil != nil {
            boilingPointLabel.text = "Boiling Point: \(element!.boil ?? 0.0)"
        } else {
            boilingPointLabel.text = "Boiling Point: N/A"
        }
        
        discoveredByLabel.text = "Discovered by: \(element!.discovered_by ?? "N/A")"
        
        let lowercasedName = element!.name.lowercased()
        let urlString = "http://images-of-elements.com/\(lowercasedName).jpg"
        
        elementImageView.getImage(with: urlString) {[weak self] (result) in
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
    
    
    
    
    
    @IBAction func favorite(_ sender: UIBarButtonItem) {
        
        favoriteButton.image = UIImage(systemName: "heart.fill")
        guard let element = element else {
            fatalError("Element Unavailabel for favoriting")
        }
        ElementAPIClient.postFavorite(element: element) { [weak self, weak sender] (result) in
            DispatchQueue.main.async {
                sender?.isEnabled = false
                
                
            }
            switch result {
            case .failure(let appError):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Error posting question", message: "\(appError)")
                }
            case .success:
                DispatchQueue.main.async {
                     
                    self?.showAlert(title: "Success", message: "\(element.name) was added to your favorites!") { action in
                       
                    }
                }
            }
        }
    }
    
    
    
}
