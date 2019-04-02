# Memory Leak 

目標：討論在closure中產生的memory leak

## 起因

在closure中的call back使用self，會引起memory leak，可以修改如下解決：

```swift
DispatchQueue.global().async { [weak self] in
	guard let sSelf = self else {
		return
	}
	
	sSelf.test()
	
	DispatchQueue.main.async {
	}
}
```