//
//  SearchResult2ViewController.m
//  PrezzoStima
//
//  Created by Nicolae Carabut on 1/27/13.
//  Copyright (c) 2013 GenSolutions. All rights reserved.
//

#import "SearchResult2ViewController.h"
#import "DataStructures.h"
#import "SearchResultCell.h"
#import "SearchResultSmallCell.h"
#import "UserInputViewController.h"

#import "Helpers.h"

@interface SearchResult2ViewController ()
{
    NSMutableArray* _searchResult;
    NSMutableArray* _inDownloadSearchResult;
}
@end

@implementation SearchResult2ViewController

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
    
//    WelcomeViewController*
//        viewController = [[WelcomeViewController alloc] init];
//        viewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//    
//    [self presentViewController:viewController
//                       animated:YES
//                     completion:nil];    
    
    self.SearchResultTable.delegate = self;
    self.SearchResultTable.dataSource = self;
    
    _searchResult = [NSMutableArray new];
    
    self.title = @"Fornitori"; //[SearchCriteria GetServiceType];
    self.Location.title = [SearchCriteria GetSubRegion];
    self.Service.title = [SearchCriteria GetServiceTypeLabel];
    
    [self.SearchResultTable setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg"]]];
    

    [self.HelperToolbar setBackgroundImage:[UIImage imageNamed:@"UIToolBarHelper_bg"]
                        forToolbarPosition:UIToolbarPositionAny
                                barMetrics:UIBarMetricsDefault];

    //
    UIButton* forwardButton = [UIButton buttonWithType:UIButtonTypeCustom];
        forwardButton.userInteractionEnabled = YES;
        [forwardButton setFrame:CGRectMake(0.0,0.0, 33.0, 33. )];
        [forwardButton setImage:[UIImage imageNamed:@"misc_next_arrow"]
                       forState:UIControlStateNormal];
        [forwardButton addTarget:self
                          action:@selector(AskForPrices:)
                forControlEvents:UIControlEventTouchUpInside];

    NSMutableArray*
        currentItems = [[NSMutableArray alloc] initWithArray:self.BottomToolbar.items];
        [currentItems addObject:[[UIBarButtonItem alloc] initWithCustomView:forwardButton]];

    self.BottomToolbar.items = currentItems;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)UnSelectAll:(id)sender
{
    for( int i=0; i < _searchResult.count; i++ )
    {
        SearchResult*
            searchResult = (SearchResult*) [_searchResult objectAtIndex:i];
            searchResult.IsSelected = false;
    }
    
    [self.SearchResultTable reloadData];
}

- (IBAction)SelectAll:(id)sender
{
    for( int i=0; i < _searchResult.count; i++ )
    {
        SearchResult*
            searchResult = (SearchResult*) [_searchResult objectAtIndex:i];
            searchResult.IsSelected = true;
    }
    
    [self.SearchResultTable reloadData];
}

- (IBAction)AskForPrices:(id)sender
{
    NSMutableArray* providers = [NSMutableArray new];

    for( int i=0; i < _searchResult.count; i++ )
    {
        SearchResult*
            searchResult = (SearchResult*) [_searchResult objectAtIndex:i];

        if( searchResult.IsSelected )
            [providers addObject:searchResult.ProviderId];
    }

    [SearchCriteria SetProviders:providers];
    
    UserInputViewController*
        viewController = [[UserInputViewController alloc] init];
        viewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self.navigationController pushViewController:viewController
                                         animated:YES];
}


#pragma mark - SearchCriteriaDelegate

