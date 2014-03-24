//
//  Helpers.m
//  PrezzoStima
//
//  Created by Nicolae Carabut on 2/4/13.
//  Copyright (c) 2013 GenSolutions. All rights reserved.
//

#import "Helpers.h"
#import "SBJson.h"
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

static NSArray*         regions = nil;
static NSDictionary*    regionsRgb = nil;
static NSDictionary*    regionsMap = nil;
static NSDictionary*    subRegionsRgb = nil;

static NSDictionary*    serviceTypeIco = nil;

@implementation Helpers

+(void)Init
{
    regions =
    @[
        @"Abruzzo",
        @"Basilicata",
        @"Calabria",
        @"Campania",
        @"Emilia-Romagna",
        @"Friuli-Venezia Giulia",
        @"Lazio",
        @"Liguria",
        @"Lombardia",
        @"Marche",
        @"Molise",
        @"Piemonte",
        @"Puglia",
        @"Sardegna",
        @"Sicilia",
        @"Toscana",
        @"Trentino-Alto Adige",
        @"Umbria",
        @"Valle d'Aosta",
        @"Veneto"
    ];
    
    regionsRgb =
    @{
        regions[ 0] : @"R=58 G=102 B=185",
        regions[ 1] : @"R=57 G=101 B=183",
        regions[ 2] : @"R=57 G=100 B=183",
        regions[ 3] : @"R=57 G=102 B=184",
        regions[ 4] : @"R=59 G=104 B=188",
        regions[ 5] : @"R=60 G=105 B=188",
        regions[ 6] : @"R=58 G=102 B=186",
        regions[ 7] : @"R=59 G=104 B=187",
        regions[ 8] : @"R=61 G=105 B=189",
        regions[ 9] : @"R=59 G=103 B=186",
        regions[10] : @"R=58 G=102 B=184",
        regions[11] : @"R=61 G=106 B=189",
        regions[12] : @"R=57 G=101 B=184",
        regions[13] : @"R=56 G=100 B=182",
        regions[14] : @"R=56 G=100 B=183",
        regions[15] : @"R=59 G=103 B=187",
        regions[16] : @"R=60 G=105 B=189",
        regions[17] : @"R=58 G=103 B=186",
        regions[18] : @"R=61 G=106 B=190",
        regions[19] : @"R=61 G=104 B=188"
    };
    
    regionsMap =
    @{
        regions[ 0]: @"Province_Abruzzo",
        regions[ 1]: @"Province_Basilicata",
        regions[ 2]: @"Province_Calabria",
        regions[ 3]: @"Province_Campania",
        regions[ 4]: @"Province_Emilia_Romagna",
        regions[ 5]: @"Province_Friuli_Venezia_Giulia",
        regions[ 6]: @"Province_Lazio",
        regions[ 7]: @"Province_Liguria",
        regions[ 8]: @"Province_Lombardy",
        regions[ 9]: @"Province_Marche",
        regions[10]: @"Province_Molise",
        regions[11]: @"Province_Piemonte",
        regions[12]: @"Province_Puglia",
        regions[13]: @"Province_Sardegna",
        regions[14]: @"Province_Sicilia",
        regions[15]: @"Province_Toscana",
        regions[16]: @"Province_Trentino_Alto_Adige",
        regions[17]: @"Province_Umbria",
        regions[18]: @"Province_Aosta",
        regions[19]: @"Province_Veneto"
    };
    
    subRegionsRgb =
    @{
        regions[0] :
        @{
            @"Teramo"                : @"R=60 G=105 B=189",
            @"Pescara"               : @"R=61 G=105 B=189",
            @"L'Aquila"              : @"R=61 G=106 B=189",
            @"Chieti"                : @"R=61 G=106 B=190"
        },
        regions[1] :
        @{
            @"Potenza"               : @"R=61 G=106 B=189",
            @"Matera"                : @"R=61 G=106 B=190"
        },
        regions[2] :
        @{
            @"Vibo Valentia"         : @"R=60 G=105 B=188",
            @"Reggio Calabria"       : @"R=60 G=105 B=189",
            @"Crotone"               : @"R=61 G=105 B=189",
            @"Cosenza"               : @"R=61 G=106 B=189",
            @"Catanzaro"             : @"R=61 G=106 B=190"
        },
        regions[3] :
        @{
            @"Salerno"               : @"R=60 G=105 B=188",
            @"Napoli"                : @"R=60 G=105 B=189",
            @"Caserta"               : @"R=61 G=105 B=189",
            @"Benevento"             : @"R=61 G=106 B=189",
            @"Avellino"              : @"R=61 G=106 B=190"
        },
        regions[4] :
        @{
            @"Rimini"                : @"R=59 G=103 B=187",
            @"Reggio Emilia"         : @"R=59 G=104 B=187",
            @"Ravenna"               : @"R=59 G=104 B=188",
            @"Piacenza"              : @"R=61 G=104 B=188",
            @"Parma"                 : @"R=60 G=105 B=188",
            @"Modena"                : @"R=60 G=105 B=189",
            @"Forli-Cesena"          : @"R=61 G=105 B=189",
            @"Ferrara"               : @"R=61 G=106 B=189",
            @"Bologna"               : @"R=61 G=106 B=190"
        },
        regions[5] :
        @{
            @"Udine"                 : @"R=60 G=105 B=189",
            @"Trieste"               : @"R=61 G=105 B=189",
            @"Pordenone"             : @"R=61 G=106 B=189",
            @"Gorizia"               : @"R=61 G=106 B=190"
        },
        regions[6] :
        @{
            @"Viterbo"               : @"R=60 G=105 B=188",
            @"Roma"                  : @"R=60 G=105 B=189",
            @"Rieti"                 : @"R=61 G=105 B=189",
            @"Latina"                : @"R=61 G=106 B=189",
            @"Frosinone"             : @"R=61 G=106 B=190"
        },
        regions[7] :
        @{
            @"Savona"                : @"R=60 G=105 B=189",
            @"La Spezia"             : @"R=61 G=105 B=189",
            @"Imperia"               : @"R=61 G=106 B=189",
            @"Genova"                : @"R=61 G=106 B=190"
        },
        regions[8] :
        @{
            @"Varese"                : @"R=58 G=102 B=186",
            @"Sondrio"               : @"R=58 G=103 B=186",
            @"Pavia"                 : @"R=59 G=103 B=186",
            @"Monza e Brianza"       : @"R=59 G=103 B=187",
            @"Milano"                : @"R=59 G=104 B=187",
            @"Mantova"               : @"R=59 G=104 B=188",
            @"Lodi"                  : @"R=60 G=105 B=188",
            @"Lecco"                 : @"R=60 G=105 B=189",
            @"Cremona"               : @"R=61 G=104 B=188",
            @"Como"                  : @"R=61 G=105 B=189",
            @"Brescia"               : @"R=61 G=106 B=189",
            @"Bergamo"               : @"R=61 G=106 B=190"
        },
        regions[9] :
        @{
            @"Pesaro e Urbino"       : @"R=60 G=105 B=188",
            @"Macerata"              : @"R=60 G=105 B=189",
            @"Fermo"                 : @"R=61 G=105 B=189",
            @"Ascoli Piceno"         : @"R=61 G=106 B=189",
            @"Ancona"                : @"R=61 G=106 B=190"
        },
        regions[10] :
        @{
            @"Isernia"               : @"R=61 G=106 B=190",
            @"Campobasso"            : @"R=61 G=106 B=189"
        },
        regions[11] :
        @{
            @"Vercelli"              : @"R=59 G=104 B=187",
            @"Verbano-Cusio-Ossola"  : @"R=59 G=104 B=188",
            @"Torino"                : @"R=60 G=105 B=188",
            @"Novara"                : @"R=60 G=105 B=189",
            @"Cuneo"                 : @"R=61 G=104 B=188",
            @"Biella"                : @"R=61 G=105 B=189",
            @"Asti"                  : @"R=61 G=106 B=189",
            @"Alessandria"           : @"R=61 G=106 B=190"
        },
        regions[12] :
        @{
            @"Taranto"               : @"R=61 G=104 B=188",
            @"Lecce"                 : @"R=60 G=105 B=188",
            @"Foggia"                : @"R=60 G=105 B=189",
            @"Brindisi"              : @"R=61 G=105 B=189",
            @"Barletta-Andria-Trani" : @"R=61 G=106 B=189",
            @"Bari"                  : @"R=61 G=106 B=190"
        },
        regions[13] :
        @{
            @"Sassari"               : @"R=59 G=104 B=187",
            @"Oristano"              : @"R=59 G=104 B=188",
            @"Olbia-Tempio"          : @"R=61 G=104 B=188",
            @"Ogliastra"             : @"R=60 G=105 B=188",
            @"Nuoro"                 : @"R=60 G=105 B=189",
            @"Medio Campidano"       : @"R=61 G=105 B=189",
            @"Carbonia-Iglesias"     : @"R=61 G=106 B=189",
            @"Cagliari"              : @"R=61 G=106 B=190"
        },
        regions[14] :
        @{
            @"Trapani"               : @"R=59 G=103 B=187",
            @"Siracusa"              : @"R=59 G=104 B=187",
            @"Ragusa"                : @"R=59 G=104 B=188",
            @"Palermo"               : @"R=61 G=104 B=188",
            @"Messina"               : @"R=60 G=105 B=188",
            @"Enna"                  : @"R=60 G=105 B=189",
            @"Catania"               : @"R=61 G=105 B=189",
            @"Caltanissetta"         : @"R=61 G=106 B=189",
            @"Agrigento"             : @"R=61 G=106 B=190"
        },
        regions[15] :
        @{
            @"Siena"                 : @"R=59 G=103 B=186",
            @"Prato"                 : @"R=59 G=103 B=187",
            @"Pistoia"               : @"R=59 G=104 B=187",
            @"Pisa"                  : @"R=59 G=104 B=188",
            @"Massa e Carrara"       : @"R=61 G=104 B=188",
            @"Lucca"                 : @"R=60 G=105 B=188",
            @"Livorno"               : @"R=60 G=105 B=189",
            @"Grosseto"              : @"R=61 G=105 B=189",
            @"Firenze"               : @"R=61 G=106 B=189",
            @"Arezzo"                : @"R=61 G=106 B=190"
        },
        regions[16] :
        @{
            @"Trento"                : @"R=61 G=106 B=189",
            @"Bolzano"               : @"R=61 G=106 B=190"
        },
        regions[17] :
        @{
            @"Terni"                 : @"R=61 G=106 B=189",
            @"Perugia"               : @"R=61 G=106 B=190"
        },
        regions[18] :
        @{
            @"Aosta"                 : @"R=61 G=106 B=190"
        },
        regions[19] :
        @{
            @"Vicenza"               : @"R=59 G=104 B=188",
            @"Verona"                : @"R=61 G=104 B=188",
            @"Venezia"               : @"R=60 G=105 B=188",
            @"Treviso"               : @"R=60 G=105 B=189",
            @"Rovigo"                : @"R=61 G=105 B=189",
            @"Padova"                : @"R=61 G=106 B=189",
            @"Belluno"               : @"R=61 G=106 B=190"
        }
    };
    
    serviceTypeIco =
    @{
        @"0" : @"services_ico_general",
        @"1" : @"services_ico_caldaie",
        @"2" : @"services_ico_cancelli",
        @"3" : @"services_ico_condizionamento",
        @"4" : @"services_ico_electricista",
        @"5" : @"services_ico_idraulica",
        @"6" : @"services_ico_porte"
    };
}

