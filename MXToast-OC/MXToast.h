//
//  MXToast.h
//  MXToast
//
//  Created by Meniny on 16/7/25.
//  Copyright © 2016年 Meniny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MXToastView.h"
#import "MXToastManager.h"
#import "MXToastWindow.h"

#if __OBJC__
static NSTimeInterval const MXToastShortDelay = 2.0;
static NSTimeInterval const MXToastLongDelay = 3.5;
static NSString * const MXToastViewBackgroundColorAttributeName = @"MXToastViewBackgroundColorAttributeName";
static NSString * const MXToastViewCornerRadiusAttributeName = @"MXToastViewCornerRadiusAttributeName";
static NSString * const MXToastViewTextInsetsAttributeName = @"MXToastViewTextInsetsAttributeName";
static NSString * const MXToastViewTextColorAttributeName = @"MXToastViewTextColorAttributeName";
static NSString * const MXToastViewFontAttributeName = @"MXToastViewFontAttributeName";
static NSString * const MXToastViewPortraitOffsetYAttributeName = @"MXToastViewPortraitOffsetYAttributeName";
static NSString * const MXToastViewLandscapeOffsetYAttributeName = @"MXToastViewLandscapeOffsetYAttributeName";
#endif

/*#pragma mark - MXToastDelay
struct MXToastDelay {
    NSTimeInterval ShortDelay;
    NSTimeInterval LongDelay;
};

typedef struct MXToastDelay MXToastDelay;*/

#pragma mark - MXToast
@interface MXToast : NSOperation
@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) MXToastView *view;
@property (nonatomic, assign) NSTimeInterval delay;
@property (nonatomic, assign) NSTimeInterval duration;

+ (MXToast *)toastWithFormat:(NSString *)format, ...;
+ (MXToast *)toast:(NSString *)text;
+ (MXToast *)toast:(NSString *)text duration:(NSTimeInterval)duration;
+ (MXToast *)toast:(NSString *)text delay:(NSTimeInterval)delay duration:(NSTimeInterval)duration;

- (void)show;
- (void)cancel;
@end
