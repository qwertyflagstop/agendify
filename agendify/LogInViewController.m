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
    NSMutableArray *dates;
    NSMutableArray *schoolDay;
}

@end

@implementation LogInViewController

@synthesize userNameTextField,passWordTextField;


- (void)viewDidLoad
{
    [super viewDidLoad];
    dates = [[NSMutableArray alloc]init];
    schoolDay = [[NSMutableArray alloc]init];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(recievedLoginNotification:) name:@"logged in" object:nil];
    
    NSURL *url = [NSURL URLWithString:@"http://alnoorgames.com/agendify/datesdata.txt"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *string = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSScanner *scanner = [NSScanner scannerWithString:string];
        while (![scanner isAtEnd]) {
            NSString *GOT;
            [scanner scanUpToString:@"\n" intoString:&GOT];
            int dayOfCycle = [[GOT substringFromIndex:GOT.length-2]intValue];
            NSString *dateString = [GOT substringToIndex:GOT.length-2];
            NSDate *date = [NSDate dateFromString:dateString withFormat:@"MM/dd/yyyy"];
            [dates addObject:date];
            [schoolDay addObject:[NSNumber numberWithInt:dayOfCycle]];
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"FAIL");
    }];
    [operation start];
    
    
    
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
        vc.schoolDaysOfCycle = schoolDay;
        vc.schoolDates = dates;
        vc.schedule = sched;
    }
}
-(void)recievedLoginNotification: (NSNotification *)notification{
    if (dates.count >=1) {
        
        [self performSegueWithIdentifier:@"calendar" sender:self];

    } else {
        UIAlertView *lert  = [[UIAlertView alloc]initWithTitle:@"OOps 0.o" message:@"Error Reading dates please try to log in again" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [lert show];
    }
}

@end
