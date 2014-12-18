//
//  NSObject+SFObservation.m
//  SFFoundation
//
//  Created by yangzexin on 7/30/14.
//  Copyright (c) 2014 yangzexin. All rights reserved.
//

#import "NSObject+SFObservation.h"
#import "NSObject+SFObjectRepository.h"
#import "NSObject+SFAddition.h"
#import "SFPropertyObserveContext.h"

@implementation NSObject (SFObserve)

- (SFPropertyObserving *)sf_observeKeyPathWithTarget:(id)target name:(NSString *)name options:(NSKeyValueObservingOptions)options
{
    SFPropertyObserving *observing = nil;
    if (target != nil) {
        observing = [SFPropertyObserving new];
        SFPropertyObserveContext *context = [[SFPropertyObserveContext alloc] initWithTarget:target propertyName:name options:options usingBlock:^(id value){
            if (observing.changeBlock) {
                observing.changeBlock(value);
            }
        }];
        [self sf_addRepositionSupportedObject:context];
        __weak typeof(context) weakContext = context;
        __weak typeof(self) weakSelf = self;
        [observing setObserveStarted:^{
            [weakContext startObserve];
        }];
        [observing setCancelHandler:^{
            [weakContext cancelObserve];
            [weakSelf sf_removeRepositionSupportedObject:weakContext];
        }];
        __weak typeof(observing) weakObserving = observing;
        [target sf_addResourceDisposerWithBlock:^{
            [weakObserving cancel];
        }];
    }
    return observing;
}

@end
