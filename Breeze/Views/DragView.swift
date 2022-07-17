//
//  DragView.swift
//  Breeze
//
//  Created by Brian Shao on 2022/07/16.
//

import SwiftUI

struct DragView: View {
    var body: some View {
        VStack {
            ButtonView("test") {}
            ButtonView("test") {}
            ButtonView("test") {}
            ButtonView("test") {}
        }
    }
}

struct DragView_Previews: PreviewProvider {
    static var previews: some View {
        DragView()
    }
}
