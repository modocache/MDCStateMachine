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