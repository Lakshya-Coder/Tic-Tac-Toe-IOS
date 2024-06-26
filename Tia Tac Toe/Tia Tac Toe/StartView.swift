//
//  ContentView.swift
//  Tia Tac Toe
//
//  Created by Lakshya Seth on 22/03/24.
//

import SwiftUI

struct StartView: View {
    @EnvironmentObject var game: GameService
    @StateObject var connectionManager: MPConnectionManager
    @State private var gameType: GameType = .undetermined
    @AppStorage("yourName") private var yourName: String = ""
    @State private var opponentName: String = ""
    @FocusState private var focus: Bool
    @State private var startGame: Bool = false
    @State private var changeName = false
    @State private var newName = ""
    init(yourName: String) {
        self.yourName = yourName
        _connectionManager = StateObject(wrappedValue: MPConnectionManager(yourName: yourName))
    }
    var body: some View {
        VStack {
            Picker("Select Game", selection: $gameType) {
                Text("Select Game Type").tag(GameType.undetermined)
                Text("Two Sharing device").tag(GameType.single)
                Text("Challenge your device").tag(GameType.bot)
                Text("Challenge a friend").tag(GameType.peer)
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10, style: .continuous).stroke(lineWidth: 2))
            
            Text(gameType.description)
                .padding()
            
            VStack {
                switch gameType {
                case .single:
                    TextField("Opponent name", text: $opponentName)
                case .bot:
                    EmptyView()
                case .peer:
                    MPPeersView(startGame: $startGame)
                        .environmentObject(connectionManager)
                case .undetermined:
                    EmptyView()
                }
            }
            .padding()
            .textFieldStyle(.roundedBorder)
            .focused($focus)
            .frame(width: 350)
            
            if gameType != .peer {
                Button("Start Game") {
                    game.setupGame(gameType: gameType, player1Name: yourName, player2Name: opponentName)
                    focus = false
                    startGame.toggle()
                }
                .buttonStyle(.borderedProminent)
                .disabled(
                    gameType == .undetermined ||
                    gameType == .single && opponentName.isEmpty
                )
                Image("LaunchScreen")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                Text("Your name is \(yourName)")
                Button("Change my name") {
                    changeName.toggle()
                }
                .buttonStyle(.bordered)
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Tia Tac Toe")
        .fullScreenCover(isPresented: $startGame) {
            GameView()
                .environmentObject(connectionManager)
        }
        .alert("Change name", isPresented: $changeName, actions: {
            TextField("New name", text: $newName)
            Button("OK", role: .destructive) {
                yourName = newName
                exit(-1)
            }
            
            Button("Cancel", role: .cancel) { }
        }, message: {
            Text("Tapping on the OK button will quit the application so you can relaunch to use your changed name.")
        })
        .inNavigationStack()
        
        
    }
}

#Preview {
    StartView(yourName: "Sample")
}
