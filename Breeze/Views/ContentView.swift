import SwiftUI

struct ContentView: View {
    @State private var input = Input()
    
    var body: some View {
        VStack {
            DisplayView(input: $input)
            ButtonPanelView(input: $input)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
