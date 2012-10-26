//  MDCStateContextSpec.m
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


#import "Kiwi.h"
#import "MDCStateContext.h"


SPEC_BEGIN(MDCStateContextSpec)

describe(@"MDCStateContext", ^{

    describe(@"initWithState:", ^{
        context(@"the state is nil", ^{
            __block MDCState *state = nil;
            it(@"initializes without error", ^{
                MDCStateContext *stateContext = [[MDCStateContext alloc] initWithState:state];
                [[stateContext shouldNot] beNil];
            });
        });
        context(@"the state is not nil", ^{
            __block MDCState *state = nil;
            beforeEach(^{
                state = [MDCState new];
            });
            it(@"initializes without error and calls the enter block of the state", ^{
                [[state should] receive:@selector(onEnter)];
                [[[[MDCStateContext alloc] initWithState:state] shouldNot] beNil];
            });
        });
    });

    describe(@"transitionToState:force:", ^{
        context(@"force", ^{
            context(@"the current state is nil", ^{
                xit(@"should enter the next state immediately", ^{});
            });
            context(@"the current state is not nil", ^{
                xit(@"should exit the current state", ^{});
                xit(@"should enter the next state", ^{});
            });
        });
        context(@"not force", ^{
            context(@"the current state is nil", ^{
                xit(@"should enter the next state immediately", ^{});
            });
            context(@"the current state is not nil", ^{
                xit(@"should exit the current state", ^{});
                xit(@"should enter the next state", ^{});
            });
        });
    });
});


SPEC_END