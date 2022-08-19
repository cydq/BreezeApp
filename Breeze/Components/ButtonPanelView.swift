import SwiftUI

struct ButtonPanelView: View {
    @Binding var input: Input
    
    var body: some View {
        TabView {
            VStack {
                HStack {
                    ButtonTokenView(Token(.square), type: .accent, input: $input)
                    ButtonTokenView(Token(.exp), type: .accent, input: $input)
                    ButtonTokenView(Token(.sqrt), type: .accent, input: $input)
                    ButtonTokenView(Token(.pi), type: .accent, input: $input)
                }
                
                HStack {
                    ButtonView(Text("AC").fontWeight(.bold), type: .highlight) { input.clear() }
                    
                    ButtonTokenView(Token(.open), input: $input)
                    ButtonTokenView(Token(.close), input: $input)
                    
                    ButtonView(Text(Image(systemName: "delete.backward.fill")), type: .highlight) { input.delete() }
                }
                
                HStack {
                    ButtonTokenView(Token(.seven), input: $input)
                    ButtonTokenView(Token(.eight), input: $input)
                    ButtonTokenView(Token(.nine), input: $input)
                    ButtonTokenView(Token(.divide), type: .accent, input: $input)
                }
                
                HStack {
                    ButtonTokenView(Token(.four), input: $input)
                    ButtonTokenView(Token(.five), input: $input)
                    ButtonTokenView(Token(.six), input: $input)
                    ButtonTokenView(Token(.times), type: .accent, input: $input)
                }
                
                HStack {
                    ButtonTokenView(Token(.one), input: $input)
                    ButtonTokenView(Token(.two), input: $input)
                    ButtonTokenView(Token(.three), input: $input)
                    ButtonTokenView(Token(.minus), type: .accent, input: $input)
                }
                
                HStack {
                    ButtonTokenView(Token(.comma), input: $input)
                    ButtonTokenView(Token(.zero), input: $input)
                    ButtonTokenView(Token(.dot), input: $input)
                    ButtonTokenView(Token(.plus), type: .accent, input: $input)
                }
                
                HStack {
                    ButtonTokenView(Token(.percent), type: .accent, input: $input)
                    
                    ButtonView("HIST") {}
                    
                    ButtonTokenView(.answer, type: .accent, input: $input)
                    
                    ButtonView(Text(Image(systemName: "equal")), type: .highlight) { equals() }
                }
            }
            
            VStack {
                HStack {
                    ButtonView(Text("AC").fontWeight(.bold), type: .highlight) { input.clear() }
                    
                    ButtonTokenView(Token(.open), input: $input)
                    ButtonTokenView(Token(.close), input: $input)
                    
                    ButtonView(Text(Image(systemName: "delete.backward.fill")), type: .highlight) { input.delete() }
                }
                
                HStack {
                    ButtonTokenView(Token(.square), input: $input)
                    ButtonTokenView(Token(.cube), input: $input)
                    ButtonTokenView(Token(.exp), input: $input)
                    ButtonTokenView(Token(.ee), input: $input)
                }
                
                HStack {
                    ButtonTokenView(Token(.antiln), input: $input)
                    ButtonTokenView(Token(.antilog), input: $input)
                    ButtonTokenView(Token(.antilog2), input: $input)
                    ButtonTokenView(Token(.sqrt), input: $input)
                }
                
                HStack {
                    ButtonTokenView(Token(.cbrt), input: $input)
                    ButtonTokenView(Token(.ln), input: $input)
                    ButtonTokenView(Token(.log), input: $input)
                    ButtonTokenView(Token(.log2), input: $input)
                }
                
                HStack {
                    ButtonTokenView(Token(.sin), input: $input)
                    ButtonTokenView(Token(.cos), input: $input)
                    ButtonTokenView(Token(.tan), input: $input)
                    ButtonTokenView(Token(.pi), input: $input)
                }
                
                HStack {
                    ButtonTokenView(Token(.asin), input: $input)
                    ButtonTokenView(Token(.acos), input: $input)
                    ButtonTokenView(Token(.atan), input: $input)
                    ButtonTokenView(Token(.e), input: $input)
                }
                
                HStack {
                    ButtonTokenView(Token(.percent), type: .accent, input: $input)
                    
                    ButtonView("HIST") {}
                    
                    ButtonTokenView(.answer, type: .accent, input: $input)
                    
                    ButtonView(Text(Image(systemName: "equal")), type: .highlight) { equals() }
                }
            }
            
            VStack {
                HStack {
                    ButtonView(Text("AC").fontWeight(.bold), type: .highlight) { input.clear() }
                    
                    ButtonTokenView(Token(.open), input: $input)
                    ButtonTokenView(Token(.close), input: $input)
                    
                    ButtonView(Text(Image(systemName: "delete.backward.fill")), type: .highlight) { input.delete() }
                }
                
                HStack {
                    ButtonTokenView(Token(.reciprocal), input: $input)
                    ButtonTokenView(Token(.factorial), input: $input)
                    ButtonTokenView(Token(.nthroot), input: $input)
                    ButtonTokenView(Token(.logn), input: $input)
                }
                
                HStack {
                    ButtonTokenView(Token(.sinh), input: $input)
                    ButtonTokenView(Token(.cosh), input: $input)
                    ButtonTokenView(Token(.tanh), input: $input)
                    ButtonTokenView(Token(.phi), input: $input)
                }
                
                HStack {
                    ButtonTokenView(Token(.asinh), input: $input)
                    ButtonTokenView(Token(.acosh), input: $input)
                    ButtonTokenView(Token(.atanh), input: $input)
                    ButtonTokenView(Token(.rand), input: $input)
                }
                
                HStack {
                    ButtonTokenView(Token(.sum), input: $input)
                    ButtonTokenView(Token(.product), input: $input)
                    ButtonTokenView(Token(.min), input: $input)
                    ButtonTokenView(Token(.max), input: $input)
                }
                
                HStack {
                    ButtonTokenView(Token(.mean), input: $input)
                    ButtonTokenView(Token(.median), input: $input)
                    ButtonTokenView(Token(.mode), input: $input)
                    ButtonTokenView(Token(.stddev), input: $input)
                }
                
                HStack {
                    ButtonTokenView(Token(.percent), type: .accent, input: $input)
                    
                    ButtonView("HIST") {}
                    
                    ButtonTokenView(.answer, type: .accent, input: $input)
                    
                    ButtonView(Text(Image(systemName: "equal")), type: .highlight) { equals() }
                }
            }
                .padding([.top, .leading, .trailing])
        }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .background(Settings.standard.theme.background)
    }
    
    func equals() {
        guard let result: Double = evaluate(expr: input.expr) else {
            return
        }
        
        input.clear()
        input.push(.literal(String(result)))
        
        previousResult = result
    }
}

struct ButtonPanelView_Previews: PreviewProvider {
    @State static var input = Input()
    
    static var previews: some View {
        VStack {
            (Text("input: ") + input.display)
                .frame(minHeight: 200)
            
            ButtonPanelView(input: $input)
        }
    }
}
