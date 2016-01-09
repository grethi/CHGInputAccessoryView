//
//  CHGInputAccessoryViewItem.h
//  Pods
//
//  Created by Christian on 08.01.16.
//
//

#import <UIKit/UIKit.h>

@interface CHGInputAccessoryViewItem : UIBarButtonItem

@property BOOL flexibleSize;

@property (nonatomic, copy) void (^actionOnTap)(CHGInputAccessoryViewItem *item);

+ (CHGInputAccessoryViewItem *)fixedSpace:(CGFloat)width;
+ (CHGInputAccessoryViewItem *)flexibleSpace;
+ (CHGInputAccessoryViewItem *)separatorWithColor:(UIColor *)color height:(CGFloat)height;
+ (CHGInputAccessoryViewItem *)buttonWithImage:(UIImage *)image;

- (BOOL)becomeFirstRsponder;

@end
