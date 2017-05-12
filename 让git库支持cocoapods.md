# 让git库支持cocoapods
##### ps：要让一个git库支持cocoapods，大致需要这几步：
1. 创建git库、添加.gitignore、README、LICENSE （LICENSE必须要有、其他可选、建议加上）
2. 添加.podspec/编辑.podspec （最最最重要的一点）
3. 添加tag、验证.podspec （cocoapods依赖tag所以必须打tag、第三点编辑不对验证.podspec会报各种错误）
4. 注册cocoapods
5. 发布 （如果没有意外、到这里就大功告成了）

#### 废话不多说，直接上干货！！！
## 1. 创建git库
如何使用git库这里不多赘述，git平台不是唯一的，这里以github为例
在创建git库的时候，.gitignore、README、LICENSE这些都是可以自动生成的，不用过多在意，值得提一点的是：生成LICENSE的时候选择MIT就行了

## 2. 创建.podspec
首先cd到你的git库的根目录下
这里需要使用指令 -pod spec create MyProject   之后会得到一个文件MyProject.podspec
或者你也可以找别人写好的.podspec文件拿过来直接修改也可以
注意：MyProject是你git库的名字，MyProject.podspec这个文件名需要和你的git名字一致

## 3. 编辑.podspec
打开创建好的.podspec文件，删除注释, 前面有#的为注释, 如果你想知道每个东西的含义也可以了解一下

```
Pod::Spec.new do |s|

  s.name         = "MyProject"
  s.version      = "0.0.1"
  s.summary      = "A helpful category."

  s.description  = "A description of HelpfulCategory."

  s.homepage     = "https://github.com/My/MyProject"

  s.license      = "MIT"
  # s.license    = { :type => "MIT", :file => "FILE_LICENSE" }

  s.author       = { "Chenzuliang" => "chenzuliang@geek-zoo.com" }
  s.requires_arc = true

  s.platform     = :ios, "7.0"
  s.ios.deployment_target = "7.0"

  # s.frameworks = "UIKit", "Foundation", "CoreGraphics"
  # s.library = "sys"

  s.source       = { :git => "https://github.com/My/MyProject.git", :tag => s.version }

  s.source_files  = "MyProject/**/*.{h,m}"
  # s.exclude_files = "MyProject/**/*.{h,m}"
end
```
接下来讲解一下每行代码的含义:

- s.name：名称，pod search 搜索的关键词,注意这里一定要和.podspec的名称一样,否则报错
- s.version：版本号
- s.ios.deployment_target:  支持的pod最低版本
- s.summary: 简介
- s.homepage: 项目主页地址
- s.license: 许可证
- s.author: 作者
- s.social_media_url: 社交网址
- s.source: 项目的地址
- s.source_files: 需要包含的源文件，写法及含义建议大家写第一种或者第二种
	1. "MyProject/*"
	2. "MyProject/yoowei/*.{h,m}"
	3. "MyProject/** /*.h"
		- “*” 表示匹配所有文件
		- “*.{h,m}” 表示匹配所有以.h和.m结尾的文件
		- “**” 表示匹配所有子目录
- s.resources: 资源文件
- s.requires_arc: 是否支持ARC
- s.dependency：依赖库，不能依赖未发布的库
- s.dependency：依赖库，如有多个可以这样写

### 另外：
1. 引用静态库: "(.ios).library"。去掉头尾的lib，用","分割。 注意： (.ios)括号括起来代表可以省略：

	例如: 引用 libxml2.lib 和 libz.lib.   
	`s.libraries = 'xml2', 'z'`
2. 引用公有framework: "(.ios).framework" 用","分割. 去掉尾部的".framework"
`s.frameworks = 'UIKit','SystemConfiguration', 'Accelerate'`
3. 引用自己生成的framework: "(.ios).vendored_frameworks" 用","分割 路径写从.podspec所在目录为根目录的相对路径 

	ps: 这个不要省略.framework `s.ios.vendored_frameworks = 'Pod/Assets/*.framework'`
4. 引用自己生成的.a文件, 添加到Pod/Assets文件夹里. Demo的Example文件夹里也需要添加一下, 不然找不到
`spec.ios.vendored_libraries = 'Pod/Assets/*.a'`

##### 注意：在提交到私有仓库的时候需要加上`--use-libraries `
#### ps: 更多的可以参考其他成熟的开源库的.podspec文件的编写

## 4. 创建LICENSE(许可证/授权)文件,此文件必须要有
创建一个文件名字命名为LICENSE，内容如下：

