//  MDCWebViewController.m
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


#import "MDCWebViewController.h"
#import "MDCStateContext.h"
#import "MDCState.h"


static NSString * const kMDCWebViewControllerWebViewURL = @"https://www.github.com/modocache";
static CGFloat const kMDCWebViewControllerReloadButtonHeight = 50.0f;


@interface MDCWebViewController () <UIWebViewDelegate>

@property (nonatomic, strong) MDCStateContext *stateContext;
@property (nonatomic, strong) MDCState *notLoadingState;
@property (nonatomic, strong) MDCState *loadingState;

@property (nonatomic, strong) UIButton *reloadButton;
@property (nonatomic, strong) UIWebView *webView;

- (UIButton *)buildReloadButton;
- (UIWebView *)buildWebView;

- (void)onReloadButtonTap:(UIButton *)sender;

@end


@implementation MDCWebViewController


#pragma mark - UIViewController Overrides

- (void)viewDidLoad {
    [super viewDidLoad];
    self.reloadButton = [self buildReloadButton];
    [self.view addSubview:self.reloadButton];
    
    self.webView = [self buildWebView];
    [self.view addSubview:self.webView];
    
    __block UIButton *reloadButton = self.reloadButton;
    __block UIWebView *webView = self.webView;
    self.notLoadingState = [MDCState new];
    self.notLoadingState.onEnter = ^{
        reloadButton.enabled = YES;
    };
    
    self.loadingState = [MDCState new];
    self.loadingState.onEnter = ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        reloadButton.enabled = NO;
        webView.alpha = 0.5f;
        webView.userInteractionEnabled = NO;
    };
    self.loadingState.onExit = ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        webView.alpha = 1.0f;
        webView.userInteractionEnabled = YES;
        [self.loadingState exit];
    };

    self.stateContext = [[MDCStateContext alloc] initWithState:self.notLoadingState];
    for (MDCState *state in @[self.notLoadingState, self.loadingState]) {
        state.delegate = self.stateContext;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    self.reloadButton = nil;
}


#pragma mark - UIWebViewDelegate Protocol Methods

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.stateContext transitionToState:self.loadingState force:NO];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.stateContext transitionToState:self.notLoadingState force:NO];
}


#pragma mark - Internal Methods

#pragma mark View Construction

- (UIButton *)buildReloadButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(0,
                              0,
                              self.view.frame.size.width,
                              kMDCWebViewControllerReloadButtonHeight);
    [button setTitle:NSLocalizedString(@"Reload", nil) forState:UIControlStateNormal];
    [button setTitle:NSLocalizedString(@"Loading...", nil) forState:UIControlStateDisabled];
    [button addTarget:self
               action:@selector(onReloadButtonTap:)
     forControlEvents:UIControlEventTouchUpInside];
    return button;
}


- (UIWebView *)buildWebView {
    CGRect webViewRect = CGRectMake(0,
                                    kMDCWebViewControllerReloadButtonHeight,
                                    self.view.frame.size.width,
                                    self.view.frame.size.height - kMDCWebViewControllerReloadButtonHeight);
    UIWebView *webView = [[UIWebView alloc] initWithFrame:webViewRect];
    webView.delegate = self;
    return webView;
}

#pragma mark UIControl Actions

- (void)onReloadButtonTap:(UIButton *)sender {
    NSURL *url = [NSURL URLWithString:kMDCWebViewControllerWebViewURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

@end
