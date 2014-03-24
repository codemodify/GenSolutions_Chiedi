//
//  Helpers.h
//  PrezzoStima
//
//  Created by Nicolae Carabut on 2/4/13.
//  Copyright (c) 2013 GenSolutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Helpers : NSObject

    +(void)Init;

    +(NSDictionary*) GetJsonFromUrl:(NSString*)url;

    +(NSString*) GetServiceTypeUrl;
    +(NSString*) GetSearchUrl;
    +(NSString*) GetSendMailUrl;
    +(NSString*) GetCaptchaUrl;

//    +(NSArray*) GetRGBAsFromImage:(UIImage*)image atX:(int)xx andY:(int)yy count:(int)count;
    +(UIColor*) ColorOfPoint:(CGPoint)point withImage:(UIView*)view;
//    +(UIImage*) TakeScreenShot:(UIViewController*)viewController;

//    +(void) GetRGBComponents:(CGFloat[3])components forColor:(UIColor*)color;

    +(NSString*) GetRegionByRed:(int)red green:(int)green blue:(int)blue;
    +(NSString*) GetMapByRegion:(NSString*)region;
    +(NSString*) GetSubregionByRegion:(NSString*)region andRed:(int)red green:(int)green blue:(int)blue;

    +(NSString*) GetServiceTypeIcon:(NSString*)type;

@end
