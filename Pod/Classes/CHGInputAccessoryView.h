//
//  FOGTextInputKeyboardAccessoryView.h
//  PinYa
//
//  Created by Christian on 15.09.15.
//  Copyright (c) 2015 fog. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CHGInputAccessoryViewDelegate <NSObject>

@optional

- (BOOL)willCancelWithText:(NSString *)text;
- (BOOL)willReturnWithText:(NSString *)text;
- (BOOL)willChangeText:(NSString *)text replaceText:(NSString *)replaceText charactersInRange:(NSRange)range;

@end

@interface CHGInputAccessoryView : UIView <UITextFieldDelegate>

@property (getter=isVisible) BOOL visible;
@property (nonatomic, weak) id<CHGInputAccessoryViewDelegate> delegate;

@property (nonatomic, readonly, retain) UITextField *textField;
@property (nonatomic, readonly, retain) UIButton *rightButton;
@property (nonatomic, retain) UIButton *leftButton;

+ (CHGInputAccessoryView *)inputAccesoryViewWithHeigth:(CGFloat)height;

@end