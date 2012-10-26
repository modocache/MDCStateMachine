//  MDCStateContext.m
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


#import "MDCStateContext.h"


@interface MDCStateContext ()
@property (nonatomic, strong) MDCState *nextState;
@end


@implementation MDCStateContext


#pragma mark - Object Lifecycle

- (id)initWithState:(MDCState *)state {
    self = [super init];
    if (self) {
        _currentState = state;
        if (_currentState.onEnter) {
            _currentState.onEnter();
        }
    }
    return self;
}


#pragma mark - Public Interface

- (void)transitionToState:(MDCState *)state force:(BOOL)force {
    if (force) {
        self.nextState = state;
        if (self.currentState.onExit) {
            self.currentState.onExit();
        }
        [self stateDidExit:self.currentState];
        return;
    }
    
    if ([state isEqual:self.currentState] || self.nextState) {
        return;
    }
    
    self.nextState = state;
    if (self.currentState.onExit) {
        self.currentState.onExit();
    } else {
        [self stateDidExit:self.currentState];
    }
}


#pragma mark - MDCStateDelegate Protocol Methods

- (void)stateDidExit:(MDCState *)state {
    _currentState = self.nextState;
    
    if (self.nextState.onEnter) {
        self.nextState.onEnter();
    }
    self.nextState = nil;
}

@end
