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

@interface CHGInputAccessoryViewItem : UIBarButtonItem

/**
 Set this property to YES to automatically size this item.
*/
@property BOOL flexibleSize;

/**
 Assign an action to perfom after tapping the item.
*/
@property (nonatomic, copy) void (^actionOnTap)(CHGInputAccessoryViewItem *item);

/**
 A fixed space item.
 
 @param width space width
*/
+ (CHGInputAccessoryViewItem *)fixedSpace:(CGFloat)width;

/**
 A flexible space item.
*/
+ (CHGInputAccessoryViewItem *)flexibleSpace;

/**
 A separator item.
 
 @param color  separators color
 @param height separators height
*/
+ (CHGInputAccessoryViewItem *)separatorWithColor:(UIColor *)color height:(CGFloat)height;

/**
 A button with image item.
 
 @param image button image
*/
+ (CHGInputAccessoryViewItem *)buttonWithImage:(UIImage *)image;

/**
 A button with title item.
 
 @param title button title
*/
+ (CHGInputAccessoryViewItem *)buttonWithTitle:(NSString *)title;

/**
 *  The preferred item height. Used to resize the InputAccessoryView height.
 *
 *  @return the preffered height for this item - Default: 0px (no resizing)
 */
- (CGFloat)preferredHeight;

/**
 *  Resizes a item to a new height.
 *
 *  @param height the new height.
*/
- (void)resizeToHeight:(CGFloat)height;

@end
