# CHGInputAccessoryView

[![Version](https://img.shields.io/cocoapods/v/CHGInputAccessoryView.svg?style=flat)](http://cocoapods.org/pods/CHGInputAccessoryView)
[![License](https://img.shields.io/cocoapods/l/CHGInputAccessoryView.svg?style=flat)](http://cocoapods.org/pods/CHGInputAccessoryView)
[![Platform](https://img.shields.io/cocoapods/p/CHGInputAccessoryView.svg?style=flat)](http://cocoapods.org/pods/CHGInputAccessoryView)

## Usage

![Screenshot of example CHGInputAccessoryView](example.gif)

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

CHGInputAccessoryView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "CHGInputAccessoryView"
```

## Usage

### Prepare a UIView or UIViewController

At first you must prepare a UIView or a UIViewController to become a first responder and attach an input accessory view.

Make UIView/UIViewController property inputAccessoryView writeable:

```objc
@property (nonatomic, readwrite, retain) UIView *inputAccessoryView;
```

Make sure your UIView/UIViewController can become first responder:
```objc
- (BOOL)canBecomeFirstResponder
{
return YES;
}
```

### Set up a CHGInputAccessoryView

Setting up a new CHGInputAccessoryView is as simple as setting up a UIToolbar.

```objc
// get an instance of CHGInputAccessoryView
CHGInputAccessoryView *accessoryView = [CHGInputAccessoryView inputAccessoryView];

// optionally define a delegate
accessoryView.inputAccessoryViewDelegate = self;

// create a CHGInputAccessoryViewItem
CHGInputAccessoryViewItem *trashItem = [CHGInputAccessoryViewItem buttonWithTitle:@"Trash"];

// attach accessory view items
accessoryView.items = @[ trashItem ];

// attach the accessory view
self.inputAccessoryView = accessoryView;
```

### Items

CHGInputAccessoryView comes with some prebuild items:

- a button with title
```objc
[CHGInputAccessoryViewItem buttonWithTitle:@"my title"];
```

- a button with image
```objc
[CHGInputAccessoryViewItem buttonWithImage:[UIImage imageNamed:@"my_image"]];
```

- a separator
```objc
[CHGInputAccessoryViewItem separatorWithColor:[UIColor lightGrayColor] height:20.f]
```
- a UITextField
```objc
CHGInputAccessoryViewItemTextField *item = [CHGInputAccessoryViewItemTextField item];
item.textField.placeholder = @"Enter your text";
```
- a UITextView
```objc
CHGInputAccessoryViewItemTextField *item = [CHGInputAccessoryViewItemTextField item];
item.textField.placeholder = @"Enter your text";
```
Tip: Modify the textField or textView by accessing CHGInputAccessoryViewItemTextField/TextView property textField/textView. The textField/textView will automatically resize to the maximum availabe width. The textView also resizes automatically to maximum available height. If you want a fixed size for your textField/textView assign a frame on it and set the CHGInputAccessoryViewItem property flexibleSize to NO.
- a UISwith
```objc
CHGInputAccessoryViewItemSwitch *item = [CHGInputAccessoryViewItemSwitch item];
item.switchView.on = YES;
```
- a UIProgressView
The InputAccessoryView has a build-in UIProgressView.
```objc
CHGInputAccessoryView *accessoryView = [CHGInputAccessoryView inputAccessoryView];
accessoryView.progressView.progress = 0.5f;
```
- a flexible or fixed space
```objc
[CHGInputAccessoryViewItemTextField flexibleSpace];
[CHGInputAccessoryViewItemTextField fixedSpace:25.f];
```

#### Enable/Disable items

```objc
// enable item
[accessoryView enableItem:item];

// disable item
[accessoryView disableItemAtIndex:1];
```

### Actions

- InputAccssoryViewDelegate

To use the build-in delegates (didTapItem: and didTapItemAtIndex:) assign a CHGInputAccessoryViewDelegate.

```objc
accessoryView.inputAccessoryViewDelegate = self;
```

- Assign target and action
```objc
item.target = self;
item.action = @selector(didTapMyItem:);
```
By setting the target the build in delegates will not be called for this item.

- Assign action block
```objc
item.actionOnTap = ^(CHGInputAccessoryViewItem *item){
    NSLog(@"Tapped my item...");
};
```

### Add and remove items

```objc

- (void)setItems:(NSArray<CHGInputAccessoryViewItem *> *)items;
- (void)setItems:(NSArray<CHGInputAccessoryViewItem *> *)items animated:(BOOL)animated;

- (void)addItem:(CHGInputAccessoryViewItem *)item animated:(BOOL)animated;
- (void)addItem:(CHGInputAccessoryViewItem *)item atIndex:(NSUInteger)index animated:(BOOL)animated;

- (void)removeItem:(CHGInputAccessoryViewItem *)item animated:(BOOL)animated;;
- (void)removeItemAtIndex:(NSUInteger)index animated:(BOOL)animated;
```

## Author

Christian Greth, greth.christian@googlemail.com

## License

CHGInputAccessoryView is available under the MIT license. See the LICENSE file for more info.
