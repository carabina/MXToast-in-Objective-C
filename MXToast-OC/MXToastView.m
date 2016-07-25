//
//  MXToastView.m
//  MXToast
//
//  Created by Meniny on 16/7/25.
//  Copyright © 2016年 Meniny. All rights reserved.
//

#import "MXToastView.h"
#import "MXToastWindow.h"
#import "MXToastValues.h"

@interface MXToastView ()
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, assign) UIEdgeInsets textInsets;
@end

@implementation MXToastView

- (instancetype)init {
    self = [super initWithFrame:CGRectMake(0, 0, 100, 100)];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectMake(0, 0, 100, 100)];
    if (self) {
        [self setup];
    }
    return self;
}


- (void)setup {
    UIUserInterfaceIdiom userInterfaceIdiom = [[UIDevice currentDevice] userInterfaceIdiom];
    
    [self setBackgroundView:[[UIView alloc] initWithFrame:[self bounds]]];
    [[self backgroundView] setBackgroundColor:[MXToastValues defaultValueForAttributeName:MXToastViewBackgroundColorAttributeName forUserInterfaceIdiom:userInterfaceIdiom]];
    [[[self backgroundView] layer] setCornerRadius:[[MXToastValues defaultValueForAttributeName:MXToastViewCornerRadiusAttributeName forUserInterfaceIdiom:userInterfaceIdiom] doubleValue]];
    [[self backgroundView] setClipsToBounds:YES];
    [self addSubview:[self backgroundView]];
    
    [self setTextLabel:[[UILabel alloc] initWithFrame:[self bounds]]];
    [[self textLabel] setTextColor:[MXToastValues defaultValueForAttributeName:MXToastViewTextColorAttributeName forUserInterfaceIdiom:userInterfaceIdiom]];
    [[self textLabel] setBackgroundColor:[UIColor clearColor]];
    [[self textLabel] setFont:[MXToastValues defaultValueForAttributeName:MXToastViewFontAttributeName forUserInterfaceIdiom:userInterfaceIdiom]];
    [[self textLabel] setNumberOfLines:0];
    [[self textLabel] setTextAlignment:NSTextAlignmentCenter];
    [[self textLabel] setClipsToBounds:YES];
    [self addSubview:[self textLabel]];
    
    NSValue *insets = [MXToastValues defaultValueForAttributeName:MXToastViewTextInsetsAttributeName forUserInterfaceIdiom:userInterfaceIdiom];
    [self setTextInsets:[insets UIEdgeInsetsValue]];
}

- (void)updateView {
    
    CGSize containerSize = [[MXToastWindow defaultWindow] frame].size;
    CGSize constraintSize = CGSizeMake(containerSize.width * (280.0 / 320.0), CGFLOAT_MAX);
    CGSize textLabelSize = [[self textLabel] sizeThatFits:constraintSize];
    
    [[self textLabel] setFrame:CGRectMake([self textInsets].left,
                                          [self textInsets].top,
                                          textLabelSize.width,
                                          textLabelSize.height)];
    
    CGFloat backgroundWidth = [[self textLabel] frame].size.width + [self textInsets].left + [self textInsets].right;
    CGFloat backgroundHeight = [[self textLabel] frame].size.height + [self textInsets].top + [self textInsets].bottom;
    
    [[self backgroundView] setFrame:CGRectMake(0,
                                              0,
                                               backgroundWidth,
                                               backgroundHeight)];
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = 0;
    CGFloat height = 0;
    
    UIUserInterfaceIdiom userInterfaceIdiom = [[UIDevice currentDevice] userInterfaceIdiom];
    
    CGFloat portraitOffsetY = [[MXToastValues defaultValueForAttributeName:MXToastViewPortraitOffsetYAttributeName forUserInterfaceIdiom:userInterfaceIdiom] doubleValue];
    CGFloat landscapeOffsetY = [[MXToastValues defaultValueForAttributeName:MXToastViewLandscapeOffsetYAttributeName forUserInterfaceIdiom:userInterfaceIdiom] doubleValue];
    
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait ||
        orientation == UIInterfaceOrientationPortraitUpsideDown ||
        ![[MXToastWindow defaultWindow] shouldRotateManually]) {
        width = containerSize.width;
        height = containerSize.height;
        y = portraitOffsetY;
    } else {
        width = containerSize.height;
        height = containerSize.width;
        y = landscapeOffsetY;
    }
    
    CGSize backgroundViewSize = [[self backgroundView] frame].size;
    x = (width - backgroundViewSize.width) * 0.5;
    y = height - (backgroundViewSize.height + y);
    [self setFrame:CGRectMake(x, y, backgroundViewSize.width, backgroundViewSize.height)];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if ([self superview] != nil) {
        CGPoint pointInWindow = [self convertPoint:point toView:[self superview]];
        BOOL contains = CGRectContainsPoint([self frame], pointInWindow);
        if (contains && [self isUserInteractionEnabled]) {
            return self;
        }
    }
    return nil;
}

@end
