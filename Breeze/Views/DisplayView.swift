//
//  DisplayView.swift
//  Breeze
//
//  Created by Brian Shao on 2022-07-03.
//

import SwiftUI

struct DisplayView: View {
    @Binding var input: Input
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                Text(input.string)
                    .font(.largeTitle)
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(currentTheme.textPrimary)
                    .padding()
            }
            
            HStack {
                Spacer()
                
                
                Text(evaluateOr(expr: input.string))
                    .font(.title)
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(currentTheme.textHighlight)
                    .padding()
            }
        }
            .frame(minHeight: 250)
            .background(currentTheme.backgroundDisplay)
    }
}

struct DisplayView_Previews: PreviewProvider {
    @State private static var input = ({ () -> Input in
        var input = Input()
        input.push(.three)
        input.push(.times)
        input.pushFn(.stddev)
        input.push(.three)
        input.push(.four)
        input.push(.comma)
        input.pushFn(.cos)
        input.push(.nine)
        input.push(.close)
        input.push(.close)
        return input
    })()
    
    static var previews: some View {
        DisplayView(input: $input)
    }
}
