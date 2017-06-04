import UIKit



public class PlaceCell: UITableViewCell {
}



extension PlaceCell: ResponsibleCell {
  public static func register(with table: UITableView) -> CellIdentifier {
    let identifier = CellIdentifier(type: self)
    table.register(self, forCellReuseIdentifier: identifier.identifier)
    return identifier
  }
  
  
  public func fill(with value: [String: Any]) {
    textLabel?.text = value["place"] as? String
  }
}


