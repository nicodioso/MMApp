//
//  SceneUserPage.swift
//  MM
//
//  Created by Nico Dioso on 9/28/23.
//

import SwiftUI

struct SceneUserPage: View {
    
    @ObservedObject var viewModel = ViewModel(clientNetwork: ClientNetworkLive.shared)
    let user: User
    let onDelete: (Int)->()
    
    var body: some View {
        VStack(spacing: 30) {
            Text(user.username)
                .font(.title)
                .fontWeight(.black)
            Rectangle()
                .frame(width: 200, height: 200)
                .overlay {
                    if let imageData = viewModel.imageData,
                       let image = UIImage(data: imageData) {
                        Image(uiImage: image)
                            .resizable()
                    } else {
                        Color.gray
                    }
                }
                .clipShape(Circle())
            Button("Github profile") {
                viewModel.openProfile(user.profileUrl)
            }
            Button("Delete") {
                onDelete(user.id)
            }.foregroundColor(.red)
            Spacer()
        }
        .padding(.top)
        .task {
            await viewModel.downloadUserImageData(user.avatarUrl)
        }
        .alert("Error", isPresented: $viewModel.isErrorShown) {
            Button("Okay") { }
        } message: {
            Text("Something went wrong")
        }
    }
}

struct ImageDownloadService: NetworkService {
    
    let url: URL
    var method: HTTPMethod { .get }
}

struct SceneUserPagePreview: PreviewProvider {
    
    static var previews: some View {
        SceneUserPage(user: .init(id: 1, username: "nicodioso", avatarUrl: "https://hips.hearstapps.com/hmg-prod/images/articles/2016/02/need-to-be-right-1487213312.jpg?crop=0.636xw:1xh;center,top&resize=1200:*", profileUrl: "https://google.com")) { _ in }
    }
}

/*
 - https://api.github.com/users
 - it has the ability to list all the Github users
 - In first page, list all the Github users displaying their *username and the github* profile url below.
 - Once the user clicks a username, he should be able to redirected to second page to display the *avatar, username and the github profile url* (html_url)
 - When a user clicks a github profile url it will open external browser to load the url.
 */
