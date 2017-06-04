import UIKit

class TableViewController: UITableViewController {
  private let dataSource: CompositeDataSource
  private let peopleSection: SectionDataSource<PersonCell>
  private let placesSection: SectionDataSource<PlaceCell>
  private let networkService = FakeNetworkService()
  
  
  required init?(coder aDecoder: NSCoder) {
    peopleSection = SectionDataSource<PersonCell>(title: "People")
    placesSection = SectionDataSource<PlaceCell>(title: "Places")
    dataSource = CompositeDataSource(sections: [peopleSection, placesSection])
    super.init(coder: aDecoder)
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    networkService.fetchPeople { json in
      peopleSection.values = json
    }
    networkService.fetchPlaces { json in
      placesSection.values = json
    }

    tableView.dataSource = dataSource
  }
}

