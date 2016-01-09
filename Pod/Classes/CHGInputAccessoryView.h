//
//  CHGInputAccessoryView.h
//  Pods
//
//  Created by Christian on 08.01.16.
//
//

#import <UIKit/UIKit.h>

#import "CHGInputAccessoryViewItem.h"

@protocol CHGInputAccessoryViewDelegate <NSObject>

@optional

- (void)didTapItem:(CHGInputAccessoryViewItem *)item;
- (void)didTapItemAtIndex:(NSUInteger)index;

@end

@interface CHGInputAccessoryView : UIToolbar

@property (nonatomic, weak) id<CHGInputAccessoryViewDelegate> inputAccessoryViewDelegate;

+ (id)inputAccessoryView;
+ (id)inputAccessoryViewWithHeight:(CGFloat)height;

- (void)addItem:(CHGInputAccessoryViewItem *)item animated:(BOOL)animated;
- (void)addItem:(CHGInputAccessoryViewItem *)item atIndex:(NSUInteger)index animated:(BOOL)animated;

- (void)removeItem:(CHGInputAccessoryViewItem *)item animated:(BOOL)animated;;
- (void)removeItemAtIndex:(NSUInteger)index animated:(BOOL)animated;

@end
