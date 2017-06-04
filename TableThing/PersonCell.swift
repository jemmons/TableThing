import UIKit



public class PersonCell: UITableViewCell {
  @IBOutlet internal weak var name: UILabel!
  @IBOutlet internal weak var company: UILabel!
}



extension PersonCell: ResponsibleCell {
  public static func register(with table: UITableView) -> CellIdentifier {
    let identifier = CellIdentifier(type: self)
    table.register(UINib(nibName: "PersonCell", bundle: nil), forCellReuseIdentifier: identifier.identifier)
    return identifier
  }
  
  
  public func fill(with value: [String: Any]) {
    name.text = value["name"] as? String
    company.text = value["company"] as? String
  }
}
