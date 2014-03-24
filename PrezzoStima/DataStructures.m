//
//  DataStructures.m
//  PrezzoStima
//
//  Created by Nicolae Carabut on 1/27/13.
//  Copyright (c) 2013 GenSolutions. All rights reserved.
//

#import "DataStructures.h"

static SearchCriteria* s_SearchCriteria = nil;

@implementation SearchCriteria

+(void)Init
{
    if( s_SearchCriteria == nil )
        s_SearchCriteria = [SearchCriteria new];
}

+(BOOL)IsInit
{
    return s_SearchCriteria != nil;
}


#pragma mark Set

+(void)SetRegion:(NSString*)region
{
    s_SearchCriteria.Region = region;
}

+(void)SetSubRegion:(NSString*)subRegion
{
    s_SearchCriteria.SubRegion = subRegion;
}

+(void)SetServiceType:(NSString*)serviceType
{
    s_SearchCriteria.ServiceType = serviceType;
}

+(void)SetServiceTypeLabel:(NSString*)serviceTypeLabel
{
    s_SearchCriteria.ServiceTypeLabel = serviceTypeLabel;
}

+(void)SetProviders:(NSArray*)providers
{
    s_SearchCriteria.Providers = providers;
}

+(void)SetText:(NSString*)text
{
    s_SearchCriteria.Text = text;
}

+(void)SetPhotos:(NSArray *)photos
{
    s_SearchCriteria.Photos = photos;
}


#pragma mark Get

+(NSString*)GetRegion
{
    return s_SearchCriteria.Region;
}

+(NSString*)GetSubRegion
{
    return s_SearchCriteria.SubRegion;
}

+(NSString*)GetServiceType
{
    return s_SearchCriteria.ServiceType;
}

+(NSString*)GetServiceTypeLabel
{
    return s_SearchCriteria.ServiceTypeLabel;
}

+(NSArray*)GetProviders
{
    return s_SearchCriteria.Providers;
}

+(NSString*)GetText
{
    return s_SearchCriteria.Text;
}

+(NSArray*)GetPhotos
{
    return s_SearchCriteria.Photos;
}

@end

@implementation SearchResult
@end
