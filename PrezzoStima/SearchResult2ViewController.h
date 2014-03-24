//
//  SearchResult2ViewController.h
//  PrezzoStima
//
//  Created by Nicolae Carabut on 1/27/13.
//  Copyright (c) 2013 GenSolutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegionViewController.h"
#import "DataStructures.h"

@interface SearchResult2ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,SearchCriteriaDelegate>

    @property (weak, nonatomic) IBOutlet UIView *ProgressView1;
    @property (weak, nonatomic) IBOutlet UIActivityIndicatorView *ProgressView2;
    @property (weak, nonatomic) IBOutlet UITableView *SearchResultTable;
    @property (weak, nonatomic) IBOutlet UIBarButtonItem *Location;
    @property (weak, nonatomic) IBOutlet UIBarButtonItem *Service;
    @property (weak, nonatomic) IBOutlet UIToolbar *HelperToolbar;
@property (weak, nonatomic) IBOutlet UIToolbar *BottomToolbar;

    - (IBAction)Search:(id)sender;
    - (IBAction)GotoDashboard:(id)sender;
    - (IBAction)AskForPrices:(id)sender;
    - (IBAction)UnSelectAll:(id)sender;
    - (IBAction)SelectAll:(id)sender;

@end
