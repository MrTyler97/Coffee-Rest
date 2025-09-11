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
    @State var coffeIntake = 1
    
    // Use DateComponets when you want to extract specific information.
    func exampleDates() -> DateComponents {
        // Extract only hour and minute
        let components = Calendar.current.dateComponents([.hour, .minute], from: .now)
        return components
    }
    
    func calculateSleep(){
        
    }
    
    
    var body: some View {
        NavigationStack{
            VStack{
                Text("When do you want to wake up?")
                    .font(.headline)
                // Date picker allows us to choose dates. Can only use Date object not DateComponents
                DatePicker("Select a wake up time" , selection: $wakeUp, displayedComponents:  .hourAndMinute)
                    .labelsHidden()
                    .padding()
                
                Text("Desired amount of sleep?")
                    .font(.headline)
                // Stepper adds a +/- counter to a variable to change. From range of 4 to 12 hours
                Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                    .padding()
                
                Text("How much coffee did you intake?")
                    .font(.headline)
                Stepper("\(coffeIntake) cups", value: $coffeIntake, in: 1...10)
                    .padding()
                
            }
            .navigationTitle("CoffeeRest")
            .padding()
            Button("Calculate", action: calculateSleep)
            
        }
    }
}

#Preview {
    ContentView()
}
