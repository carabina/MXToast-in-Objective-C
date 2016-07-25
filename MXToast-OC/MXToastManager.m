//
//  MXToastManager.m
//  MXToast
//
//  Created by Meniny on 16/7/25.
//  Copyright © 2016年 Meniny. All rights reserved.
//

#import "MXToastManager.h"
#import "MXToast.h"

@interface MXToastManager ()
@property (nonatomic, strong) NSOperationQueue *queue;
@end

@implementation MXToastManager

#pragma mark - Allocation
- (instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
    }
    return self;
}

+ (instancetype)defaultManager {
    static MXToastManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [MXToastManager new];
    });
    return instance;
}

#pragma mark - Getter & Setter

- (NSOperationQueue *)queue {
    if (_queue == nil) {
        _queue = [NSOperationQueue new];
        [_queue setMaxConcurrentOperationCount:1];
    }
    return _queue;
}

- (MXToast *)currentToast {
    if ([[self queue] operationCount]) {
        return (MXToast *)[[[self queue] operations] firstObject];
    }
    return nil;
}

#pragma mark - Actions

- (void)addToast:(MXToast *)toast {
    if (toast != nil) {
        [[self queue] addOperation:toast];
    }
}

- (void)deviceOrientationDidChange:(NSNotification *)notification {
    if ([[self queue] operationCount]) {
        MXToast *lastToast = (MXToast *)[[[self queue] operations] firstObject];
        if ([lastToast view] != nil) {
            [[lastToast view] updateView];
        }
    }
}

- (void)cancelAllToasts {
    for (MXToast *toast in [[self queue] operations]) {
        [toast cancel];
    }
}
@end