+(NSDictionary*) GetJsonFromUrl:(NSString*)url
{
    NSString* webServiceUrl = [NSString stringWithFormat:@"%@",url];
    
    NSString* webServiceDataAsJson = [NSString stringWithContentsOfURL:[NSURL URLWithString:webServiceUrl]
                                                              encoding:NSUTF8StringEncoding
                                                                 error:NULL];
    
//    webServiceDataAsJson = [webServiceDataAsJson substringFromIndex:1];
//    webServiceDataAsJson = [webServiceDataAsJson substringToIndex:[webServiceDataAsJson length]-1];
//    
//    webServiceDataAsJson = [webServiceDataAsJson stringByReplacingOccurrencesOfString: @"\\\"" withString:@"\""];
    
    return [webServiceDataAsJson JSONValue];
}

+(NSString*) GetServiceTypeUrl
{
    return @"http://chiediunpreventivo.com/api/v1?m=sl";
}

+(NSString*) GetSearchUrl
{
    return @"http://chiediunpreventivo.com/api/v1?m=cl&loc=Roma&ids=3";
}

+(NSString*) GetSendMailUrl
{
    return @"http://chiediunpreventivo.com/api/v1?m=sd";
}

+(NSString*) GetCaptchaUrl
{
    return @"http://chiediunpreventivo.com/captcha/captchasecurityimage.php";
}

