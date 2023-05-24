//
//  CustomTableViewCell.swift
//  News
//



import UIKit

class CustomTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imageUrlView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
