//
//  FOGTextInputKeyboardAccessoryView.m
//  PinYa
//
//  Created by Christian on 15.09.15.
//  Copyright (c) 2015 fog. All rights reserved.
//

#import "CHGInputAccessoryView.h"

@implementation CHGInputAccessoryView

@synthesize textField = _textField;
@synthesize rightButton = _rightButton;

+ (CHGInputAccessoryView *)inputAccesoryViewWithHeigth:(CGFloat)height
{
    return [[CHGInputAccessoryView alloc] initWithFrame:CGRectMake(0, 0, 0, height)];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor colorWithRed:(247/255.0) green:(247/255.0) blue:(247/255.0) alpha:1];
        
        [self addSubview:self.textField];
        [self addSubview:self.rightButton];
        
        // set default properties
        self.visible = false;
    }
    return self;
}

- (void)layoutSubviews
{
    [self removeConstraints:self.constraints];
    
    NSDictionary *metrics = @{@"spacing":@5};
    NSDictionary *views;
    
    if (self.leftButton) {
        
        [self.leftButton removeFromSuperview];
        self.leftButton.translatesAutoresizingMaskIntoConstraints = NO;
        [self.leftButton sizeToFit];
        [self addSubview:self.leftButton];
        
        [self.rightButton sizeToFit];
        
        self.rightButton.translatesAutoresizingMaskIntoConstraints = NO;
        self.textField.translatesAutoresizingMaskIntoConstraints = NO;
        
        views = @{@"textField":self.textField, @"rightButton":self.rightButton, @"leftButton":self.leftButton};
    
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-spacing-[leftButton]-spacing-[textField]-spacing-[rightButton]-spacing-|" options:NSLayoutFormatAlignAllCenterY metrics:metrics views:views]];
    } else {
        
        
        [self.rightButton sizeToFit];
        
        self.rightButton.translatesAutoresizingMaskIntoConstraints = NO;
        self.textField.translatesAutoresizingMaskIntoConstraints = NO;
        
        views = @{@"textField":self.textField, @"rightButton":self.rightButton};
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-spacing-[textField]-spacing-[rightButton]-spacing-|" options:NSLayoutFormatAlignAllCenterY metrics:metrics views:views]];
    }
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-spacing-[textField]-spacing-|" options:0 metrics:metrics views:views]];
    
    [super layoutSubviews];
}

- (UITextField *)textField
{
    if (_textField) return _textField;
    
    _textField = [[UITextField alloc] init];
    _textField.returnKeyType = UIReturnKeyDone;
    _textField.autocorrectionType = UITextAutocorrectionTypeNo;
    _textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    _textField.tintColor = [UIColor lightGrayColor];
    _textField.delegate = self;
    
    return _textField;
}

- (UIButton *)rightButton
{
    if (_rightButton) return _rightButton;
    
    _rightButton = [[UIButton alloc] init];
    [_rightButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [_rightButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_rightButton addTarget:self action:@selector(didTapCancelButton) forControlEvents:UIControlEventTouchUpInside];
    
    return _rightButton;
}

- (BOOL)canBecomeFirstResponder
{
    return true;
}

- (BOOL)resignFirstResponder
{
    [super resignFirstResponder];
    [_textField resignFirstResponder];
    self.visible = false;
    return true;
}

- (BOOL)becomeFirstResponder
{
    [super becomeFirstResponder];
    [_textField becomeFirstResponder];
    self.visible = true;
    return true;
}

- (void)didTapCancelButton
{
    BOOL cancel = true;
    if ([self.delegate respondsToSelector:@selector(willCancelWithText:)]) {
        cancel = [self.delegate willCancelWithText:_textField.text];
    }
    if (cancel) [self resignFirstResponder];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    BOOL ret = true;
    if ([self.delegate respondsToSelector:@selector(willReturnWithText:)]) {
        ret = [self.delegate willReturnWithText:_textField.text];
    }
    
    if (ret) {
        textField.text = @"";
        [self resignFirstResponder];
    }
    
    return ret;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BOOL change = true;
    if ([self.delegate respondsToSelector:@selector(willChangeText:replaceText:charactersInRange:)]) {
        change = [self.delegate willChangeText:_textField.text replaceText:string charactersInRange:range];
    }
    
    return change;
}

@end