//+(NSArray*) GetRGBAsFromImage:(UIImage*)image atX:(int)xx andY:(int)yy count:(int)count
//{
//    NSMutableArray *result = [NSMutableArray arrayWithCapacity:count];
//    
//    // First get the image into your data buffer
//    CGImageRef imageRef = [image CGImage];
//    NSUInteger width = CGImageGetWidth(imageRef);
//    NSUInteger height = CGImageGetHeight(imageRef);
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    unsigned char *rawData = (unsigned char*) calloc(height * width * 4, sizeof(unsigned char));
//    NSUInteger bytesPerPixel = 4;
//    NSUInteger bytesPerRow = bytesPerPixel * width;
//    NSUInteger bitsPerComponent = 8;
//    CGContextRef context = CGBitmapContextCreate(rawData, width, height,
//                                                 bitsPerComponent, bytesPerRow, colorSpace,
//                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
//    CGColorSpaceRelease(colorSpace);
//    
//    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
//    CGContextRelease(context);
//    
//    // Now your rawData contains the image data in the RGBA8888 pixel format.
//    int byteIndex = (bytesPerRow * yy) + xx * bytesPerPixel;
//    for (int ii = 0 ; ii < count ; ++ii)
//    {
//        CGFloat red   = (rawData[byteIndex]     * 1.0) / 255.0;
//        CGFloat green = (rawData[byteIndex + 1] * 1.0) / 255.0;
//        CGFloat blue  = (rawData[byteIndex + 2] * 1.0) / 255.0;
//        CGFloat alpha = (rawData[byteIndex + 3] * 1.0) / 255.0;
//        byteIndex += 4;
//        
//        UIColor *acolor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
//        [result addObject:acolor];
//    }
//    
//    free(rawData);
//    
//    return result;
//}
//
+(UIColor*) ColorOfPoint:(CGPoint)point withImage:(UIView*)view
{
    unsigned char pixel[4] = {0};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pixel, 1, 1, 8, 4, colorSpace, kCGImageAlphaPremultipliedLast);
    
    CGContextTranslateCTM(context, -point.x, -point.y);
    
    [view.layer renderInContext:context];
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    UIColor *color = [UIColor colorWithRed:pixel[0]/255.0 green:pixel[1]/255.0 blue:pixel[2]/255.0 alpha:pixel[3]/255.0];
    
    return color;
}
//
//+(UIImage*) TakeScreenShot:(UIViewController*)viewController
//{
//    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
//        UIGraphicsBeginImageContextWithOptions(viewController.view.window.bounds.size, NO, [UIScreen mainScreen].scale);
//    else
//        UIGraphicsBeginImageContext(viewController.view.window.bounds.size);
//
//    [viewController.view.window.layer renderInContext:UIGraphicsGetCurrentContext()];
//
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    //NSData * data = UIImagePNGRepresentation(image);
//    //[data writeToFile:@"foo.png" atomically:YES];
//    
//    UIImageWriteToSavedPhotosAlbum( image, nil, nil, nil );
//    
//    return image;
//}
//
//+(void) GetRGBComponents:(CGFloat[3])components forColor:(UIColor*)color
//{
//    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
//    unsigned char resultingPixel[4];
//    CGContextRef context = CGBitmapContextCreate(&resultingPixel,
//                                                 1,
//                                                 1,
//                                                 8,
//                                                 4,
//                                                 rgbColorSpace,
//                                                 kCGImageAlphaNoneSkipLast);
//    CGContextSetFillColorWithColor(context, [color CGColor]);
//    CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
//    CGContextRelease(context);
//    CGColorSpaceRelease(rgbColorSpace);
//    
//    for (int component = 0; component < 3; component++) {
//        components[component] = resultingPixel[component] / 255.0f;
//    }
//}

