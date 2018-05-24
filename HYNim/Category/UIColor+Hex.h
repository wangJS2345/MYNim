//
//  UIColor+Hex.h
//  HYNim
//
//  Created by wangJS on 2018/5/24.
//  Copyright © 2018年 SXHY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

// 颜色转换：iOS中（以#开头）十六进制的颜色转换为UIColor(RGB)
+ (UIColor *) colorWithHexString: (NSString *)color;

/**
 *  三原色 宏定义
 */
#define UIColorFromRGB(r,g,b)      [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0]
#define UIColorFromRGBA(r,g,b,a)   [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]


/**
 *  三原色 十六进制 宏定义
 *
 *  @param h 0xFFFFFF
 *  @param a 0~1
 *
 *  @return color
 */
#define UIColorFromHEX(h) [UIColor colorWithRed:((float)((h & 0xFF0000) >> 16))/255.0 \
green:((float)((h & 0xFF00) >> 8   ))/255.0 \
blue:((float)( h & 0xFF)           )/255.0 \
alpha:1.0]

#define UIColorFromHEXA(h,a) [UIColor colorWithRed:((float)((h & 0xFF0000) >> 16))/255.0 \
green:((float)((h & 0xFF00) >> 8   ))/255.0 \
blue:((float)( h & 0xFF)           )/255.0 \
alpha:a]

/**
 *  三原色 十六进制【字符串】 宏定义
 *
 *  @param hStr @"0xFFFFFF"
 *  @param a    0~1
 *
 *  @return color
 */
#define UIColorFromHEXStr(hStr)          [UIColor colorWithRGBHex:hStr andAlpha:1.0]
#define UIColorFromHEXStrA(hStr,a)       [UIColor colorWithRGBHex:hStr andAlpha:a]

/**
 *  随机色
 */
#define RandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 \
green:arc4random_uniform(255)/255.0 \
blue:arc4random_uniform(255)/255.0 \
alpha:1.0]





/**
 *  十六进制 颜色
 *
 *  @param hexStr 十六进制的字符串
 *  @param alpha  透明头
 *
 *  @return color
 */
+(UIColor*)colorWithRGBHex:(NSString*)hexStr andAlpha:(CGFloat)alpha;

@end
