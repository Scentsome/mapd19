//
//  PeersViewController.h
//  HostPeerInClass
//
//  Created by Michael on 16/05/2017.
//  Copyright © 2017 Zencher. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PeersViewController : UITableViewController
@property void (^didSelectPeer)(NSString * anotherPeerID);
@property NSArray * peers;
@end
