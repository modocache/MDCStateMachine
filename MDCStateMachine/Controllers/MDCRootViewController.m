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
#import "MDCStateContext.h"
#import "MDCState.h"


static CGFloat const kTextFieldPaddingTop = 40.0f;
static CGFloat const kTextFieldWidth = 200.0f;
static CGFloat const kTextFieldHeight = 40.0f;


@interface MDCRootViewController () <UITextFieldDelegate>

@property (nonatomic, strong) MDCStateContext *stateContext;
@property (nonatomic, strong) MDCState *defaultState;
@property (nonatomic, strong) MDCState *editTextFieldState;
@property (nonatomic, strong) MDCState *editCustomInputViewTextFieldState;

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
    self.textField.delegate = self;
    self.textField.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.textField];

    textFieldRect.origin.y += kTextFieldHeight + kTextFieldPaddingTop;
    self.customInputViewTextField = [[UITextField alloc] initWithFrame:textFieldRect];
    self.customInputViewTextField.delegate = self;
    self.customInputViewTextField.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.customInputViewTextField];
    self.customInputViewTextField.inputView =
        [[MDCInputView alloc] initWithTextField:self.customInputViewTextField];

    UITapGestureRecognizer *tapGestureRecognizer =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(onBackgroundTap:)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    
    __block UITextField *textField = self.textField;
    __block UITextField *customInputViewTextField = self.customInputViewTextField;
    self.defaultState = [MDCState new];

    self.editTextFieldState = [MDCState new];
    self.editTextFieldState.onEnter = ^{
        NSLog(@"self.editTextFieldState.onEnter");
        [textField becomeFirstResponder];
    };
    self.editTextFieldState.onExit = ^{
        NSLog(@"self.editTextFieldState.onExit");
        [textField resignFirstResponder];
        [self.editTextFieldState exit];
    };
    
    self.editCustomInputViewTextFieldState = [MDCState new];
    self.editCustomInputViewTextFieldState.onEnter = ^{
        NSLog(@"self.customInputViewTextFieldState.onEnter");
        [customInputViewTextField becomeFirstResponder];
    };
    self.editCustomInputViewTextFieldState.onExit = ^{
        NSLog(@"self.customInputViewTextFieldState.onEnter");
        [customInputViewTextField resignFirstResponder];
        [self.editCustomInputViewTextFieldState exit];
    };
    
    self.stateContext = [[MDCStateContext alloc] initWithState:self.defaultState];
    for (MDCState *state in @[self.defaultState, self.editTextFieldState, self.editCustomInputViewTextFieldState]) {
        state.delegate = self.stateContext;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    self.textField = nil;
    self.customInputViewTextField = nil;
}


#pragma mark - UITextFieldDelegate Protocol Methods

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([textField isEqual:self.textField]) {
        NSLog(@"%@:%@ -- self.textField", [self class], NSStringFromSelector(_cmd));
        if ([self.stateContext.currentState isEqual:self.editTextFieldState]) {
            return YES;
        } else {
            [self.stateContext transitionToState:self.editTextFieldState];
            return NO;
        }
    } else {
        NSLog(@"%@:%@ -- self.customInputViewTextField", [self class], NSStringFromSelector(_cmd));
        if ([self.stateContext.currentState isEqual:self.editCustomInputViewTextFieldState]) {
            return YES;
        } else {
            [self.stateContext transitionToState:self.editCustomInputViewTextFieldState];
            return NO;
        }
    }
    return NO;
}


#pragma mark - Internal Methods

- (void)onBackgroundTap:(UITapGestureRecognizer *)tapGestureRecognizer {
    [self.stateContext transitionToState:self.defaultState];
}

@end
