//
//  MXToast.m
//  MXToast
//
//  Created by Meniny on 16/7/25.
//  Copyright © 2016年 Meniny. All rights reserved.
//

#import "MXToast.h"

//const MXToastDelay MXToastDelayZero = {0, 0};
//const MXToastDelay MXToastDelayDefault = {2, 3.5};

@interface MXToast () {
    BOOL _executing;
    BOOL _finished;
}

@end

@implementation MXToast

#pragma mark - Setter & Getter
- (MXToastView *)view {
    if (_view == nil) {
        _view = [MXToastView new];
    }
    return _view;
}

- (void)setText:(NSString *)text {
    self.view.textLabel.text = text;
}

- (NSString *)text {
    return self.view.textLabel.text;
}

- (NSTimeInterval)duration {
    if (_duration <= 0) {
        _duration = MXToastShortDelay;
    }
    return _duration;
}

- (void)setExecuting:(BOOL)executing {
    [self willChangeValueForKey:@"isExecuting"];
    _executing = executing;
    [self didChangeValueForKey:@"isExecuting"];
}

- (BOOL)isExecuting {
    return _executing;
}

- (void)setFinished:(BOOL)finished {
    [self willChangeValueForKey:@"isFinished"];
    _finished = finished;
    [self didChangeValueForKey:@"isFinished"];
}

- (BOOL)isFinished {
    return _finished;
}

#pragma mark - Alloction
+ (MXToast *)toastWithFormat:(NSString *)format, ... {
    NSString *string;
    if (format != nil) {
        va_list args;
        va_start(args, format);
        string = [[NSString alloc] initWithFormat:format arguments:args];
        va_end(args);
    }
    return [MXToast toast:string];
}

+ (MXToast *)toast:(NSString *)text {
    return [MXToast toast:text delay:0 duration:MXToastShortDelay];
}

+ (MXToast *)toast:(NSString *)text duration:(NSTimeInterval)duration {
    return [MXToast toast:text delay:0 duration:duration];
}

+ (MXToast *)toast:(NSString *)text delay:(NSTimeInterval)delay duration:(NSTimeInterval)duration {
    MXToast *toast = [MXToast new];
    [toast setText:(text == nil ? @"" : text)];
    [toast setDelay:delay];
    [toast setDuration:duration];
    return toast;
}

#pragma mark - Show & Hide
- (void)show {
    [[MXToastManager defaultManager] addToast:self];
}

- (void)start {
    if (![NSThread isMainThread]) {
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf start];
        });
    } else {
        [super start];
    }
}

- (void)main {
    [self setExecuting:YES];
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [[weakSelf view] updateView];
        [[weakSelf view] setAlpha:0];
        [[MXToastWindow defaultWindow] addSubview:[weakSelf view]];
        [UIView animateWithDuration:0.25
                              delay:[weakSelf delay]
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             [[weakSelf view] setAlpha:1];
                         } completion:^(BOOL finished) {
                             
                             [UIView animateWithDuration:0.25
                                                   delay:[weakSelf duration]
                                                 options:UIViewAnimationOptionBeginFromCurrentState
                                              animations:^{
                                                  [[weakSelf view] setAlpha:0];
                                              } completion:^(BOOL finished) {
                                                  [[weakSelf view] removeFromSuperview];
                                                  [weakSelf finish];
                                              }];
                         }];
    });
}

- (void)cancel {
    [super cancel];
    [self finish];
    [[self view] removeFromSuperview];
}

- (void)finish {
    [self setExecuting:NO];
    [self setFinished:YES];
}
@end
