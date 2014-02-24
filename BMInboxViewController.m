//
//  BMInboxViewController.m
//  Boggie Man
//
//  Created by Collin Hartigan on 2/15/14.
//  Copyright (c) 2014 Collin Hartigan. All rights reserved.
//

#import "BMInboxViewController.h"
#import "ImageViewController.h"


@interface BMInboxViewController ()

@end

@implementation BMInboxViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        NSLog(@"Current user %@", currentUser.username);
    }
    else {
        [self performSegueWithIdentifier:@"showLogin" sender:self];
    }
    
   }

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    PFQuery *query= [PFQuery queryWithClassName:@"Messages"];
    [query whereKey:@"recipientIds" equalTo:[[PFUser currentUser] objectId]];
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"Error %@ %@", error, [error userInfo]);
        }
        else {
            self.messages = objects;
            [self.tableView reloadData];
            
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [self.messages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    PFObject *message = [self.messages objectAtIndex:indexPath.row];
    cell.textLabel.text = [message objectForKey:@"senderName"];
    
    NSString *fileType = [message objectForKey:@"fileType"];
    if ([fileType isEqualToString:@"image"]) {
        cell.imageView.image = [UIImage imageNamed:@"icon_image"];
    }
    else {
        cell.imageView.image = [UIImage imageNamed:@"video_image"];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedMessage = [self.messages objectAtIndex:indexPath.row];
    
    NSString *fileType = [self.selectedMessage objectForKey:@"fileType"];
    if ([fileType isEqualToString:@"image"]) {
        [self performSegueWithIdentifier:@"showImage" sender:self];
    }
    else {
        
    }
}


- (IBAction)logout:(id)sender {
    
    [PFUser logOut];
    [self performSegueWithIdentifier:@"showLogin" sender:self];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showLogin"]) {
        [segue.destinationViewController setHidesBottomBarWhenPushed:YES];
    }
    else if ([segue.identifier isEqualToString:@"showImage"]){
        [segue.destinationViewController setHidesBottomBarWhenPushed:YES];
        ImageViewController *imageViewController = (ImageViewController *) segue.destinationViewController;
        imageViewController.message = self.selectedMessage;
    }
}
@end
