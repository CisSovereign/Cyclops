//
//  BMInboxViewController.h
//  Boggie Man
//
//  Created by Collin Hartigan on 2/15/14.
//  Copyright (c) 2014 Collin Hartigan. All rights reserved.
//

#import <Parse/Parse.h>
#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface BMInboxViewController : UITableViewController
@property(nonatomic, strong) NSArray *messages;
@property(nonatomic, strong) PFObject *selectedMessage;
@property(nonatomic, strong) MPMoviePlayerController *moviePlayer;


- (IBAction)logout:(id)sender;



@end
