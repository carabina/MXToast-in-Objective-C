//
//  MXToastView.h
//  MXToast
//
//  Created by Meniny on 16/7/25.
//  Copyright © 2016年 Meniny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MXToastView : UIView
@property (nonatomic, strong) UILabel *textLabel;
- (void)updateView;
@end
