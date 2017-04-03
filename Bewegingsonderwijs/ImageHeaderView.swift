

import UIKit

class ImageHeaderView : UIView {
    
    @IBOutlet weak var profileImage : UIImageView!
   
    // @IBOutlet weak var backgroundImage : UIImageView!
    //comment weghalen wanneer je achtergrond in navigatiedrawer wil.
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor(hex: "E0E0E0")
        self.profileImage.layoutIfNeeded()
        self.profileImage.layer.cornerRadius = self.profileImage.bounds.size.height / 2
        self.profileImage.clipsToBounds = true
        self.profileImage.layer.borderWidth = 1
        self.profileImage.layer.borderColor = UIColor.white.cgColor
    
    
        //self.backgroundImage.setRandomDownloadImage(Int(self.bounds.size.width), height: 160)
    }
}
