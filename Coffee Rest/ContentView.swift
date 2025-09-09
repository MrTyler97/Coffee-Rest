//
//  ContentView.swift
//  Coffee Rest
//
//  Created by Vic  on 9/9/25.
//

import SwiftUI

struct ContentView: View {
    
    @State var sleepAmount = 8.0
    
    var body: some View {
        // Stepper adds a +/- counter to a variable to change. From range of 4 to 12 hours
        Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
    }
}

#Preview {
    ContentView()
}
