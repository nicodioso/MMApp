//
//  SceneHome.swift
//  MM
//
//  Created by Nico Dioso on 9/28/23.
//

import SwiftUI

struct SceneHome: View {
    
    private let urlsession = URLSession.shared
    @ObservedObject var viewModel = ViewModel(clientNetwork: ClientNetworkLive.shared)
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(viewModel.users) { user in
                        NavigationLink {
                            SceneUserPage(user: user) { deletedUserId in
                                viewModel.delete(userId: deletedUserId)
                            }
                        } label: {
                            VStack(alignment: .leading) {
                                Text(user.username)
                                    .font(.headline)
                                Text(user.profileUrl)
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                        }.foregroundColor(.black)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical)
            }
            .task {
                await viewModel.getUsers()
            }
            .navigationTitle("MM app")
        }
    }
}

struct SceneHome_Previews: PreviewProvider {
    static var previews: some View {
        SceneHome()
    }
}

/*
 - https://api.github.com/users
 - it has the ability to list all the Github users
 - In first page, list all the Github users displaying their *username and the github* profile url below.
 - Once the user clicks a username, he should be able to redirected to second page to display the *avatar, username and the github profile url* (html_url)
 - When a user clicks a github profile url it will open external browser to load the url.
 */
