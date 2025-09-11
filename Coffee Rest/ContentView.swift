//
//  ContentView.swift
//  Coffee Rest
//
//  Created by Vic  on 9/9/25.
//

import SwiftUI
import CoreML

struct ContentView: View {
    
    @State var sleepAmount = 8.0
    @State var wakeUp = Date.now
    @State var coffeIntake = 1
    @State var alertTitle = ""
    @State var alertMessage = ""
    @State var alertShowing = false
    
    func calculateSleep(){
        // Catch potenial errors in loading/running model
        do{
            // Create the model with appropriate configurations
            let model = try SleepPredictor(configuration: MLModelConfiguration())
            // Extract only hour and minutes data
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            // Convert hour and minutes to seconds from midnight (today)
            let hours = (components.hour ?? 0) * 60 * 60
            let minutes = (components.minute ?? 0) * 60
            // Get prediction model needs 3 input params desired wake up time (in seconds), desired sleep time (in hours), and number of coffe cups consumed.
            let prediction = try model.prediction(wake: Double(hours + minutes), estimatedSleep: sleepAmount , coffee: Double(coffeIntake))
            // Subtract desired wake up time from predicted sleep
            let sleepTime = wakeUp - prediction.actualSleep
            alertTitle = "Your preferred bed time is... "
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
        } catch{
            alertTitle = "Error"
            alertMessage = "There was a problem getting your prediction"
        }
        
        alertShowing = true
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
            .navigationTitle("Coffee Rest")
            .padding()
            .alert(alertTitle, isPresented: $alertShowing){
                Button("Ok") {}
            } message: {
                Text(alertMessage)
            }
            Button("Ask AI", action: calculateSleep)
        }
    }
}

#Preview {
    ContentView()
}
