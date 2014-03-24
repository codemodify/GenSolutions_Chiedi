//
//  SubRegionViewController.m
//  PrezzoStima
//
//  Created by Nicolae Carabut on 2/2/13.
//  Copyright (c) 2013 GenSolutions. All rights reserved.
//

#import "SubRegionViewController.h"
#import "ServiceTypeViewController.h"
#import "DataStructures.h"
#import "Helpers.h"

@interface SubRegionViewController()
{
    UIImageView* Map;
    bool _firstTimeLoad;
}
@end

@implementation SubRegionViewController

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
                                                                                action:@selector(SubregionChosen:)];

    UIImage* image = [UIImage imageNamed:[Helpers GetMapByRegion:[SearchCriteria GetRegion]]];
    
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

    [self.navigationItem setTitle:@"Provincia"];
    
    _firstTimeLoad = true;
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

- (IBAction)SubregionChosen:(id)sender {
    
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
    NSString* subRegion = [Helpers GetSubregionByRegion:[SearchCriteria GetRegion] andRed:r green:g blue:b];
    [SearchCriteria SetSubRegion:subRegion];
    
    // Switch screens
    ServiceTypeViewController*
        viewController = [[ServiceTypeViewController alloc] init];
        viewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self.navigationController pushViewController:viewController
                                         animated:YES];
}
@end
