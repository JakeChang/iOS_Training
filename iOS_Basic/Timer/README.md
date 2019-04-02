# DispatchSourceTimer

目標：製作可以在背景執行的Timer

## 程式碼

宣告

```swift
var timer: DispatchSourceTimer?
timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.global())
```

執行

```swift
//宣告每一秒執行一次，誤差允許為10微秒
timer?.schedule(deadline: .now(), repeating: .seconds(1), leeway: .milliseconds(10))
        
//每一秒要做的事情
timer?.setEventHandler(handler: {
            
	for i in 1...1000000 {
		print(i)
	}
            
	//將資料提供給前景
	DispatchQueue.main.sync {
                
	}
})
        
//開始執行
timer?.resume()
```

取消

```swift
//取消的方式，如果有suspend，則必須要resume再cancel
timer?.suspend()
timer?.resume()
timer?.cancel()
timer = nil
```
