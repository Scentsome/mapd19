//
//  DetailViewController.m
//  AppSearcher_with_AFNetworking
//
//  Created by mac on 2015/4/4.
//  Copyright (c) 2015年 com.zencher.demo. All rights reserved.
//

#import "DetailViewController.h"
#import "AppDelegate.h"

#define FavoriteFileName @"myFavorite.plist"

#import <AVFoundation/AVFoundation.h>
@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *previewBtn;
@property NSString * iconURLString;
@property NSString * previewURLString;
@property AVPlayer * avPlayer;
@property (weak, nonatomic) IBOutlet UILabel *artistName;
@property NSMutableDictionary * currentFavorites;
@end

@implementation DetailViewController

-(NSString *) docFolder {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}
-(NSString *) fakeDoc {
    return @"/Users/mac/Desktop/tmp";
}
-(void) loadData {
    NSString * filePath = [[self docFolder] stringByAppendingPathComponent:FavoriteFileName];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
        self.currentFavorites = [NSMutableDictionary dictionaryWithContentsOfFile:filePath];
    }else {
        self.currentFavorites = [@{} mutableCopy];
    }
}

-(void) saveData {
    NSString * filePath = [[self docFolder] stringByAppendingPathComponent:FavoriteFileName];
    [self.currentFavorites writeToFile:filePath atomically:YES];
}
- (IBAction)preview:(id)sender {
    [self.avPlayer play];
}
- (IBAction)addToFavorite:(id)sender {
    AppDelegate * appDelegate = [UIApplication sharedApplication].delegate ;
    
    if ([appDelegate isLogined]) {
        NSLog(@"add to record");
        
        NSNumber * itemID = self.item[@"trackId"];
        NSLog(@"track id %@", itemID);
        
        [self.currentFavorites setObject:self.item forKey:itemID.stringValue];
        
        [self saveData];
        
    }else {
        UIViewController * loginVC =  [self.storyboard instantiateViewControllerWithIdentifier:@"LoginVC"];
        [self presentViewController:loginVC animated:YES completion:nil];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.iconURLString = self.item[@"artworkUrl60"];
    self.previewURLString = self.item[@"previewUrl"];
    
    self.artistName.text = self.item[@"artistName"];
    
    self.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.iconURLString]]];
    NSError * error;
    self.avPlayer = [[AVPlayer alloc] initWithURL:[NSURL URLWithString:self.previewURLString]];
    
    if (error != nil) {
        NSLog(@"%@", error);
    }
//    [self.avPlayer prepareToPlay];
    
    // Do any additional setup after loading the view.
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
