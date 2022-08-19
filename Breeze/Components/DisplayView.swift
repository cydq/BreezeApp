import SwiftUI

struct DisplayView: View {
    @Binding var input: Input
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                input.display
                    .font(.largeTitle)
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(Settings.standard.theme.textPrimary)
                    .padding()
                    .lineLimit(1)
                    .truncationMode(.head)
            }
            
            HStack {
                Spacer()
                
                Text(evaluateOr(expr: input.expr))
                    .font(.title)
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(Settings.standard.theme.textHighlight)
                    .padding()
                    .lineLimit(1)
            }
        }
            .frame(minHeight: 200)
            .background(Settings.standard.theme.backgroundDisplay)
    }
}

struct DisplayView_Previews: PreviewProvider {
    @State private static var input = ({ () -> Input in
        var input = Input()
        input.push(Token(.three))
        input.push(Token(.times))
        input.push(Token(.stddev))
        input.push(Token(.three))
        input.push(Token(.four))
        input.push(Token(.comma))
        input.push(Token(.cos))
        input.push(Token(.nine))
        input.push(Token(.close))
        input.push(Token(.close))
        return input
    })()
    
    static var previews: some View {
        VStack {
            input.display
            
            Text(input.expr)
            
            Text(evaluate(expr: input.expr))
            
            DisplayView(input: $input)
        }
    }
}
