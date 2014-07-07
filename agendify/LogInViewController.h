//
//  DailyViewController.h
//  agendify
//
//  Created by Nick Peretti on 6/25/14.
//  Copyright (c) 2014 Nicholas Peretti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SchoolSchedule.h"

@interface LogInViewController : UIViewController

@property (nonatomic,strong) SchoolSchedule *userSchedule;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;

- (IBAction)logIn:(id)sender;

@end
