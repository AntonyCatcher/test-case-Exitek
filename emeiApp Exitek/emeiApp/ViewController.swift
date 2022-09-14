
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var textField_FindByIMEI: UITextField!
    @IBOutlet var textField_ProductExists: UITextField!
    @IBOutlet var textField_ProductExists2: UITextField!
    @IBOutlet var label: UILabel!
    let defaults = UserDefaults.standard
    
    let manufacturer = ["Apple","Huawei","Sony","Google","Xiaomi"]
    var database: Set<Mobile> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        
        if defaults.object(forKey: "model") != nil {
            label.text = "\(defaults.object(forKey: "model")!)    \(defaults.object(forKey: "imei")!)"
        } else {
            label.text = ""
        }
    }
    
    @IBAction func generatePressed(_ sender: UIButton) {
        database.removeAll()
        database = self.getAll()
        
        DispatchQueue.main.async() {
            self.tableView.reloadData()
        }
    }
    
    @IBAction func check_FindByIMEI(_ sender: UIButton) {
        
        guard let imei = textField_FindByIMEI.text else { return }
        
        if !imei.isEmpty {
            if findBylMEI(imei) != nil {
                textField_FindByIMEI.backgroundColor =
                    .systemGreen.withAlphaComponent(0.2)
            } else {
                textField_FindByIMEI.backgroundColor =
                    .systemRed.withAlphaComponent(0.2)
            }
        }
    }
    
    @IBAction func check_ProductExists(_ sender: UIButton) {
        
        guard let stringIMEI = textField_ProductExists.text else { return }
        guard let stringModel = textField_ProductExists2.text else { return }
        let mobile = Mobile(imei: stringIMEI, model: stringModel)
        
        if !(stringIMEI.isEmpty && stringModel.isEmpty) {
            if exists(mobile) {
                textField_ProductExists.backgroundColor =
                    .systemGreen.withAlphaComponent(0.2)
                textField_ProductExists2.backgroundColor =
                    .systemGreen.withAlphaComponent(0.2)
            } else {
                textField_ProductExists.backgroundColor =
                    .systemRed.withAlphaComponent(0.2)
                textField_ProductExists2.backgroundColor =
                    .systemRed.withAlphaComponent(0.2)
            }
        }
    }
    
    @IBAction func deletion(_ sender: UIButton) {
        
        if database.count > 0 {
            do {
                try deleter(database.first!)
            } catch {
                print("Error")
            }
        }
        tableView.reloadData()
    }
    
    @IBAction func saving(_ sender: UIButton) {
        
        if database.count > 0 {
            do {
                let mobile: Mobile = try save(database.first!)
                
                if database.count > 0 {
                    defaults.set(mobile.imei, forKey: "imei")
                    defaults.set(mobile.model, forKey: "model")
                    
                    label.text = "\(defaults.object(forKey: "model")!)     \(defaults.object(forKey: "imei")!)"
                }
            } catch {
                print("Error")
            }
        }
    }
}