+(NSString*) GetRegionByRed:(int)red green:(int)green blue:(int)blue
{
    NSString* rgbToLookFor = [NSString stringWithFormat:@"R=%d G=%d B=%d",red, green, blue];
    
    NSString* region = nil;
    for( NSString* key in regionsRgb )
    {
        NSString* rgb = [regionsRgb objectForKey:key];
        
        if( [rgb isEqualToString:rgbToLookFor] )
        {
            region = key;
            break;
        }
    }
    
    return region;
}

+(NSString*) GetMapByRegion:(NSString*)region
{
    return [regionsMap objectForKey:region];
}

+(NSString*) GetSubregionByRegion:(NSString*)region andRed:(int)red green:(int)green blue:(int)blue
{
    NSDictionary* subregionsForRegion = [subRegionsRgb objectForKey:region];
    if( subregionsForRegion == nil )
        return nil;
    
    NSString* rgbToLookFor = [NSString stringWithFormat:@"R=%d G=%d B=%d",red, green, blue];

    NSString* subRegion = nil;
    for( NSString* key in subregionsForRegion )
    {
        NSString* rgb = [subregionsForRegion objectForKey:key];
        
        if( [rgb isEqualToString:rgbToLookFor] )
        {
            subRegion = key;
            break;
        }
    }
    
    return subRegion;
}

+(NSString*) GetServiceTypeIcon:(NSString*)type
{
    NSString* defaultValue = (NSString*) [serviceTypeIco objectForKey:@"0"];
    NSString* value = (NSString*) [serviceTypeIco objectForKey:type];
    
    if( value == nil )
    {
        value = defaultValue;
    }

    return value;
}

@end

