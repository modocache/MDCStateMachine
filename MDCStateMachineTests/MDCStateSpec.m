//  MDCStateSpec.m
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
#import "MDCState.h"


SPEC_BEGIN(MDCStateSpec)

describe(@"MDCState", ^{
    __block MDCState *state = nil;
    __block KWMock <MDCStateDelegate> *delegateMock = nil;
    beforeEach(^{
        state = [MDCState new];
        
        delegateMock = [KWMock mockForProtocol:@protocol(MDCStateDelegate)];
        [delegateMock stub:@selector(stateDidExit:)];
        state.delegate = delegateMock;
    });
    
    describe(@"exit", ^{
        it(@"should inform its delegate", ^{
            [[(NSObject *)state.delegate should] receive:@selector(stateDidExit:)];
            [state exit];
        });
    });
});


SPEC_END