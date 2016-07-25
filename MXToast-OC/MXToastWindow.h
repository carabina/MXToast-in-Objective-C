//
//  MXToastWindow.h
//  MXToast
//
//  Created by Meniny on 16/7/25.
//  Copyright © 2016年 Meniny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MXToastWindow : UIWindow
+ (instancetype)defaultWindow;
- (BOOL)shouldRotateManually;
@end
