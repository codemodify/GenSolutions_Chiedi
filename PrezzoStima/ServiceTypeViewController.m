//
//  ServiceTypeViewController.m
//  PrezzoStima
//
//  Created by Nicolae Carabut on 2/4/13.
//  Copyright (c) 2013 GenSolutions. All rights reserved.
//

#import "ServiceTypeViewController.h"
#import "SearchResult2ViewController.h"
#import "DataStructures.h"
#import "Helpers.h"
#import "ServiceTypeCell.h"

@interface ServiceTypeViewController ()
{
    NSMutableArray* _serviceTypeIdList;
    NSMutableArray* _serviceTypeLabelList;
    NSMutableArray* _serviceTypeLogoList;

    NSMutableArray* _inDownloadServiceTypeIdList;
    NSMutableArray* _inDownloadServiceTypeLabelList;
    NSMutableArray* _inDownloadServiceTypeLogoList;
}
@end

@implementation ServiceTypeViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //[self.navigationItem setTitle:[SearchCriteria GetSubRegion]];
    [self.navigationItem setTitle:@"Servizio"];

    // Download the list from server
    _serviceTypeIdList = [NSMutableArray new];
    _serviceTypeLabelList = [NSMutableArray new];
    _serviceTypeLogoList = [NSMutableArray new];
    
    _inDownloadServiceTypeIdList = [NSMutableArray new];
    _inDownloadServiceTypeLabelList = [NSMutableArray new];
    _inDownloadServiceTypeLogoList = [NSMutableArray new];
    
    NSOperationQueue* operationQueue = [NSOperationQueue new];
    
    [operationQueue addOperationWithBlock:
     ^{
         NSDictionary* dataFromServer = [Helpers GetJsonFromUrl:[Helpers GetServiceTypeUrl]];
         NSArray* array = [dataFromServer objectForKey:@"data"];
         
         for( int i=0; i<[array count]; i++ )
         {
             NSDictionary* serviceType = [array objectAtIndex:i];
             
             [_inDownloadServiceTypeIdList addObject:[serviceType objectForKey:@"ID"]];
             [_inDownloadServiceTypeLabelList addObject:[serviceType objectForKey:@"denumirea"]];
             [_inDownloadServiceTypeLogoList addObject:[serviceType objectForKey:@"logo"]];
         }

//         // FAKE DATA
//         for( int i=0; i<1000; i++ )
//         {
//             [_inDownloadServiceTypeIdList addObject: [NSString stringWithFormat:@"%d",i] ];
//             [_inDownloadServiceTypeLabelList addObject: [NSString stringWithFormat:@"Service %d",i] ];
//         }
         
         [[NSOperationQueue mainQueue] addOperationWithBlock:
          ^{
              _serviceTypeIdList = _inDownloadServiceTypeIdList;
              _serviceTypeLabelList = _inDownloadServiceTypeLabelList;
              _serviceTypeLogoList = _inDownloadServiceTypeLogoList;

              [self.tableView reloadData];
          }];
     }];
    
    [self.tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg"]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _serviceTypeIdList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
//    
//    cell.textLabel.text = (NSString*) [_serviceTypeLabelList objectAtIndex:indexPath.row];

    ServiceTypeCell* cell = (ServiceTypeCell*) [tableView dequeueReusableCellWithIdentifier:@"ServiceTypeCell"];
    if( cell == nil )
    {
        NSArray* topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ServiceTypeCellView" owner:nil options:nil];
        for( id currentObject in topLevelObjects )
        {
            if( [currentObject isKindOfClass:[ServiceTypeCell class]] )
            {
                cell = (ServiceTypeCell*) currentObject;
                break;
            }
        }
    }

    NSString* serviceType = (NSString*) [_serviceTypeLogoList objectAtIndex:indexPath.row];
    
    cell.Separator.image = [UIImage imageNamed:@"UITableViewCell_separator"];
    cell.Icon.image = [UIImage imageNamed: [Helpers GetServiceTypeIcon:serviceType] ];
    cell.Label.text = (NSString*) [_serviceTypeLabelList objectAtIndex:indexPath.row];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [SearchCriteria SetServiceType: (NSString*) [_serviceTypeIdList objectAtIndex:indexPath.row] ];
    [SearchCriteria SetServiceTypeLabel: (NSString*) [_serviceTypeLabelList objectAtIndex:indexPath.row] ];

    SearchResult2ViewController*
        viewController = [[SearchResult2ViewController alloc] init];
        viewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self.navigationController pushViewController:viewController
                                         animated:YES];

    
//    SearchResult2ViewController*
//        searchResult2ViewController = (SearchResult2ViewController*) [[[self navigationController] viewControllers] objectAtIndex:0 ];
//
//        [[self navigationController] popToRootViewControllerAnimated: YES];

        [viewController SearchCriteriaIsReady];

    
    
//    SearchResult2ViewController*
//        searchResult2ViewController = (SearchResult2ViewController*) [[[self navigationController] viewControllers] objectAtIndex:0 ];
//    
//    [[self navigationController] popToRootViewControllerAnimated: YES];
//    
//    [searchResult2ViewController SearchCriteriaIsReady];
}

@end

