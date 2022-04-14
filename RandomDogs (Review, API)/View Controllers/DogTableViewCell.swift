//
//  DogTableViewCell.swift
//  RandomDogs (Review, API)
//
//  Created by Erik Jimenez on 2/18/22.
//

import UIKit

class TopLevelObjectTableViewCell: UITableViewCell {

//    override func awakeFromNib() {
//        super.awakeFromNib()
//
//    }
    
    var topLevelObject: TopLevelObject? {
        didSet {
            updateViews()
        }
    }
    @IBOutlet weak var messageImageView: UIImageView!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    func updateViews() {
        guard let topLevelObject = topLevelObject else {
            return
        }
        
        // Outlets inside Update views
        
        statusLabel.text = topLevelObject.status
        
        
        
        TopLevelObjectController.fetchMessage(messageURL: topLevelObject.message ) { result in
            DispatchQueue.main.async {
                switch result {

                case .success(let message):
                    self.messageImageView.image = message
                    self.messageImageView.contentMode = .scaleToFill
                    self.messageImageView.layer.cornerRadius = 10
                case .failure(_):
                    self.messageImageView.image = UIImage(named: "defaultImage")
                    self.messageImageView.contentMode = .scaleToFill
                }
            }
        }
    }

    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    
    }

}

