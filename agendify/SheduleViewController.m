//
//  SheduleViewController.m
//  agendify
//
//  Created by Nick Peretti on 7/7/14.
//  Copyright (c) 2014 Nicholas Peretti. All rights reserved.
//

#import "SheduleViewController.h"

@interface SheduleViewController ()

@end

@implementation SheduleViewController

@synthesize schedule,dateLabel,sceduleScroll;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    sceduleScroll.contentSize = CGSizeMake(self.view.frame.size.width*7, self.view.frame.size.height*6);
    sceduleScroll.directionalLockEnabled = YES;
    [sceduleScroll setPagingEnabled:YES];
    
    for (int i = 0; i<7; i++) {
        for (int j = 0; j<6; j++) {
            UIView *card = [[UIView alloc]initWithFrame:CGRectMake(i*self.view.frame.size.width, j*self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
            
            card.backgroundColor = [UIColor colorWithRed:r/10.0 green:g/10.0 blue:b/10.0 alpha:1.0];
            [sceduleScroll addSubview:card];
            NSLog(@"%@",[schedule classForDay:i Block:j]);
        }
    }
    
    
    
    
}




- (IBAction)homeClicked:(id)sender {
}

- (IBAction)compressView:(id)sender {
}
@end
