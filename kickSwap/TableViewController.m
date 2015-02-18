//
//  PFQueryTableViewController+TableViewController.m
//  kickSwap
//
//  Created by Hugh A. Miles on 1/3/15.
//  Copyright (c) 2015 HAMtech. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController()

@end

@implementation TableViewController

@synthesize tableView;


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Pull data from parseTimeline
    [self performSelector:@selector(retrieveFromParse)];
    
    // Add pull to refresh to tableview
    ODRefreshControl *refreshControl = [[ODRefreshControl alloc] initInScrollView:self.tableView];
    [refreshControl addTarget:self action:@selector(dropViewDidBeginRefreshing:) forControlEvents:UIControlEventValueChanged];
};

- (void) retrieveFromParse {
    
    PFQuery *retrieveData = [PFQuery queryWithClassName:@"Timeline"];
    
    [retrieveData findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSLog(@"%@",objects);
        if (!error) {
            colorsArray = [[NSArray alloc] initWithArray:objects];
        }
        
        [tableView reloadData];
    }];

}

- (void) dropViewDidBeginRefreshing: (ODRefreshControl *)refreshControl {
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){[refreshControl endRefreshing];
    });
}

//////////Setup table of folder names////////////////////////////////////

//get number of sections in tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

//get number of rows by counting number of folders
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return colorsArray.count;
}

//setup cells in tableView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //setup cell
    static NSString *CellIdentifier = @"colorsCell";
    
    ksTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    PFObject *tempObject = [colorsArray objectAtIndex:indexPath.row];
    
   cell.cellTitle.text = [tempObject objectForKey:@"text"];  //object key from Parse
    
    return cell;
    
}


/*/user selects folder to add tag to
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"cell tapped");
    
    PFObject *tempObject = [colorsArray objectAtIndex:indexPath.row];
    NSLog(@"%@", tempObject.objectId);
    
    
    _infoDetailLabel.text = [tempObject objectForKey:@"detailInformation"];
    [self animateDetailView];
    
}

*/

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