```
MIT LicenseCopyright (c) 2017Permission is hereby granted, free of charge, to any person obtaining a copy

of this software and associated documentation files (the "Software"), to deal

in the Software without restriction, including without limitation the rights

to use, copy, modify, merge, publish, distribute, sublicense, and/or sell

copies of the Software, and to permit persons to whom the Software is

furnished to do so, subject to the following conditions:The above copyright notice and this permission notice shall be included in all

copies or substantial portions of the Software.THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR

IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,

FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE

AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER

LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,

OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE

SOFTWARE.
```
只需要把前面的版权改一下就行了, 后面的都一样
##### ps: 一般我们创建仓库的时候，大多数已经创建好了的

## 5. 上传git、打tag
将包含配置好的 .podspec, LICENSE 的项目提交 Git仓库， 然后打上tag。

因为cocoapods是依赖tag版本的, 所以必须打tag。以后每次更新只需要把你的项目打一个tag，然后修改.podspec文件中的版本号，接着提交到cocoapods官方就可以了。
##### 注意: 一定将tag提交到远程仓库，这一步很重要

## 6. 验证.podspec
前面的步骤通常都很顺利，到这里一般就开始踩坑了，如果你前面编写.podspec时出错了，这里是验证不过的，但好在通常错误信息都比较明显，照着改就好了

执行`-pod spec lint yooweiTest.podspec --verbose`
成功后会提示`MyProject passed validation.`

#### 前段时间操作遇到的错误和警告：
警告可以`--allow-warnings`忽略掉，但error必须解决

遇到错误：

```
- ERROR | name: The name of the spec should match the name of the file.
```
// 这个是要保证.podspe文件的名称和里面s.name保持一致

```
- ERROR | [iOS] xcodebuild: Returned an unsuccessful exit code. You can use '--verbose' for more information.
```
 // 这个当时困惑了我好久，查了好多资料，很多原因都会报着个错，我这里是多引用了framework， 注释掉这个解决的`s.frameworks = "UIKit", "Foundation", "CoreGraphics"`
 
## 7. 注册Trunk
如果要添加到Cocoapods的官方库了，可以使用trunk工具，具体可以查看官方文档。如果是私有库的话，详见：http://www.cnblogs.com/richard-youth/p/6289015.html

trunk需要CocoaPods 0.33版本以上，用pod --version 命令查看版本，如果CocoaPods版本低，需要升级。已经注册过的不需要注册,查看自己有没有注册`-pod trunk me`

```
- Name:     yoowei 
- Email:    yoowei@126.com 
- Since:    January 12th, 04:38 
- Pods:     None 
- Sessions:    - January 12th, 04:38 - May 21st, 03:35. IP: 218.205.57.27
```
看到这个就说明你已经注册过了，如果没有注册的话  [!] You need to register a session first.
#### 注册：`pod trunk register yoowei@126.com "yoowei" --verbose`
 [!] Please verify the session by clicking the link in the verification email that has been sent to yoowei@126.com
注册完成之后会给你的邮箱发个邮件,进入邮箱邮件里面有个链接,需要点击确认一下。

#### 更新cocoapods版本  
`-sudo gem install cocoapods -n /usr/local/bin `

注意：如果上面这句指令不加 `-n/usr/local/bin` 可能会报错：

```
ERROR:  While executing gem ... (Errno::EPERM)
    Operation not permitted - /usr/bin/pod
```

## 9. 发布
发布时会验证 Pod 的有效性，如果你在手动验证 Pod 时使用了 --use-libraries 或 --allow-warnings 等修饰符，那么发布的时候也应该使用相同的字段修饰，否则出现相同的报错。

```
-pod trunk push MyProject.podspec
// --use-libraries --allow-warnings
// -pod lib lint --allow-warnings 
// -pod lib lint --use-libraries
```
成功了之后会出现以下内容：

```
--------------------------------------------------------------------------------
 🎉  Congrats

 🚀  HelpfulCategory (0.0.3) successfully published
 📅  May 10th, 23:56
 🌎  https://cocoapods.org/pods/HelpfulCategory
 👍  Tell your friends!
--------------------------------------------------------------------------------
```

之后你就可以`-pod search MyProject`搜索到你的git库了， 提示：可能会有一点延迟，如果一切成功，还搜索不到的话稍后再搜就可以了
### 但是：这里我遇到问题了,很久时间过去了，`pod search`依然找不到，开始各种尝试，最终发现，是因为我`pod setup`成功后会生成~/Library/Caches/CocoaPods/search_index.json文件。而问题就在这里。
`rm ~/Library/Caches/CocoaPods/search_index.json`
删除这个文件再次`pod search`
`Creating search index for spec repo 'master'.. Done!`成功了。