//
//  ViewController.h
//  HostPeerInClass
//
//  Created by Michael on 16/05/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SkyWay/SKWVideo.h>
@interface ViewController : UIViewController
- (IBAction)showPeers:(id)sender;
@property (weak, nonatomic) IBOutlet SKWVideo *remoteVideoView;


@end

