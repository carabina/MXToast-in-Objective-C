//
//  MXToastValues.h
//  MXToast
//
//  Created by Meniny on 16/7/25.
//  Copyright © 2016年 Meniny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

FOUNDATION_EXPORT NSString * const MXToastViewBackgroundColorAttributeName;
FOUNDATION_EXPORT NSString * const MXToastViewCornerRadiusAttributeName;
FOUNDATION_EXPORT NSString * const MXToastViewTextInsetsAttributeName;
FOUNDATION_EXPORT NSString * const MXToastViewTextColorAttributeName;
FOUNDATION_EXPORT NSString * const MXToastViewFontAttributeName;
FOUNDATION_EXPORT NSString * const MXToastViewPortraitOffsetYAttributeName;
FOUNDATION_EXPORT NSString * const MXToastViewLandscapeOffsetYAttributeName;

@interface MXToastValues : NSObject
@property (nonatomic, strong) NSMutableDictionary <NSString *, NSMutableDictionary <NSNumber *, id> *>* defaultValues;

+ (instancetype)defaultValues;
+ (id)defaultValueForAttributeName:(NSString *)attributeName forUserInterfaceIdiom:(UIUserInterfaceIdiom)userInterfaceIdiom;
+ (void)setDefaultValue:(id)value forAttributeName:(NSString *)attributeName userInterfaceIdiom:(UIUserInterfaceIdiom)userInterfaceIdiom;
@end
