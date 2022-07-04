# router_processor

A new Flutter project.

## Getting Started

This project is a starting point for a Dart
[package](https://flutter.dev/developing-packages/),
a library module containing code that can be shared easily across
multiple Flutter or Dart projects.

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.


注解处理器
cd D:\flutter_router\RouterDemo\plugins\router_processor\lib
dart run main.dart
dart run main.dart -pi D:\project\test_router\lib -po D:\project\test_router\lib\out
dart --no-sound-null-safety run main.dart -pi D:\flutter_router\RouterDemo\lib -po D:\flutter_router\RouterDemo\lib\generated

-pi  输入目录path
-po  输出目录path 


遇到的问题；
1.
    Error: Cannot run with sound null safety, because the following dependencies
    don't support null safety:
    
    For solutions, see https://dart.dev/go/unsound-null-safety
    
    
    dart --no-sound-null-safety run
    flutter run --no-sound-null-safety
    解决方法:
        a.修复版本一致，
        b.命令行添加 --no-sound-null-safety 
        c.studio 的 run configuration 添加 vmoption


2.
    Error: Not found: 'dart:ui'
    解决方法：查看dart项目中是否引用了ui相关的内容，删除即可