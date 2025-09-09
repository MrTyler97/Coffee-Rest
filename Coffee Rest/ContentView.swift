//
//  ContentView.swift
//  Coffee Rest
//
//  Created by Vic  on 9/9/25.
//

import SwiftUI

struct ContentView: View {
    
    @State var sleepAmount = 8.0
    @State var wakeUp = Date.now
    
    var body: some View {
        // Stepper adds a +/- counter to a variable to change. From range of 4 to 12 hours
        Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
            .padding()
        // Date picker allows us to choose dates
        DatePicker("Select a wake up time" , selection: $wakeUp, in:
            //Range from now to end of day
            Date.now...Date.now.addingTimeInterval(86400), displayedComponents:  .hourAndMinute)
            .labelsHidden()
    }
}

#Preview {
    ContentView()
}
