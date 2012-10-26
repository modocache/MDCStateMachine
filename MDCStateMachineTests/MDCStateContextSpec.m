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