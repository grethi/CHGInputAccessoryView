//
//  CHGViewController.h
//  CHGInputAccessoryView
//
//  Created by Christian on 01/04/2016.
//  Copyright (c) 2016 Christian. All rights reserved.
//

@import UIKit;

#import "CHGView.h"

@interface CHGViewController : UIViewController <CHGInputAccessoryViewDelegate>

@property (nonatomic, readwrite, retain) UIView *inputAccessoryView;

@end
