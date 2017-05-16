//
//  ViewController.m
//  HostPeerInClass
//
//  Created by Michael on 16/05/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import "ViewController.h"
#import "PeersViewController.h"
#import <SkyWay/SKWPeer.h>
static NSString *const kAPIkey = @"acd68656-48f0-4995-bf97-504e592ca6d9";
static NSString *const kDomain = @"www.zencher.com";
@interface ViewController (){
    SKWPeer * hostPeer;
    NSString * peerID;
    SKWMediaConnection * mediaConnection;
    SKWMediaStream * localStream;
    SKWMediaStream * remoteStream;
}
@property (weak, nonatomic) IBOutlet UILabel *peerIDLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configuration ];
}

-(void) configuration {
    SKWPeerOption* option = [[SKWPeerOption alloc] init];
    
    option.key = kAPIkey;
    option.domain = kDomain;
    
    hostPeer	= [[SKWPeer alloc] initWithId:nil options:option];
    [self setPeerCallbacks:hostPeer];
    [self setupLocalStream];
}
-(void) setupLocalStream{
    [SKWNavigator initialize:hostPeer];
    
    SKWMediaConstraints* constraints = [[SKWMediaConstraints alloc] init];
    constraints.maxWidth = 960;
    constraints.maxHeight = 540;
    //	constraints.cameraPosition = SKW_CAMERA_POSITION_BACK;
    constraints.cameraPosition = SKW_CAMERA_POSITION_FRONT;
    
    localStream = [SKWNavigator getUserMedia:constraints];
}
- (void)setPeerCallbacks:(SKWPeer *)peer
{
    if (nil == peer)
    {
        return;
    }
    [peer on:SKW_PEER_EVENT_OPEN callback:^(NSObject* obj)
     {
         dispatch_async(dispatch_get_main_queue(), ^
         {
             if (YES == [obj isKindOfClass:[NSString class]]){
                 peerID = (NSString *)obj;
                 [_peerIDLabel setText:[NSString stringWithFormat:@"%@", peerID]];
             }
         });
     }];
    // !!!: Event/Call
    [peer on:SKW_PEER_EVENT_CALL callback:^(NSObject* obj)
     {
     }];
    // !!!: Event/Close
    [peer on:SKW_PEER_EVENT_CLOSE callback:^(NSObject* obj)
     {
     }];
    // !!!: Event/Disconnected
    [peer on:SKW_PEER_EVENT_DISCONNECTED callback:^(NSObject* obj)
     {
     }];
    // !!!: Event/Error
    [peer on:SKW_PEER_EVENT_ERROR callback:^(NSObject* obj)
     {
     }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)showPeers:(id)sender {
    [hostPeer listAllPeers:^(NSArray * onLinePeers) {
        PeersViewController * peerVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PeersVC"];
        
        peerVC.peers = onLinePeers;
        peerVC.didSelectPeer = ^(NSString * selectedPeer) {
            mediaConnection = [hostPeer callWithId:selectedPeer stream:localStream];
            [self setMediaCallbacks:mediaConnection];
            [self dismissViewControllerAnimated:YES completion:nil];
        };
        [self presentViewController:peerVC animated:YES completion:nil];
    }];
}

- (void)setMediaCallbacks:(SKWMediaConnection *)media
{
    [media on:SKW_MEDIACONNECTION_EVENT_STREAM callback:^(NSObject* obj)
     {
         // Add Stream;
         if (YES == [obj isKindOfClass:[SKWMediaStream class]])
         {
             SKWMediaStream* stream = (SKWMediaStream *)obj;
             [self setRemoteView:stream];
         }
         
     }];
    // !!!: MediaEvent/Close
    [media on:SKW_MEDIACONNECTION_EVENT_CLOSE callback:^(NSObject* obj)
     {
     }];
    // !!!: MediaEvent/Error
    [media on:SKW_MEDIACONNECTION_EVENT_ERROR callback:^(NSObject* obj)
     {
     }];
}
- (void)setRemoteView:(SKWMediaStream *)stream
{
    
    remoteStream = stream;
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [_remoteVideoView addSrc:remoteStream track:0];
        
    });
}


@end
