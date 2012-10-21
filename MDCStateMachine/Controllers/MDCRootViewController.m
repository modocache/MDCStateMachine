//  MDCRootViewController.m
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


#import "MDCRootViewController.h"
#import "MDCInputView.h"


static CGFloat const kTextFieldPaddingTop = 40.0f;
static CGFloat const kTextFieldWidth = 200.0f;
static CGFloat const kTextFieldHeight = 40.0f;


@interface MDCRootViewController ()
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UITextField *customInputViewTextField;
- (void)onBackgroundTap:(UITapGestureRecognizer *)tapGestureRecognizer;
@end


@implementation MDCRootViewController


#pragma mark - UIViewController Overrides

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];

    CGRect textFieldRect = CGRectMake(floorf((self.view.frame.size.width - kTextFieldWidth)/2),
                                      kTextFieldPaddingTop,
                                      kTextFieldWidth,
                                      kTextFieldHeight);
    self.textField = [[UITextField alloc] initWithFrame:textFieldRect];
    self.textField.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.textField];

    textFieldRect.origin.y += kTextFieldHeight + kTextFieldPaddingTop;
    self.customInputViewTextField = [[UITextField alloc] initWithFrame:textFieldRect];
    self.customInputViewTextField.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.customInputViewTextField];
    self.customInputViewTextField.inputView =
        [[MDCInputView alloc] initWithTextField:self.customInputViewTextField];

    UITapGestureRecognizer *tapGestureRecognizer =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(onBackgroundTap:)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    self.textField = nil;
}


#pragma mark - Internal Methods

- (void)onBackgroundTap:(UITapGestureRecognizer *)tapGestureRecognizer {
    for (UITextField *textField in @[self.textField, self.customInputViewTextField]) {
        [textField resignFirstResponder];
    }
}

@end