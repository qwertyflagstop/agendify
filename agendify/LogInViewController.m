//
//  DailyViewController.m
//  agendify
//
//  Created by Nick Peretti on 6/25/14.
//  Copyright (c) 2014 Nicholas Peretti. All rights reserved.
//

#import "LogInViewController.h"
#import "SheduleViewController.h"

@interface LogInViewController () {
    SchoolSchedule *sched;
}

@end

@implementation LogInViewController

@synthesize userNameTextField,passWordTextField;


- (void)viewDidLoad
{
    [super viewDidLoad];
   
    
    
}


- (IBAction)logIn:(id)sender {
    sched = [[SchoolSchedule alloc]initWithUsername:@"tonyshu" Password:@"Mini12345!"];
    //sched = [[SchoolSchedule alloc]initWithUsername:userNameTextField.text Password:passWordTextField.text];
    [self performSegueWithIdentifier:@"calendar" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"calendar"]) {
        SheduleViewController *vc = segue.destinationViewController;
        vc.schedule = sched;
    }
}


@end
