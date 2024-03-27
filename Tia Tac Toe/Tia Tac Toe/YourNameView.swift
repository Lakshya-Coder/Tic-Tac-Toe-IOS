//
//  YourNameView.swift
//  Tia Tac Toe
//
//  Created by Hardik Seth on 24/03/24.
//

import SwiftUI

struct YourNameView: View {
    @AppStorage("yourName") var yourName = ""
    @State private var userName = ""
    var body: some View {
        VStack {
            Text("This is the name that will be associated with this device.")
            TextField("Your name", text: $userName)
                .textFieldStyle(.roundedBorder)
            Button("Set") {
                yourName = userName
            }
            .buttonStyle(.borderedProminent)
            .disabled(userName.isEmpty)
            
            Image("LaunchScreen")
            Spacer()
        }
        .padding()
        .navigationTitle("Tia Tac Toe")
        .inNavigationStack()
    }
}

#Preview {
    YourNameView()
}
