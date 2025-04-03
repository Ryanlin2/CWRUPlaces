//
//  LocationViewModel.swift
//  CWRUPlaces
//
//  Created by Ryan Lin on 4/2/25.
//

import Foundation

class LocationViewModel: ObservableObject {
    @Published var locations: [UserLocation] = []

    let url = URL(string: "https://caslab.case.edu/392/map.php")!
    
    func fetchLocations() {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data,
                  let response = try? JSONDecoder().decode(LocationsResponse.self, from: data) else { return }
            DispatchQueue.main.async {
                self.locations = response.locations
            }
        }.resume()
    }
    
    private var timer: Timer?

    func startTimer() {
        // Optional: avoid multiple timers
        timer?.invalidate()

        timer = Timer.scheduledTimer(withTimeInterval: 30, repeats: true) { _ in
            self.fetchLocations()
        }
    }

    
    func postLocation(post: PostLocation) {
        guard let url = URL(string: "https://caslab.case.edu/392/map.php") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(post)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error posting location: \(error)")
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                print("POST response code: \(httpResponse.statusCode)")

                if httpResponse.statusCode == 200 {
                    DispatchQueue.main.async {
                        self.fetchLocations() // Refresh after successful post
                    }
                } else if httpResponse.statusCode == 401 {
                    print("⚠️ Unauthorized. Check your user/pass!")
                }
            }
        }.resume()
    }

}
