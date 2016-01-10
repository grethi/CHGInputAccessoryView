// Copyright (c) 2016 Christian Greth <greth.christian@googlemail.com>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <UIKit/UIKit.h>

#import "CHGInputAccessoryViewItem.h"

@protocol CHGInputAccessoryViewDelegate <NSObject>

@optional

/**
 Informs the delegate about a tapped item.
 
 @param item the tapped item
*/
- (void)didTapItem:(CHGInputAccessoryViewItem *)item;

/**
 Informs the delegate about a tapped item.
 
 @param index the tapped item index
 */
- (void)didTapItemAtIndex:(NSUInteger)index;

@end

@interface CHGInputAccessoryView : UIToolbar

@property (nonatomic, weak) id<CHGInputAccessoryViewDelegate> inputAccessoryViewDelegate;

@property (readonly, getter=isVisible) BOOL visible;

/**
 Builds a new inputAccessoryView.
*/
+ (id)inputAccessoryView;

/**
  Builds a new inputAccessoryView.
 
 @param height specify a view height
 */
+ (id)inputAccessoryViewWithHeight:(CGFloat)height;

/**
 Adds an item to the right of the inputAccessoryView.
 
 @param item        the item to add
 @param animated    add the item animated
 */
- (void)addItem:(CHGInputAccessoryViewItem *)item animated:(BOOL)animated;

/**
 Adds an item on a specific index of the inputAccessoryView.
 
 @param item        the item to add
 @param index       the index position
 @param animated    add the item animated
 */
- (void)addItem:(CHGInputAccessoryViewItem *)item atIndex:(NSUInteger)index animated:(BOOL)animated;

/**
 Removes an item of inputAccessoryView.
 
 @param item        the item to remove
 @param animated    remove the item animated
 */
- (void)removeItem:(CHGInputAccessoryViewItem *)item animated:(BOOL)animated;;

/**
 Removes an item at specific index of inputAccessoryView.
 
 @param index       the index of an item to remove
 @param animated    remove the item animated
 */
- (void)removeItemAtIndex:(NSUInteger)index animated:(BOOL)animated;

@end
