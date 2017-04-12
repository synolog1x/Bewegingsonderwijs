

import UIKit
import CoreData


class LoginViewController: UIViewController {
    @IBOutlet weak var UsernameField: UITextView!
    @IBOutlet weak var PasswordField: UITextView!
    
    weak var delegate: LeftMenuProtocol?
    
    
    

    @IBAction func LoginButton(_ sender: UIButton) {
    //var Username = UsernameField.text
    //var Password = PasswordField.text
    
        
        //TODO: maak verbinding met database, en filter op username. Kijk vervolgens of wachtwoord overeenkomt
    
    }



}
