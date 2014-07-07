//
//  SheduleViewController.h
//  agendify
//
//  Created by Nick Peretti on 7/7/14.
//  Copyright (c) 2014 Nicholas Peretti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SchoolSchedule.h"

@interface SheduleViewController : UIViewController

@property (nonatomic) SchoolSchedule *schedule;
@property (weak, nonatomic) IBOutlet UIScrollView *sceduleScroll;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
- (IBAction)homeClicked:(id)sender;
- (IBAction)compressView:(id)sender;


@end
