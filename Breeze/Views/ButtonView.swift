//
//  ButtonView.swift
//  Breeze
//
//  Created by Brian Shao on 2022-07-03.
//

import SwiftUI

struct ButtonView: View {
    let text: String
    let handle: () -> ()
    
    init(_ text: String, onTap: @escaping () -> ()) {
        self.text = text
        self.handle = onTap
    }
    
    var body: some View {
        Button(text, action: handle)
            .buttonStyle(MyButtonStyle())
    }
}

struct MyButtonStyle: ButtonStyle {
  func makeBody(configuration: Self.Configuration) -> some View {
    configuration.label
      .padding()
      .frame(maxWidth: .infinity, maxHeight: .infinity)
//      .foregroundColor(.black)
      .background(configuration.isPressed ? Color.gray : Color.clear)
      .cornerRadius(8.0)
  }
}


struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView("4") {}
            .previewLayout(.sizeThatFits)
    }
}
