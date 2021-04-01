# stateful_loader

A simple mixin that manages the loader state for you just by calling
showLoader and hideLoader

## Getting Started

1. Use the mixin in your widget's State

```dart
class MyHomePageState extends State<MyHomePage> with LoadingWidget {
//...
 } 
```

2. Call mixin methods to show/hide a loader

```dart
showLoading(context); 
//...
hideLoading();
```

3. Override mixin methods to customize the loader experience

```dart
class MyHomePageState extends State<MyHomePage> with LoadingWidget {
 
@override
 bool get barrierDismissible => true;

@override
  Widget get loaderWidget =>  CircularProgressIndicator();

//...
}
```

