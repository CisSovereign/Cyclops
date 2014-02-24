//
//  ImageViewController.h
//  Boggie Man
//
//  Created by Collin Hartigan on 2/24/14.
//  Copyright (c) 2014 Collin Hartigan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ImageViewController : UIViewController

@property (nonatomic,strong) PFObject *message;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
