//
//  AccountView.swift
//  FantasyUniverse
//
//  Created by TarasPeregrinus on 26.07.2022.
//

import SwiftUI

struct AccountView: View {
    @EnvironmentObject var user: User
    @StateObject var viewModel = AccountViewModel()

    var body: some View {
        VStack {
            Text(user.email ?? "Anonymus")
            Button("Log out") {
                viewModel.signOut()
            }
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
