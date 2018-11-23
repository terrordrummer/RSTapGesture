# RSTapGesture

[![CI Status](https://img.shields.io/travis/terrordrummer/RSTapGesture.svg?style=flat)](https://travis-ci.org/terrordrummer/RSTapGesture)
[![Version](https://img.shields.io/cocoapods/v/RSTapGesture.svg?style=flat)](https://cocoapods.org/pods/RSTapGesture)
[![License](https://img.shields.io/cocoapods/l/RSTapGesture.svg?style=flat)](https://cocoapods.org/pods/RSTapGesture)
[![Platform](https://img.shields.io/cocoapods/p/RSTapGesture.svg?style=flat)](https://cocoapods.org/pods/RSTapGesture)

# A nicer approach to touch events
Adding a gesture recognizer programmatically is a very common operation. In particlar, it's not rare that you would need to respond to touchDown, touchUpIside, touchUpOutside events occurring on some UI components.

This class addresses this specific case by providing a closure chaining syntax which I personally prefer.

With this class you will be able to:

1. add/remove a tap gesture recognizer to any view
2. define the closures associated to the touchDown, touchUpInside, touchUpOutside events

## Example

Adding the gesture recognizer to a view is straightforward:

```
RSGestureRecognizer().add(to: view)
	.onTouchDown { (recognizer) in 
		// touch down behaviour
	}
	.onTouchUpInside { (recognizer) in
		// touch up inside behaviour
	}
	.onTouchUpOutside { (recognizer) in
		// touch up outside behaviour
	}
```

Closures are optional so it's possible to assign only the behaviour needed:

```
RSGestureRecognizer().add(to: view)
	.onTouchDown { (recognizer) in 
		// touch down behaviour
	}
```

You can remove the tap gesture anytime by calling the `remove()` function on its instance, if an instance reference is not available it's possible to retrieve it by inspecting a view directly with the static `find(in:)` function:

```
RSTapGesture.find(in: view)?.remove()
```

## Installation

RSTapGesture is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'RSTapGesture'
```

## Author

terrordrummer, roberto.sartori@gmail.com

## License

RSTapGesture is available under the MIT license. See the LICENSE file for more info.
