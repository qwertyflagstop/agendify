//
//  SheduleViewController.h
//  agendify
//
//  Created by Nick Peretti on 7/7/14.
//  Copyright (c) 2014 Nicholas Peretti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SchoolSchedule.h"
#import "NSDate+Helper.h"

@interface SheduleViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic) SchoolSchedule *schedule;
@property (nonatomic) NSMutableArray *schoolDates;
@property (nonatomic) NSMutableArray *schoolDaysOfCycle;
@property (weak, nonatomic) IBOutlet UIScrollView *sceduleScroll;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
- (IBAction)homeClicked:(id)sender;
- (IBAction)compressView:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *topBar;

@property (weak, nonatomic) IBOutlet UIButton *compressionButton;

@end
