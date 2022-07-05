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
            Spacer()
            Text(input.string)
            Spacer()
            Text(evaluate(expr: input.string))
            Spacer()
        }
            .frame(minHeight: 250)
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
