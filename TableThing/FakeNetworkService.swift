import Foundation



class FakeNetworkService {
  
  func fetchPeople(success: ([[String: Any]])->Void) {
    success([
      ["name": "Josh", "company": "Uptake"],
      ["name": "Kevin", "company": "Reverb"],
      ["name": "Anthony", "company": "Backstop"],
    ])
  }
  
  
  func fetchPlaces(success: ([[String: Any]])->Void) {
    success([
      ["place": "Alabama"],
      ["place": "Alaska"],
      ["place": "Arizona"],
    ])
  }
  
}
