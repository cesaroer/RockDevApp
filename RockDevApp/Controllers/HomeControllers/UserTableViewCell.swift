//
//  UserTableViewCell.swift
//  RockDevApp
//
//  Created by Cesar on 04/04/20.
//  Copyright © 2020 CesarVargas. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    @IBOutlet weak var usrIdLbl: UILabel!
    @IBOutlet weak var usrEmailLbl: UILabel!
    @IBOutlet weak var usrApLbl: UILabel!
    @IBOutlet weak var usrNameLbl: UILabel!
    @IBOutlet var usrAvatarImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let screenSize = UIScreen.main.bounds
        let cellSeparatorHeigth = CGFloat(20.0)
        let addSeparator = UIView.init(frame: CGRect(x: 0, y: self.frame.size.height - cellSeparatorHeigth, width: screenSize.width, height: cellSeparatorHeigth))
        addSeparator.backgroundColor = UIColor.white
        addSeparator.layer.masksToBounds = true
        addSeparator.layer.cornerRadius = 10
        self.addSubview(addSeparator)
        

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
