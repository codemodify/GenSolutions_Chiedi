//
//  SearchViewController.m
//  PrezzoStima
//
//  Created by Nicolae Carabut on 1/27/13.
//  Copyright (c) 2013 GenSolutions. All rights reserved.
//

#import "RegionViewController.h"
#import "SubRegionViewController.h"
#import "SettingsViewController.h"
#import "DataStructures.h"
#import "Helpers.h"

@interface RegionViewController ()
{
    UIImageView *Map;
    bool _firstTimeLoad;
}
@end

@implementation RegionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(RegionChosen:)];

    UIImage* image = [UIImage imageNamed:@"Regions" ];

    Map = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    [Map setUserInteractionEnabled:YES];
    [Map setContentMode:UIViewContentModeCenter];
    [Map setImage:image];
    [Map addGestureRecognizer:singleTap];
    
    self.ScrollView.pagingEnabled = NO;
    self.ScrollView.contentSize = Map.frame.size;
    self.ScrollView.showsHorizontalScrollIndicator = YES;
    self.ScrollView.showsVerticalScrollIndicator = YES;
    self.ScrollView.scrollsToTop = NO;
    self.ScrollView.delegate = self;
	self.ScrollView.maximumZoomScale = 2.;
	self.ScrollView.minimumZoomScale = .2;
	self.ScrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.ScrollView addSubview:Map];
    
    [SearchCriteria Init];
    [Helpers Init];
    
    [self.navigationItem setTitle:@"Regione"];

    _firstTimeLoad = true;
    
    // Set settings button
    UIButton* settingsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    settingsButton.userInteractionEnabled = YES;
    [settingsButton setFrame:CGRectMake(0.0,0.0, 33.0, 33. )];
    [settingsButton setImage:[UIImage imageNamed:@"misc_settings"]
                    forState:UIControlStateNormal];
    [settingsButton addTarget:self
                       action:@selector(ShowSettings:)
             forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:settingsButton];
}

-(void)viewDidAppear:(BOOL)animated
{
    if( _firstTimeLoad )
    {
        [self.ScrollView zoomToRect: CGRectMake(0, 0, self.ScrollView.contentSize.width, self.ScrollView.contentSize.height)
                           animated:TRUE];
        
        _firstTimeLoad = false;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)RegionChosen:(id)sender
{
    // Get the RGB from the touched point
    UITapGestureRecognizer* uiTapGestureRecognizer = (UITapGestureRecognizer*) sender;
    
    CGPoint tapPoint = [uiTapGestureRecognizer locationInView:Map];

    CGFloat rgb[4];

    UIColor*
        color = [Helpers ColorOfPoint:tapPoint withImage:Map];
        [color getRed:&rgb[0] green:&rgb[1] blue:&rgb[2] alpha:&rgb[3]];

    int r = (int)( rgb[0] * 255.0 );
    int g = (int)( rgb[1] * 255.0 );
    int b = (int)( rgb[2] * 255.0 );

    // Set the region
    NSString* region = [Helpers GetRegionByRed:r green:g blue:b];
    if( region == nil )
        return;
    
    [SearchCriteria SetRegion:region];

    // Switch screens
    SubRegionViewController*
        viewController = [[SubRegionViewController alloc] init];
        viewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self.navigationController pushViewController:viewController
                                         animated:YES];
}

-(IBAction)ShowSettings:(id)sender
{
    SettingsViewController*
    viewController = [[SettingsViewController alloc] init];
    viewController.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    
    [self presentViewController:viewController
                       animated:YES
                     completion:nil];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
	return Map;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGRect innerFrame = Map.frame;
    CGRect scrollerBounds = scrollView.bounds;
    
    if ( ( innerFrame.size.width < scrollerBounds.size.width ) || ( innerFrame.size.height < scrollerBounds.size.height ) )
    {
        CGFloat tempx = Map.center.x - ( scrollerBounds.size.width / 2 );
        CGFloat tempy = Map.center.y - ( scrollerBounds.size.height / 2 );
        CGPoint myScrollViewOffset = CGPointMake( tempx, tempy);
        
        scrollView.contentOffset = myScrollViewOffset;
        
    }
    
    UIEdgeInsets anEdgeInset = { 0, 0, 0, 0};
    if ( scrollerBounds.size.width > innerFrame.size.width )
    {
        anEdgeInset.left = (scrollerBounds.size.width - innerFrame.size.width) / 2;
        anEdgeInset.right = -anEdgeInset.left;  // I don't know why this needs to be negative, but that's what works
    }
    if ( scrollerBounds.size.height > innerFrame.size.height )
    {
        anEdgeInset.top = (scrollerBounds.size.height - innerFrame.size.height) / 2;
        anEdgeInset.bottom = -anEdgeInset.top;  // I don't know why this needs to be negative, but that's what works
    }
    scrollView.contentInset = anEdgeInset;
}

@end
