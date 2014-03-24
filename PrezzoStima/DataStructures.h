//
//  DataStructures.h
//  PrezzoStima
//
//  Created by Nicolae Carabut on 1/27/13.
//  Copyright (c) 2013 GenSolutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SearchCriteria : NSObject

    @property NSString* Region;
    @property NSString* SubRegion;
    @property NSString* ServiceType;
    @property NSString* ServiceTypeLabel;
    @property NSArray*  Providers;
    @property NSString* Text;
    @property NSArray*  Photos;

    +(void)Init;
    +(BOOL)IsInit;

    +(void)SetRegion:(NSString*)region;
    +(void)SetSubRegion:(NSString*)subRegion;
    +(void)SetServiceType:(NSString*)serviceType;
    +(void)SetServiceTypeLabel:(NSString*)serviceTypeLabel;
    +(void)SetProviders:(NSArray*)providers;
    +(void)SetText:(NSString*)text;
    +(void)SetPhotos:(NSArray*)photos;

    +(NSString*)GetRegion;
    +(NSString*)GetSubRegion;
    +(NSString*)GetServiceType;
    +(NSString*)GetServiceTypeLabel;
    +(NSArray*) GetProviders;
    +(NSString*)GetText;
    +(NSArray*) GetPhotos;

@end

@interface SearchResult : NSObject

    @property NSString* ProviderId;
    @property NSString* Provider;
    @property NSString* Phone1;
    @property NSString* Phone2;
    @property bool      IsSelected;

@end


@protocol SearchCriteriaDelegate <NSObject>

    @optional
    - (void)SearchCriteriaIsReady;

@end
