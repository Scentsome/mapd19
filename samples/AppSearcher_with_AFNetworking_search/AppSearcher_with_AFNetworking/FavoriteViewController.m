//
//  FavoriteViewController.m
//  AppSearcher_with_AFNetworking
//
//  Created by mac on 2015/4/6.
//  Copyright (c) 2015年 com.zencher.demo. All rights reserved.
//

#import "FavoriteViewController.h"

#define FavoriteFileName @"myFavorite.plist"
@interface FavoriteViewController ()<UISearchControllerDelegate>
@property NSArray * items;
@property NSArray * filteredArray;
@property (strong, nonatomic) UISearchController *searchController;
@property BOOL isSearching;
@end

@implementation FavoriteViewController
-(NSString *) fakeDoc {
    return @"/Users/mac/Desktop/tmp";
}
-(NSString *) docFolder {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}

-(void) loadData {
    NSString * filePath = [[self docFolder] stringByAppendingPathComponent:FavoriteFileName];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
        self.items = [[NSDictionary dictionaryWithContentsOfFile:filePath] allValues];
        
        self.filteredArray = [@[] copy];
    }else {
        self.items = nil;
        
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;

    self.searchController.searchBar.scopeButtonTitles = @[@"Track name",@"Artist Name"];
//    self.searchController.searchBar.delegate = self;
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.searchController.dimsBackgroundDuringPresentation = NO;
//    self.definesPresentationContext = YES;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)searchText:(NSString *)searchString
{
    NSArray * trackNames = [self.items valueForKey:@"trackName"];
    NSPredicate * predicate = [NSPredicate predicateWithBlock:^BOOL(NSString * evaluatedObject, NSDictionary *bindings) {
        if ([evaluatedObject hasPrefix:searchString]) {
            return YES;
        }
        
        return NO;
    }];
    NSArray * matchedNames = [trackNames filteredArrayUsingPredicate:predicate];
    self.filteredArray = [matchedNames copy];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *searchString = searchController.searchBar.text;

    if ([searchString isEqualToString:@""]) {
        self.isSearching = NO;
    }else{
        self.isSearching = YES;
    }
    NSLog(@"%@", searchString);
    
    [self searchText:searchString];
    [self.tableView reloadData];
}
- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    NSLog(@"change scop button to %ld",(long)selectedScope );
//    [self updateSearchResultsForSearchController:self.searchController];
}
-(void)viewWillAppear:(BOOL)animated{
    [self loadData];
    [self.tableView reloadData];
//    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (self.isSearching) {
        return self.filteredArray.count;
    }
    return self.items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"  forIndexPath:indexPath];

    
    if (self.isSearching) {
        cell.textLabel.text = self.filteredArray[indexPath.row];
    }else{
        cell.textLabel.text = self.items[indexPath.row][@"trackName"] ;
    }
    
    
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
@end
