# HKWorkoutSession

目標：在Watch上實現運動流程

## 步驟

使用```HKWorkoutSession```來實現在watch上面的運動流程，宣告：

```swift
var workoutSession : HKWorkoutSession?
```

執行：

```swift
let workoutConfiguration = HKWorkoutConfiguration()
workoutConfiguration.activityType = .running
workoutConfiguration.locationType = .outdoor
        
do {
	workoutSession = try HKWorkoutSession(healthStore: hrHealthStore, configuration: workoutConfiguration)
	workoutSession?.delegate = self
} catch {
	fatalError("Unable to create the workout session!")
}

workoutSession?.startActivity(with: Date())
```

執得注意的是如果要在watchOS4之前執行，必須使用：

```swift
workoutHealthStore.start(workoutSession!)
```

所以不同版本判斷可以使用：

```swift
if #available(watchOS 5, *) {
	workoutSession?.startActivity(with: Date())
}
else {
	workoutHealthStore.start(workoutSession!)
}
```