- (void)SearchCriteriaIsReady
{
    self.ProgressView1.hidden = NO;
    self.ProgressView2.hidden = NO;
    
    NSOperationQueue* operationQueue = [NSOperationQueue new];

    [operationQueue addOperationWithBlock:
     ^{
         NSDictionary* dataFromServer = [Helpers GetJsonFromUrl:[Helpers GetSearchUrl]];
         NSArray* array = [dataFromServer objectForKey:@"data"];
         
         _inDownloadSearchResult = [NSMutableArray new];
         
         for( int i=0; i<[array count]; i++ )
         {
             NSDictionary* serviceType = [array objectAtIndex:i];
             
             SearchResult*
                 searchResult = [SearchResult new];
                 searchResult.ProviderId = [NSString stringWithFormat:@"%@" , [serviceType objectForKey:@"ID"] ];
                 searchResult.Provider = [NSString stringWithFormat:@"%@"   , [serviceType objectForKey:@"denumirea"]];
                 searchResult.Phone1 = [NSString stringWithFormat:@"%@"     , [serviceType objectForKey:@"tel1"]];
                 searchResult.Phone2 = [NSString stringWithFormat:@"%@"     , [serviceType objectForKey:@"tel2"]];
                 searchResult.IsSelected = true;
             
            [_inDownloadSearchResult addObject:searchResult];
         }

//         for( int i=0; i<100; i++ )
//         {
//             SearchResult*
//                 searchResult = [SearchResult new];
//                 searchResult.ProviderId = [NSString stringWithFormat:@"%d" , i ];
//                 searchResult.Provider = [NSString stringWithFormat:@"%d"   , i ];
//                 searchResult.Phone = [NSString stringWithFormat:@"%d"      , i ];
//                 searchResult.Email = [NSString stringWithFormat:@"%d"      , i ];
//                 searchResult.IsSelected = true;
//             
//             [_inDownloadSearchResult addObject:searchResult];
//         }

         [[NSOperationQueue mainQueue] addOperationWithBlock:
          ^{
              self.ProgressView1.hidden = YES;
              self.ProgressView2.hidden = YES;
              
              _searchResult = _inDownloadSearchResult;
              [self.SearchResultTable reloadData];
         }];
     }];
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchResult* searchResult = (SearchResult*) [_searchResult objectAtIndex:indexPath.row];
    
    if( [searchResult.Phone2 isEqualToString:@"0"])
        return 102;
    
    return 134;
}

//- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
//{
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchResult*
        searchResult = (SearchResult*) [_searchResult objectAtIndex:indexPath.row];
        searchResult.IsSelected = !searchResult.IsSelected;
    
    [tableView reloadData];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _searchResult.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* result = nil;
    SearchResult* searchResult = (SearchResult*) [_searchResult objectAtIndex:indexPath.row];

    if( [searchResult.Phone2 isEqualToString:@"0"])
    {
        SearchResultSmallCell* searchResultSmallCell = (SearchResultSmallCell*) [tableView dequeueReusableCellWithIdentifier:@"SearchResultSmallCell"];
        if( searchResultSmallCell == nil )
        {
            NSArray* topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"SearchResultSmallCell" owner:nil options:nil];
            for( id currentObject in topLevelObjects )
            {
                if( [currentObject isKindOfClass:[SearchResultSmallCell class]] )
                {
                    searchResultSmallCell = (SearchResultSmallCell*) currentObject;
                    break;
                }
            }
        }
        
        searchResultSmallCell.Separator.image = [UIImage imageNamed:@"UITableViewCell_separator"];
        searchResultSmallCell.Provider.text = searchResult.Provider;
        searchResultSmallCell.TelOne.text = searchResult.Phone1;
        [searchResultSmallCell.CallButtonOne setImage:[UIImage imageNamed:@"misc_result_call_bt"] forState:UIControlStateNormal];
        searchResultSmallCell.accessoryType = searchResult.IsSelected ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
        
        result = searchResultSmallCell;
    }
    else
    {
        SearchResultCell* searchResultCell = (SearchResultCell*) [tableView dequeueReusableCellWithIdentifier:@"SearchResultCell"];
        if( searchResultCell == nil )
        {
            NSArray* topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"SearchResultCell" owner:nil options:nil];
            for( id currentObject in topLevelObjects )
            {
                if( [currentObject isKindOfClass:[SearchResultCell class]] )
                {
                    searchResultCell = (SearchResultCell*) currentObject;
                    break;
                }
            }
        }

        searchResultCell.Separator.image = [UIImage imageNamed:@"UITableViewCell_separator"];
        searchResultCell.Provider.text = searchResult.Provider;
        searchResultCell.TelOne.text = searchResult.Phone1;
        searchResultCell.TelTwo.text = searchResult.Phone2;
        [searchResultCell.CallButtonOne setImage:[UIImage imageNamed:@"misc_result_call_bt"] forState:UIControlStateNormal];
        [searchResultCell.CallButtonTwo setImage:[UIImage imageNamed:@"misc_result_call_bt"] forState:UIControlStateNormal];
        searchResultCell.accessoryType = searchResult.IsSelected ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    
        result = searchResultCell;
    }
    
    return result;
}

@end
