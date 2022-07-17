import SwiftUI

struct ButtonPanelView: View {
    @Binding var input: Input
    
    var body: some View {
        VStack {
            HStack {
                ButtonView("AC", type: .highlight) { input.clear() }
                
                ButtonView("(") { input.push(Token(.open)) }
                ButtonView(")") { input.push(Token(.close)) }
                
                ButtonView("<", type: .highlight) { input.delete() }
            }
            
            HStack {
                ButtonView("7") { input.push(Token(.seven)) }
                ButtonView("8") { input.push(Token(.eight)) }
                ButtonView("9") { input.push(Token(.nine)) }
                
                ButtonView("/", type: .accent) { input.push(Token(.divide)) }
            }
            
            HStack {
                ButtonView("4") { input.push(Token(.four)) }
                ButtonView("5") { input.push(Token(.five)) }
                ButtonView("6") { input.push(Token(.six)) }
                
                ButtonView("x", type: .accent) { input.push(Token(.times)) }
            }
            
            HStack {
                ButtonView("1") { input.push(Token(.one)) }
                ButtonView("2") { input.push(Token(.two)) }
                ButtonView("3") { input.push(Token(.three)) }
                
                ButtonView("-", type: .accent) { input.push(Token(.minus)) }
            }
            
            HStack {
                ButtonView(",") { input.push(Token(.comma)) }
                ButtonView("0") { input.push(Token(.zero)) }
                ButtonView(".") { input.push(Token(.dot)) }
                ButtonView("+", type: .accent) { input.push(Token(.plus)) }
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
                    input.push(.literal(String(result)))
                }
            }
        }
            .padding()
            .background(Settings.standard.theme.background)
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
