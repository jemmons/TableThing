import UIKit

public enum DataSourceState {
  case ready, empty, busy, error, loaded
}


public class CompositeDataSource: NSObject {
  fileprivate let sections: [SectionDataSourceProtocol]
  
  
  public var state: DataSourceState {
    let states = sections.map { $0.state }
    guard !states.contains(.error) else {
      return .error
    }
    guard !states.contains(.busy) else {
      return .busy
    }
    guard !states.contains(.ready) else {
      return .ready
    }
    let allEmpty = states.reduce(true) {
      return $0 && ($1 == .empty)
    }
    guard !allEmpty else {
      return .empty
    }
    return .loaded
  }

  
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
