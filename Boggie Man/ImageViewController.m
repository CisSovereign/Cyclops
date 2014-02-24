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



@end
