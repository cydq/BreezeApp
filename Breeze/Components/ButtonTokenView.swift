//
//  ButtonTokenView.swift
//  Breeze
//
//  Created by Brian Shao on 2022-08-15.
//

import Foundation

import SwiftUI

struct ButtonTokenView: View {
    var input: Binding<Input>
    
    let token: Token
    let type: ButtonType
    
    init(_ token: Token, type: ButtonType = .primary, input: Binding<Input>) {
        self.token = token
        self.type = type
        self.input = input
    }
    
    var body: some View {
        ButtonView(token.icon, type: type) { input.wrappedValue.push(token) }
    }
}

struct ButtonTokenView_Previews: PreviewProvider {
    @State static var input = Input()
    
    static var previews: some View {
        Group {
            ButtonTokenView(Token(.four), input: $input)
                .previewLayout(.sizeThatFits)
            
            ButtonTokenView(Token(.sqrt), type: .accent, input: $input)
                .previewLayout(.sizeThatFits)
            
            ButtonTokenView(Token(.pi), type: .highlight, input: $input)
                .previewLayout(.sizeThatFits)
        }
    }
}
