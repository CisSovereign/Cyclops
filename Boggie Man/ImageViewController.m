//
//  ImageViewController.m
//  Boggie Man
//
//  Created by Collin Hartigan on 2/24/14.
//  Copyright (c) 2014 Collin Hartigan. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()

@end

@implementation ImageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	PFFile *imageFile = [self.message objectForKey:@"file"];
    NSURL *imageFileURL = [[NSURL alloc] initWithString:imageFile.url];
    NSData *imageData = [NSData dataWithContentsOfURL:imageFileURL];
    self.imageView.image = [UIImage imageWithData:imageData];
    
    NSString *senderName = [self.message objectForKey:@"senderName"];
    NSString *title = [NSString stringWithFormat:@"From %@", senderName];
    self.navigationItem.title = title;
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if ([self respondsToSelector:@selector(timeout)]) {
    [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(timeout) userInfo:nil repeats:NO];
    
    }
    else {
        NSLog(@"Error selector missing");
    }
}

#pragma mark - Helper Method

-(void)timeout {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
