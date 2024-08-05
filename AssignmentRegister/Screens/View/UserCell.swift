//
//  UserCell.swift
//  AssignmentRegister
//
//  Created by Apple on 05/08/24.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var userEducation: UILabel!
    
    var user: UserEntity? {
        didSet{
            cellConfiguration()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        userImage.circleImage()
    }
   
    func cellConfiguration(){
        guard let user else {return }
      
        userName.text = (user.firstname ?? "") + " " + (user.lastname ?? "")
        userEducation.text = "\(user.education ?? "")"
        
        let imageURL = URL.documentsDirectory.appending(components: user.imageName ?? "").appendingPathExtension("png")
        userImage.image = UIImage(contentsOfFile: imageURL.path)
    }
}
