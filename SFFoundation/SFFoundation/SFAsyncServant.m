//
//  MMAsyncServant.m
//  MMFoundation
//
//  Created by yangzexin on 11/5/14.
//  Copyright (c) 2014 yangzexin. All rights reserved.
//

#import "SFAsyncServant.h"

@interface SFAsyncServant ()

@property (nonatomic, copy) void(^execution)(SFAsyncServantNotifier notifier);

@end

@implementation SFAsyncServant

+ (instancetype)servantWithAsyncExecution:(void(^)(SFAsyncServantNotifier notifier))execution whenCancelled:(void(^)())whenCancelled
{
    SFAsyncServant *servant = [self new];
    servant.execution = execution;
    servant.whenCancelled = whenCancelled;
    
    return servant;
}

+ (instancetype)servantWithAsyncExecution:(void(^)(SFAsyncServantNotifier notifier))execution
{
    return [self servantWithAsyncExecution:execution whenCancelled:nil];
}

- (void)didStart
{
    [super didStart];
    __weak typeof(self) weakSelf = self;
    self.execution(^(SFFeedback *callReturn){
        __strong typeof(weakSelf) self = weakSelf;
        [self sendFeedback:callReturn];
    });
}

- (void)cancel
{
    [super cancel];
    if (self.whenCancelled) {
        self.whenCancelled();
    }
}

@end
