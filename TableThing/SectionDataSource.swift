import UIKit



public protocol SectionDataSourceProtocol {
  var title: String? {get}
  var numberOfRows: Int {get}
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
}



public class SectionDataSource<CellType: ResponsibleCell>: SectionDataSourceProtocol {
  public var title: String?
  public var values: [CellType.ValueObject] = []
  private let memo: ExternalMemo<CellIdentifier, UITableView>
  
  
  public var numberOfRows: Int {
    return values.count
  }
  
  
  public init(title: String? = nil, values: [CellType.ValueObject] = []) {
    self.title = title
    self.values = values
    memo = ExternalMemo { table in
      return CellType.register(with: table)
    }
  }
  
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: memo.value(tableView).identifier, for: indexPath)
    if let responsibleCell = cell as? CellType {
      responsibleCell.fill(with: values[indexPath.row])
    }
    return cell
  }
}
