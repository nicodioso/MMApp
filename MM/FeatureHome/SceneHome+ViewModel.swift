//
//  SceneHome+ViewModel.swift
//  MM
//
//  Created by Nico Dioso on 9/28/23.
//

import SwiftUI

extension SceneHome {
    @MainActor
    class ViewModel: ObservableObject {
        
        let clientNetwork: ClientNetwork
        
        @Published var isLoading = false
        @Published var users: [User] = []
        @Published var isErrorShown = false
        
        init(clientNetwork: ClientNetwork) {
            self.clientNetwork = clientNetwork
        }
        
        func getUsers() async {
            guard users.isEmpty else { return }
            isLoading = true
            do {
                let users = try await clientNetwork.request([User].self, on: UserService.getAll)
                self.users = users
            } catch {
                isErrorShown = true
            }
            isLoading = false
        }
        
        func delete(userId: Int) {
            guard let userIndex = users.firstIndex(where: { $0.id == userId })
            else { return }
            users.remove(at: userIndex)
        }
    }
}

