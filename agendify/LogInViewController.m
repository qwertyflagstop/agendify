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
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(recievedLoginNotification:) name:@"logged in" object:nil];
    
    
    
}


- (IBAction)logIn:(id)sender {
    //HNilforoshan
    //Eg842wZz
    //sched = [[SchoolSchedule alloc]initWithUsername:@"tonyshu" Password:@"Mini12345!"];
    sched = [[SchoolSchedule alloc]initWithUsername:userNameTextField.text Password:passWordTextField.text];
    MBProgressHUD *loading = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    loading.labelFont = [UIFont fontWithName:@"Futura" size:14.0];
    loading.labelText = @"logging in";
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"calendar"]) {
        SheduleViewController *vc = segue.destinationViewController;
        vc.schedule = sched;
    }
}
-(void)recievedLoginNotification: (NSNotification *)notification{
    [self performSegueWithIdentifier:@"calendar" sender:self];
}

@end
