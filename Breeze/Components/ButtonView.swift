import SwiftUI

enum ButtonType {
    case primary, accent, highlight
}

extension ButtonType {
    var color: Color {
        switch self {
        case .primary:
            return Settings.standard.theme.textPrimary
        case .accent:
            return Settings.standard.theme.textAccent
        case .highlight:
            return Settings.standard.theme.textHighlight
        }
    }
}

struct ButtonView: View {
    let text: Text
    let type: ButtonType
    let handle: () -> ()
    
    init(_ text: Text, type: ButtonType = .primary, onTap: @escaping () -> ()) {
        self.text = text
        self.type = type
        self.handle = onTap
    }
    
    init(_ text: String, type: ButtonType = .primary, onTap: @escaping () -> ()) {
        self.text = Text(text)
        self.type = type
        self.handle = onTap
    }
    
    var body: some View {
        Button(action: handle) {
            self.text
                .scaledToFill()
                .minimumScaleFactor(0.5)
                .lineLimit(1)
        }
            .foregroundColor(type.color)
            .buttonStyle(MyButtonStyle())
    }
}

struct MyButtonStyle: ButtonStyle {
  func makeBody(configuration: Self.Configuration) -> some View {
    configuration.label
      .padding()
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(configuration.isPressed ? Color(rgb: 0xCCCCCC) : Color.clear)
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
