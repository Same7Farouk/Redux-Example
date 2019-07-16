//
//  Reducers.swift
//  RPS-Game-Redux
//
//  Created by Sameh Farouk on 7/16/19.
//  Copyright © 2019 Sameh Farouk. All rights reserved.
//

import ReSwift

// MARK:- REDUCERS

func appReducer(action: Action, state: AppState?) -> AppState {
    
    // creates a new state if one does not already exist
    var state = state ?? AppState()
    
    if state.result == .draw {
        state.result = nil
    }
    
    switch action {
    case let chooseWeaponAction as ChooseWeaponAction:
        
        let turn = state.turn
        switch turn.player {
        case .one:
            
            // create a play
            let play = Play(chosen: true, weapon: chooseWeaponAction.weapon)
            state.player1Play = play
            
            // pass the turn to the next player
            state.turn = Turn(player: .two)
            
            // change the message
            state.message = .player2choose
            
        case .two:
            
            // create a play
            let play = Play(chosen: true, weapon: chooseWeaponAction.weapon)
            state.player2Play = play
            
            // calculate who won
            let player1weapon = state.player1Play.weapon ?? .rock
            let player2weapon = state.player2Play.weapon ?? .rock
            
            switch player1weapon {
            case .rock:
                switch player2weapon {
                case .rock:
                    state.result = .draw
                    state.message = .draw
                case .paper:
                    state.result = .player2wins
                    state.message = .player2wins
                case .scissors:
                    state.result = .player1wins
                    state.message = .player1wins
                }
            case .paper:
                switch player2weapon {
                case .rock:
                    state.result = .player1wins
                    state.message = .player1wins
                case .paper:
                    state.result = .draw
                    state.message = .draw
                case .scissors:
                    state.result = .player2wins
                    state.message = .player2wins
                }
            case .scissors:
                switch player2weapon {
                case .rock:
                    state.result = .player2wins
                    state.message = .player2wins
                case .paper:
                    state.result = .player1wins
                    state.message = .player1wins
                case .scissors:
                    state.result = .draw
                    state.message = .draw
                }
            }
        }
        
    default:
        state = AppState()
    }
    
    if state.result == .draw {
        state.player1Play.weapon = nil
        state.player2Play.weapon = nil
        state.player1Play.chosen = false
        state.player2Play.chosen = false
        state.turn = Turn(player: .one)
    }
    // return the new state
    return state
}

