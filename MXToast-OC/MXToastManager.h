//
//  MXToastManager.h
//  MXToast
//
//  Created by Meniny on 16/7/25.
//  Copyright © 2016年 Meniny. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "MXToast.h"
@class MXToast;

@interface MXToastManager : NSObject
@property (nonatomic, weak, readonly) MXToast *currentToast;

+ (instancetype)defaultManager;

- (void)addToast:(MXToast *)toast;
- (void)cancelAllToasts;
@end
