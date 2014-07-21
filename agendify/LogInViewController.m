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
    MBProgressHUD *loading;
}

@end

@implementation LogInViewController

@synthesize userNameTextField,passWordTextField,loginButton;


- (void)viewDidLoad
{
    [super viewDidLoad];
    dates = [[NSMutableArray alloc]init];
    schoolDay = [[NSMutableArray alloc]init];
    loginButton.layer.cornerRadius = 8.0;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(recievedLoginNotification:) name:@"logged in" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(errorLogingin:) name:@"errorLogin" object:nil];
    passWordTextField.delegate = self;
    NSURL *url = [NSURL URLWithString:@"http://alnoorgames.com/agendify/datesdata.txt"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
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
            
            //date1 before date2 = nsorderderedascending
            if ([[NSDate date] compare:date]==NSOrderedAscending||[[NSDate date] compare:date]==NSOrderedSame) {
                [dates addObject:date];
                [schoolDay addObject:[NSNumber numberWithInt:dayOfCycle]];
            } else {
                NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
                NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
                NSInteger day = [components day];
                NSInteger day2 = [components2 day];
                if (day==day2) {
                    [dates addObject:date];
                    [schoolDay addObject:[NSNumber numberWithInt:dayOfCycle]];
                }
                
            }
            
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"FAIL");
    }];
    [operation start];
    
    
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self logIn:textField];
    return YES;
}


- (IBAction)logIn:(id)sender {

    sched = [[SchoolSchedule alloc]initWithUsername:userNameTextField.text Password:passWordTextField.text];
    loading = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    loading.labelFont = [UIFont fontWithName:@"Futura" size:14.0];
    loading.labelText = @"logging in";
    loading.hidden = NO;
    
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
-(void)errorLogingin: (NSNotification *)notification{
    UIAlertView *lert  = [[UIAlertView alloc]initWithTitle:@"OOps 0.o" message:@"Error. Please makes sure username and password are correct" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [lert show];
    
    [loading hide:YES];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return  UIStatusBarStyleLightContent;
}

@end
