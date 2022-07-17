import SwiftUI

struct ButtonPanelView: View {
    @Binding var input: Input
    
    var body: some View {
        TabView {
            VStack {
                HStack {
                    ButtonView("^2", type: .accent) { input.clear() }
                    ButtonView("x^y", type: .accent) { input.push(Token(.open)) }
                    ButtonView("sqrt", type: .accent) { input.push(Token(.close)) }
                    ButtonView("pi", type: .accent) { input.delete() }
                }
                
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
                    ButtonView("%", type: .accent) {}
                    ButtonView("HIST") {}
                    ButtonView("ANS", type: .accent) {}
                    ButtonView("=", type: .highlight) { equals() }
                }
            }
            
            VStack {
                HStack {
                    ButtonView("AC", type: .highlight) { input.clear() }
                    
                    ButtonView("(") { input.push(Token(.open)) }
                    ButtonView(")") { input.push(Token(.close)) }
                    
                    ButtonView("<", type: .highlight) { input.delete() }
                }
                
                HStack {
                    ButtonView("x^2") { input.push(Token(.square)) }
                    ButtonView("x^3") { input.push(Token(.cube)) }
                    ButtonView("x^y") { input.push(Token(.exp)) }
                    ButtonView("EE") { input.push(Token(.ee)) }
                }
                
                HStack {
                    ButtonView("e^x") { input.push(Token(.antiln)) }
                    ButtonView("10^x") { input.push(Token(.antilog)) }
                    ButtonView("2^x") { input.push(Token(.antilog2)) }
                    ButtonView("sqrt") { input.push(Token(.sqrt)) }
                }
                
                HStack {
                    ButtonView("cbrt") { input.push(Token(.cbrt)) }
                    ButtonView("ln") { input.push(Token(.ln)) }
                    ButtonView("log") { input.push(Token(.log)) }
                    ButtonView("log2") { input.push(Token(.log2)) }
                }
                
                HStack {
                    ButtonView("sin") { input.push(Token(.sin)) }
                    ButtonView("cos") { input.push(Token(.cos)) }
                    ButtonView("tan") { input.push(Token(.tan)) }
                    ButtonView("pi") { input.push(Token(.pi)) }
                }
                
                HStack {
                    ButtonView("asin") { input.push(Token(.asin)) }
                    ButtonView("acos") { input.push(Token(.acos)) }
                    ButtonView("atan") { input.push(Token(.atan)) }
                    ButtonView("e") { input.push(Token(.e)) }
                }
                
                HStack {
                    ButtonView("CFG") {}
                    ButtonView("HIST") {}
                    ButtonView("ANS", type: .accent) {}
                    ButtonView("=", type: .highlight) { equals() }
                }
            }
            
            VStack {
                HStack {
                    ButtonView("AC", type: .highlight) { input.clear() }
                    
                    ButtonView("(") { input.push(Token(.open)) }
                    ButtonView(")") { input.push(Token(.close)) }
                    
                    ButtonView("<", type: .highlight) { input.delete() }
                }
                
                HStack {
                    ButtonView("1/x") { input.push(Token(.reciprocal)) }
                    ButtonView("x!") { input.push(Token(.factorial)) }
                    ButtonView("nthroot") { input.push(Token(.nthroot)) }
                    ButtonView("logn") { input.push(Token(.logn)) }
                }
                
                HStack {
                    ButtonView("sinh") { input.push(Token(.sinh)) }
                    ButtonView("cosh") { input.push(Token(.cosh)) }
                    ButtonView("tanh") { input.push(Token(.tanh)) }
                    ButtonView("phi") { input.push(Token(.open)) }
                }
                
                HStack {
                    ButtonView("asinh") { input.push(Token(.asinh)) }
                    ButtonView("acosh") { input.push(Token(.acosh)) }
                    ButtonView("atanh") { input.push(Token(.atanh)) }
                    ButtonView("rand") { input.push(Token(.rand)) }
                }
                
                HStack {
                    ButtonView("sum") { input.push(Token(.sum)) }
                    ButtonView("product") { input.push(Token(.product)) }
                    ButtonView("min") { input.push(Token(.min)) }
                    ButtonView("max") { input.push(Token(.max)) }
                }
                
                HStack {
                    ButtonView("mean") { input.push(Token(.mean)) }
                    ButtonView("median") { input.push(Token(.median)) }
                    ButtonView("mode") { input.push(Token(.mode)) }
                    ButtonView("stddev") { input.push(Token(.stddev)) }
                }
                
                HStack {
                    ButtonView("CFG") {}
                    ButtonView("HIST") {}
                    ButtonView("ANS", type: .accent) {}
                    ButtonView("=", type: .highlight) { equals() }
                }
            }
        }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .background(Settings.standard.theme.background)
    }
    
    func equals() {
        guard let result: Double = evaluate(expr: input.string) else {
            return
        }
        
        input.clear()
        input.push(.literal(String(result)))
    }
}

struct ButtonPanelView_Previews: PreviewProvider {
    @State static var input = Input()
    
    static var previews: some View {
        VStack {
            Text("input: " + input.string)
                .frame(minHeight: 200)
            
            ButtonPanelView(input: $input)
        }
    }
}
