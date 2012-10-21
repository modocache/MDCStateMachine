//  MDCInputView.m
//
//  Copyright (c) 2012 modocache
//
//  Permission is hereby granted, free of charge, to any person obtaining
//  a copy of this software and associated documentation files (the
//  "Software"), to deal in the Software without restriction, including
//  without limitation the rights to use, copy, modify, merge, publish,
//  distribute, sublicense, and/or sell copies of the Software, and to
//  permit persons to whom the Software is furnished to do so, subject to
//  the following conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
//  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
//  LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
//  OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
//  WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//


#import "MDCInputView.h"


static CGFloat const kInputViewHeight = 100.0f;


@interface MDCInputView ()
@property (nonatomic, assign) UITextField *textField;
@property (nonatomic, strong) UIButton *button;
- (void)setupSubviews;
- (void)onButtonTap:(UIButton *)button;
@end


@implementation MDCInputView


#pragma mark - Object Lifecycle

- (id)initWithTextField:(UITextField *)textField {
    CGRect viewRect = CGRectMake(0,
                                 textField.superview.frame.size.height - kInputViewHeight,
                                 textField.superview.frame.size.width,
                                 kInputViewHeight);
    self = [super initWithFrame:viewRect];
    if (self) {
        _textField = textField;
        [self setupSubviews];
    }
    return self;
}


#pragma mark - Internal Methods

- (void)setupSubviews {
    CGRect buttonRect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _button.frame = buttonRect;
    [_button setTitle:NSLocalizedString(@"Waka!", nil) forState:UIControlStateNormal];
    [_button addTarget:self
               action:@selector(onButtonTap:)
     forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_button];
}

- (void)onButtonTap:(UIButton *)button {
    self.textField.text = [self.textField.text stringByAppendingString:button.titleLabel.text];
}

@end
