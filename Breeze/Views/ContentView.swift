//
//  ContentView.swift
//  Breeze
//
//  Created by Brian Shao on 2022-07-01.
//

import SwiftUI

struct ContentView: View {
    @State private var expr: String = ""
    @State private var result: String = ":p"
    
    var body: some View {
        VStack {
            TextField("Expression", text: $expr.onChange { _ in
                result = evaluate(expr: expr)
            })
                .padding()
        
            Text("= " + (result))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
