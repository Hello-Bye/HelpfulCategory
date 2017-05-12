# HelpfulCategory
一些常用的分类
# PS: 目的主要是为了测试让git库支持cocoapods

### Use CocoaPods install
在项目根目录下创建Podfile，[Podfile的例子](http://guides.cocoapods.org/syntax/podfile.html#podfile)

```
platform :ios, '8.0'
 
target "MyApp" do
  pod 'HelpfulCategory', '~> 0.0.3'
end
```
#### 安装Pods
安装 pods

```
$ pod install
```
#### 更新 pods

```
$ pod update
```
