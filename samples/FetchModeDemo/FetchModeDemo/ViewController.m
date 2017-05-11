//
//  ViewController.m
//  FetchModeDemo
//
//  Created by chronoer on 13/10/11.
//  Copyright (c) 2013年 Zencher Co., Ltd. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSURLConnectionDataDelegate,NSURLSessionDownloadDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl *stateSegment;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property NSMutableData * imageData;
@property (strong, nonatomic)
NSURLSessionDownloadTask* downloadTask;
@property (strong, nonatomic) NSURLSession* urlSession;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@end

@implementation ViewController
- (IBAction)getRemoteImage:(id)sender {
    if (!self.urlSession) {
        NSString* sessionID = [@"com.zencher.backgroundsession." stringByAppendingFormat:@"%d", 34];
        NSURLSessionConfiguration* config = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:sessionID];
        self.urlSession = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue: [NSOperationQueue new]];
    }
    NSString * urlString = @"https://upload.wikimedia.org/wikipedia/commons/c/c5/Polarlicht_2_kmeans_16_large.png";
    
    NSURL * url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest
                             requestWithURL:url];
    self.downloadTask = [self.urlSession downloadTaskWithRequest:request];
    [self.downloadTask resume];
}
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
 didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes {
    
}
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error {
    if (error) {
//        NSString* lastPathComponent = [task.originalRequest.URL lastPathComponent];
        
        
    }else{
        
    }
}
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    dispatch_async(dispatch_get_main_queue(), ^{ self.progressView.progress = (double)totalBytesWritten / (double)totalBytesExpectedToWrite;
    });
}

-(void) URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    NSLog(@"%@",location.absoluteString);
    NSData * data = [NSData dataWithContentsOfURL:location];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.imageView.image = [UIImage imageWithData:data];
        self.stateLabel.text = @"Done";
    });
    
}

- (void)populateDataWithCompletionHandler:
(void (^)(UIBackgroundFetchResult))completionHandler{
    switch (self.stateSegment.selectedSegmentIndex) {
        case 0:{
            [UIApplication sharedApplication].applicationIconBadgeNumber++;
//            [self getImage];
            completionHandler(UIBackgroundFetchResultNewData);
            [self getRemoteImage:nil];
            
            break;
        }
        case 1:{
            completionHandler(UIBackgroundFetchResultNoData);
            break;
        }case 2:{
            completionHandler(UIBackgroundFetchResultFailed);
            break;
        }
        default:
            break;
    }}

-(void) getImage{
    self.imageData = [NSMutableData data];
    NSString * urlString = @"http://www.desktopas.com/files/2013/06/Nature-Wallpaper-2560x1600.jpg";
    
    NSURL * url = [NSURL URLWithString:urlString];
    [NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:url] delegate:self];
//    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:[NSOperationQueue new] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
//            self.imageView.image = [UIImage imageWithData:data];
//        });
//        
//    }];
}

-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [self.imageData appendData:data];
    
    self.imageView.image = [UIImage imageWithData:self.imageData];
}

-(void) connectionDidFinishLoading:(NSURLConnection *)connection{
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleBackgroundTransfer:) name:@"BackgroundTransferNotification" object:nil];
	// Do any additional setup after loading the view, typically from a nib.
}
- (void)handleBackgroundTransfer:(NSNotification*)notification {
    dispatch_async(dispatch_get_main_queue(), ^{
//        self.downloadButton.title = @"Downloaded";
        self.progressView.hidden = YES;
        void(^completionHandler)(void) = notification.userInfo[@"completionHandler"];
        if (completionHandler) {
            completionHandler();
        }
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
