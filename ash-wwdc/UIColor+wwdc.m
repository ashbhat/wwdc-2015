//
//  UIColor+wwdc.m
//  ash-wwdc
//
//  Created by Ash Bhat on 4/23/15.
//  Copyright (c) 2015 Ash Bhat. All rights reserved.
//

#import "UIColor+wwdc.h"

@implementation UIColor (wwdc)
+ (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1];
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

+(UIColor *)randomColor{
    int randomInt = arc4random_uniform(6);
    switch (randomInt) {
        case 0:
            return [self wwdc_Red];
            break;
        case 1:
            return [self wwdc_Blue];
            break;
        case 2:
            return [self wwdc_Orange];
            break;
        case 3:
            return [self wwdc_Green];
            break;
        case 4:
            return [self wwdc_Teal];
            break;
        case 5:
            return [self wwdc_Purple];
            break;
        case 6:
            return [self wwdc_Pink];
            break;
        default:
            break;
    }
    return [self wwdc_Red];
}
+(UIColor *)wwdc_Red{
    return [UIColor colorFromHexString:@"#FF5966"];
}
+(UIColor *)wwdc_Pink{
    return [UIColor colorFromHexString:@"#FF7BD6"];
}
+(UIColor *)wwdc_Blue{
    return [UIColor colorFromHexString:@"#346FFF"];
}

+(UIColor *)wwdc_Orange{
    return [UIColor colorFromHexString:@"#FF8568"];
}
+(UIColor *)wwdc_Green{
    return [UIColor colorFromHexString:@"#90C12B"];
}
+(UIColor *)wwdc_Teal{
    return [UIColor colorFromHexString:@"#49E6D5"];
}
+(UIColor *)wwdc_Purple{
    return [UIColor colorFromHexString:@"#9247F8"];
}


@end
