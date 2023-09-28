//
//  SceneUserPage+ViewModel.swift
//  MM
//
//  Created by Nico Dioso on 9/28/23.
//

import SwiftUI

extension SceneUserPage {
    @MainActor
    class ViewModel: ObservableObject {
        
        let clientNetwork: ClientNetwork
        @Published var imageData: Data? = nil
        @Published var isErrorShown = true
        
        init(clientNetwork: ClientNetwork) {
            self.clientNetwork = clientNetwork
        }
        
        func downloadUserImageData(_ urlString: String) async {
            do {
                guard let imageUrl = URL(string: urlString)
                else {
                    throw URLError.invalidString
                }
                let imageService = ImageDownloadService(url: imageUrl)
                imageData = try await clientNetwork.request(Data.self, on: imageService)
            } catch {
                isErrorShown = true
            }
        }
        
        func openProfile(_ urlString: String) {
            guard let url = URL(string: urlString)
            else {
                isErrorShown = true
                return
            }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
