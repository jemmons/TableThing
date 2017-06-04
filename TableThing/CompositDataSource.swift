import UIKit



public enum DataSourceState {
  case ready, empty, busy, error, loaded
}



public class CompositeDataSource: NSObject {
  fileprivate let sections: [SectionDataSourceProtocol]
  
  
  init(sections: [SectionDataSourceProtocol]) {
    self.sections = sections
    super.init()
  }
}




extension CompositeDataSource: UITableViewDataSource {
  public func numberOfSections(in tableView: UITableView) -> Int {
    return sections.count
  }
  
  
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return sections[section].numberOfRows
  }
  
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return sections[indexPath.section].tableView(tableView, cellForRowAt: indexPath)
  }
  
  
  public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return sections[section].title
  }
}
