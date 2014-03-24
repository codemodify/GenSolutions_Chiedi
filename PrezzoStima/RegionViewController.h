//
//  SearchViewController.h
//  PrezzoStima
//
//  Created by Nicolae Carabut on 1/27/13.
//  Copyright (c) 2013 GenSolutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "DataStructures.h"

@interface RegionViewController : UIViewController<UIScrollViewDelegate>

    @property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;
    @property (weak, nonatomic) IBOutlet UIImageView *BacgroundImageView;

@end
