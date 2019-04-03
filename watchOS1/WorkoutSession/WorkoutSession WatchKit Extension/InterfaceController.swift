//
//  InterfaceController.swift
//  WorkoutSession WatchKit Extension
//
//  Created by jake on 2019/4/3.
//  Copyright © 2019 Jake. All rights reserved.
//

import WatchKit
import Foundation
import HealthKit

class InterfaceController: WKInterfaceController {
    
    //
    var hrHealthStore = HKHealthStore()
    var workoutHealthStore = HKHealthStore()
    
    var workoutSession : HKWorkoutSession?
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func clickButton() {
        let workoutConfiguration = HKWorkoutConfiguration()
        workoutConfiguration.activityType = .running
        workoutConfiguration.locationType = .outdoor
        
        do {
            workoutSession = try HKWorkoutSession(healthStore: hrHealthStore, configuration: workoutConfiguration)
            workoutSession?.delegate = self
        } catch {
            fatalError("Unable to create the workout session!")
        }
        
        if #available(watchOS 5, *) {
            workoutSession?.startActivity(with: Date())
        }
        else {
            workoutHealthStore.start(workoutSession!)
        }
    }
    
    @IBAction func clickStopButton() {
        if #available(watchOS 5, *) {
            workoutSession?.stopActivity(with: Date())
            workoutSession?.end()
        }
        else {
            workoutHealthStore.end(workoutSession!)
        }
    }
}

extension InterfaceController: HKWorkoutSessionDelegate {
    func workoutSession(_ workoutSession: HKWorkoutSession, didChangeTo toState: HKWorkoutSessionState, from fromState: HKWorkoutSessionState, date: Date) {
        
        print("workoutSession didChangeTo", toState.rawValue, HKWorkoutSessionState.running.rawValue)
        
        if toState == .running {
        }
        else if toState == .paused {
        }
        else if toState == .ended {
        }
        else {
        }
    }
    
    func workoutSession(_ workoutSession: HKWorkoutSession, didFailWithError error: Error) {
        print("workoutSession didFailWithError", error)
    }
}
