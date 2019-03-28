# 常數與變數

## 宣告常數或變數

使用 ```let``` 宣告常數，```var``` 宣告變數：

~~~swift
let x = 5
var hello = "hello"
~~~

常數與變數的差別就是變數可以更改，常數不能更改：

~~~swift
let x = 5
var hello = "hello"

hello = "hello world"
x = 6    // 錯誤！常數不能更改
~~~

熟悉 Objective-C 的人可能會想需不需要在結尾處加上分號，答案是可加可不加：

~~~swift
let x = 5
var hello = "hello";    // 加上分號也可以
~~~

但是有一種情況一定要加上分號，就是一行程式有兩個描述：

~~~swift
let x = 5; var hello = "hello";
~~~

但盡量不要將程式這樣寫，很難一眼讀懂內容。

常數與變數的命名方式不能包含 ```數學符號``` ```箭頭``` ```box-drawing characters```，不能以數字為開頭，但可以在中段或結尾包含數字。

## 輸出

一般在開發的過程中會需要知道是否有發生邏輯錯誤，所以會將變數或常數輸出到 Xcode 的 Console 視窗之上：

~~~swift
print(x)               // 輸出一般常數
print("hello \(x)")    // 將字串與常數整合輸出
~~~

## 型別

型別就是宣告常數或變數為字串或整數，當變數或常數有加上型別，就不能更改為其他型別：

~~~swift
var s: String        // 宣告為字串
s = "hello world"

s = 5               // 錯誤！不能將整數指派給字串型別的變數
~~~

可以在一行之中定義多個常數或變數的型別：

~~~swift
var s1, s2, s3: String
~~~

## 整數

分成有號(正、負、零)與無號(正、零)整數

有號:

- Int：在32位元平台上就是32位元整數，在64位元平台上就是64位元整數
- Int8：8位元整數
- Int16：16位元整數
- Int32：32位元整數
- Int64：64位元整數

同理，不能將字串指派給整數型別的變數

~~~swift
var x: Int
x = 1
x = "hello" // 錯誤！
~~~
	
無號整數也分成 UInt、UInt8、UInt16、UInt32、UInt64。

## 浮點數

分成 Float(32位元) 與 Double(64位元)

~~~swift
var x: Float
var y: Double
~~~

## 型別安全

swift 是一個型別安全的語言，會自動判斷變數或常數該給予什麼樣的型別：

~~~swift
var x = 1          // 為整數
var y = 0.1        // 為Double。Swift會選擇Double，而不會選Float
var z = 1 + 0.1    // 為Double
~~~

## 數字型字面量

可以加上前綴來表示其它進制：

~~~swift
let decimalInteger = 17
let binaryInteger = 0b10001      // 二進制的 17
let octalInteger = 0o21          // 八進制的 17
let hexadecimalInteger = 0x11    // 十六進制的 17
~~~

也可以加上底線來加強可讀性：

~~~swift
let x = 1_000      // x = 1000
let y = 0.000_1    // y = 0.0001
~~~

## 整數與浮點數轉換

整數轉成浮點數：

~~~swift
let x = 3
let y = 3.1
let z = Double(x) + y    // z = 6.1
~~~

浮點數轉整數：

~~~swift
let x = 3
let y = 3.1
let z = x + Int(y)    // z = 6
~~~

## Tuples

Tuples 可以將多個值組合成一個複合值：

~~~swift
var x = (1, "hello")

print(x.0)    // 輸出 1
print(x.1)    // 輸出 hello
~~~

分解 tuples：

~~~swift
var x = (1, "hello")
let (num, str) = x

print(num)    // 輸出 1
print(str)    // 輸出 hello
~~~

如果只需要一部分的 tuples，可以用```_```來取代：

~~~swift
var x = (1, "hello")
let (num, _) = x
~~~

也可以在宣告時候直接定義名稱：

~~~swift
var x = (num: 1, str: "hello")

print(x.num)
print(x.str)
~~~