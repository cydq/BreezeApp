//
//  ButtonPanelView.swift
//  Breeze
//
//  Created by Brian Shao on 2022-07-03.
//

import SwiftUI

struct ButtonPanelView: View {
    @Binding var input: Input
    
    var body: some View {
        VStack {
            HStack {
                ButtonView("AC", type: .highlight) { input.clear() }
                
                ButtonView("(") { input.push(.open) }
                ButtonView(")") { input.push(.close) }
                
                ButtonView("<", type: .highlight) { input.delete() }
            }
            
            HStack {
                ButtonView("7") { input.push(.seven) }
                ButtonView("8") { input.push(.eight) }
                ButtonView("9") { input.push(.nine) }
                
                ButtonView("/", type: .accent) { input.push(.divide) }
            }
            
            HStack {
                ButtonView("4") { input.push(.four) }
                ButtonView("5") { input.push(.five) }
                ButtonView("6") { input.push(.six) }
                
                ButtonView("x", type: .accent) { input.push(.times) }
            }
            
            HStack {
                ButtonView("1") { input.push(.one) }
                ButtonView("2") { input.push(.two) }
                ButtonView("3") { input.push(.three) }
                
                ButtonView("-", type: .accent) { input.push(.minus) }
            }
            
            HStack {
                ButtonView(",") { input.push(.comma) }
                ButtonView("0") { input.push(.zero) }
                ButtonView(".") { input.push(.dot) }
                ButtonView("+", type: .accent) { input.push(.plus) }
            }
            
            HStack {
                ButtonView("CFG") {}
                ButtonView("HIST") {}
                ButtonView("ANS") {}
                ButtonView("=") {
                    guard let result: Double = evaluate(expr: input.string) else {
                        return
                    }
                    
                    input.clear()
                    input.push(String(result))
                }
            }
        }
            .padding()
            .background(currentTheme.background)
    }
}

struct ButtonPanelView_Previews: PreviewProvider {
    @State static var input = Input()
    
    static var previews: some View {
        VStack {
            Text("input: " + input.string)
                .frame(minHeight: 250)
            
            ButtonPanelView(input: $input)
        }
    }
}
