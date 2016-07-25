//
//  MXToastValues.m
//  MXToast
//
//  Created by Meniny on 16/7/25.
//  Copyright © 2016年 Meniny. All rights reserved.
//

#import "MXToastValues.h"

NSString * const MXToastViewBackgroundColorAttributeName = @"MXToastViewBackgroundColorAttributeName";
NSString * const MXToastViewCornerRadiusAttributeName = @"MXToastViewCornerRadiusAttributeName";
NSString * const MXToastViewTextInsetsAttributeName = @"MXToastViewTextInsetsAttributeName";
NSString * const MXToastViewTextColorAttributeName = @"MXToastViewTextColorAttributeName";
NSString * const MXToastViewFontAttributeName = @"MXToastViewFontAttributeName";
NSString * const MXToastViewPortraitOffsetYAttributeName = @"MXToastViewPortraitOffsetYAttributeName";
NSString * const MXToastViewLandscapeOffsetYAttributeName = @"MXToastViewLandscapeOffsetYAttributeName";

@implementation MXToastValues
+ (instancetype)defaultValues {
    static MXToastValues *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [MXToastValues new];
    });
    return instance;
}

- (NSMutableDictionary<NSString *,NSMutableDictionary<NSNumber *,id> *> *)defaultValues {
    if (_defaultValues == nil) {
        NSMutableDictionary <NSString *, NSMutableDictionary <NSNumber *, id> *>* defaultValues = [NSMutableDictionary dictionary];
        
        [defaultValues setObject:[@{@(UIUserInterfaceIdiomUnspecified): [UIColor colorWithWhite:0 alpha:0.7]} mutableCopy] forKey:MXToastViewBackgroundColorAttributeName];
        
        [defaultValues setObject:[@{@(UIUserInterfaceIdiomUnspecified): @(5)} mutableCopy] forKey:MXToastViewCornerRadiusAttributeName];
        
        [defaultValues setObject:[@{@(UIUserInterfaceIdiomUnspecified): [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(6, 10, 6, 10)]} mutableCopy] forKey:MXToastViewTextInsetsAttributeName];
        
        [defaultValues setObject:[@{@(UIUserInterfaceIdiomUnspecified): [UIColor whiteColor]} mutableCopy] forKey:MXToastViewTextColorAttributeName];
        
        [defaultValues setObject:[@{@(UIUserInterfaceIdiomUnspecified): [UIFont systemFontOfSize:12],
                                    @(UIUserInterfaceIdiomPhone): [UIFont systemFontOfSize:12],
                                    @(UIUserInterfaceIdiomPad): [UIFont systemFontOfSize:16]} mutableCopy] forKey:MXToastViewFontAttributeName];
        
        [defaultValues setObject:[@{@(UIUserInterfaceIdiomUnspecified): @(30),
                                    @(UIUserInterfaceIdiomPhone): @(30),
                                    @(UIUserInterfaceIdiomPad): @(60)} mutableCopy] forKey:MXToastViewPortraitOffsetYAttributeName];
        
        [defaultValues setObject:[@{@(UIUserInterfaceIdiomUnspecified): @(20),
                                    @(UIUserInterfaceIdiomPhone): @(20),
                                    @(UIUserInterfaceIdiomPad): @(40)} mutableCopy] forKey:MXToastViewLandscapeOffsetYAttributeName];
        _defaultValues = defaultValues;
    }
    return _defaultValues;
}

+ (id)defaultValueForAttributeName:(NSString *)attributeName forUserInterfaceIdiom:(UIUserInterfaceIdiom)userInterfaceIdiom {
    NSMutableDictionary <NSNumber *, id> *valueForAttributeName = [[[MXToastValues defaultValues] defaultValues] objectForKey:attributeName];
    id value = [valueForAttributeName objectForKey:@(userInterfaceIdiom)];
    if (value != nil) {
        return value;
    }
    return [valueForAttributeName objectForKey:@(UIUserInterfaceIdiomUnspecified)];
}

+ (void)setDefaultValue:(id)value forAttributeName:(NSString *)attributeName userInterfaceIdiom:(UIUserInterfaceIdiom)userInterfaceIdiom {
    NSMutableDictionary <NSNumber *, id> *values = [[[MXToastValues defaultValues] defaultValues] objectForKey:attributeName];
    [values setObject:value forKey:@(userInterfaceIdiom)];
    [[[MXToastValues defaultValues] defaultValues] setObject:values forKey:attributeName];
}
@end
