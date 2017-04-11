import UIKit

enum LeftMenu: Int {
    case nav0 = 0
    case nav1
    case nav2
    case nav3
    case nonMenu
}

protocol LeftMenuProtocol : class {
    func changeViewController(_ menu: LeftMenu)
}

//TODO: Klasse maken voor userbeheer!!! Volgende is voor testredenen.
//0 is leerling, 1 is docent, 2 is beheerder
public var UserLevel = 0

class LeftViewController : UIViewController, LeftMenuProtocol {
    
    @IBOutlet weak var tableView: UITableView!		
    
    var menus = [""]
    
    var mainViewController: UIViewController!
    var boekenViewController: UIViewController!
    var gegevensViewController: UIViewController!
    var klassenViewController: UIViewController!
    var nonMenuViewController: UIViewController!
    var imageHeaderView: ImageHeaderView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //verander navigatietekst afhangend van userlevel
        if UserLevel == 0 {
           menus = ["Opdrachten", "Boeken", "Mijn Gegevens"];
        } else if UserLevel == 1 {
            menus = ["Klassen", "Opdrachten toevoegen", "Mijn Gegevens"];
        } else if UserLevel == 2 {
            menus = ["Gebruikers", "Klassen", "Mijn Gegevens"];
        }
        
        
        
        
        
        //comment weghalen als je streepjes tussen de items wil
        //self.tableView.separatorColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1.0)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let boekenViewController = storyboard.instantiateViewController(withIdentifier: "BoekenViewController") as! BoekenViewController
        self.boekenViewController = UINavigationController(rootViewController: boekenViewController)
        
        let gegevensViewController = storyboard.instantiateViewController(withIdentifier: "GegevensViewController") as! GegevensViewController
        self.gegevensViewController = UINavigationController(rootViewController: gegevensViewController)
        
        let klassenViewController = storyboard.instantiateViewController(withIdentifier: "KlassenViewController") as! KlassenViewController
        self.klassenViewController = UINavigationController(rootViewController: klassenViewController)
        
        let nonMenuController = storyboard.instantiateViewController(withIdentifier: "NonMenuController") as! NonMenuController
        nonMenuController.delegate = self
        self.nonMenuViewController = UINavigationController(rootViewController: nonMenuController)
        
        self.tableView.registerCellClass(BaseTableViewCell.self)
        
        self.imageHeaderView = ImageHeaderView.loadNib()
        self.view.addSubview(self.imageHeaderView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.imageHeaderView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 160)
        self.view.layoutIfNeeded()
    }
    
    func changeViewController(_ menu: LeftMenu) {
        switch menu {
        case .nav0:
            self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true)
        case .nav1:
            self.slideMenuController()?.changeMainViewController(self.boekenViewController, close: true)
        case .nav2:
            self.slideMenuController()?.changeMainViewController(self.gegevensViewController, close: true)
        case .nav3:
            self.slideMenuController()?.changeMainViewController(self.klassenViewController, close: true)
        case .nonMenu:
            self.slideMenuController()?.changeMainViewController(self.nonMenuViewController, close: true)
        }
    }
}

extension LeftViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let menu = LeftMenu(rawValue: indexPath.row) {
            switch menu {
            case .nav0, .nav1, .nav2, .nav3, .nonMenu:
                return BaseTableViewCell.height()
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let menu = LeftMenu(rawValue: indexPath.row) {
            self.changeViewController(menu)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.tableView == scrollView {
            
        }
    }
}

extension LeftViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let menu = LeftMenu(rawValue: indexPath.row) {
            switch menu {
            case .nav0, .nav1, .nav2, .nav3, .nonMenu:
                let cell = BaseTableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: BaseTableViewCell.identifier)
                cell.setData(menus[indexPath.row])
                return cell
            }
        }
        return UITableViewCell()
    }
    
    
}
