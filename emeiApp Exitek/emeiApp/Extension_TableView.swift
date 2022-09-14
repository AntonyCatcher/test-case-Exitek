
import UIKit

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        if !database.isEmpty {
            return database.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "id")!
        cell.backgroundColor = .init(white: 0.1, alpha: 0.1)
        
        if !database.isEmpty {
            
            cell.textLabel?.textColor = .systemIndigo
            cell.textLabel?.font = .systemFont(ofSize: 20)
            
            cell.detailTextLabel?.textColor = .darkGray
            cell.detailTextLabel?.font = .systemFont(ofSize: 20)
            
            // SET isn't indexable by its nature...
            // So, I can't use [indexPath.row] here...
            // That's why I used .enumerated() method...
            for (index, element) in database.enumerated() {
                if indexPath.row == index {
                    cell.textLabel?.text = element.model
                    cell.detailTextLabel?.text = element.imei
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
        return "IMEI Database"
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
}
