//
//  ButtonView.swift
//  Breeze
//
//  Created by Brian Shao on 2022-07-03.
//

import SwiftUI

enum ButtonType {
    case primary, accent, highlight
}

extension ButtonType {
    var color: Color {
        switch self {
        case .primary:
            return currentTheme.textPrimary
        case .accent:
            return currentTheme.textAccent
        case .highlight:
            return currentTheme.textHighlight
        }
    }
}

struct ButtonView: View {
    let text: String
    let type: ButtonType
    let handle: () -> ()
    
    init(_ text: String, type: ButtonType = .primary, onTap: @escaping () -> ()) {
        self.text = text
        self.type = type
        self.handle = onTap
    }
    
    var body: some View {
        Button(text, action: handle)
            .foregroundColor(type.color)
            .buttonStyle(MyButtonStyle())
    }
}

struct MyButtonStyle: ButtonStyle {
  func makeBody(configuration: Self.Configuration) -> some View {
    configuration.label
      .padding()
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(configuration.isPressed ? Color.gray : Color.clear)
      .cornerRadius(8.0)
  }
}


struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ButtonView("4") {}
                .previewLayout(.sizeThatFits)
            
            ButtonView("5", type: .accent) {}
                .previewLayout(.sizeThatFits)
            
            ButtonView("6", type: .highlight) {}
                .previewLayout(.sizeThatFits)
        }
    }
}
