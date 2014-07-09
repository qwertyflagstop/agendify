//
//  SheduleViewController.m
//  agendify
//
//  Created by Nick Peretti on 7/7/14.
//  Copyright (c) 2014 Nicholas Peretti. All rights reserved.
//

#import "SheduleViewController.h"

@interface SheduleViewController () {
    NSMutableArray *cards;
    BOOL isCompressed;
    int cardHeight;
    NSArray *blockTimes;
}

@end

@implementation SheduleViewController

@synthesize schedule,dateLabel,sceduleScroll,schoolDates,schoolDaysOfCycle,compressionButton;


- (void)viewDidLoad
{
    [super viewDidLoad];
    isCompressed = false;
    sceduleScroll.delegate = self;
    sceduleScroll.contentSize = CGSizeMake(sceduleScroll.frame.size.width*schoolDates.count, sceduleScroll.frame.size.height*6);
    sceduleScroll.directionalLockEnabled = YES;
    [sceduleScroll setPagingEnabled:YES];
    [sceduleScroll setShowsHorizontalScrollIndicator:NO];
    [sceduleScroll setShowsVerticalScrollIndicator:NO];
    [sceduleScroll setBounces:NO];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)];
    [sceduleScroll addGestureRecognizer:singleTap];
    
    blockTimes = [NSArray arrayWithObjects:@"7:30 - 8:35",@"8:35 - 9:50",@"10:00 - 11:00",@"11:00 - 12:35",@"12:35 - 1:35",@"1:35 - 2:30", nil];
    
    cards = [[NSMutableArray alloc]init];
    
    NSMutableArray *colors = [[NSMutableArray alloc]init];
    UIColor *green = [UIColor colorWithRed:0.115 green:0.674 blue:0.077 alpha:1.000];
    UIColor *blue = [UIColor colorWithRed:0.154 green:0.501 blue:0.674 alpha:1.000];
    UIColor *yellow = [UIColor colorWithRed:0.896 green:0.655 blue:0.123 alpha:1.000];
    UIColor *red = [UIColor colorWithRed:1.000 green:0.218 blue:0.242 alpha:1.000];
    UIColor *orange = [UIColor colorWithRed:0.795 green:0.329 blue:0.065 alpha:1.000];
    UIColor *purple = [UIColor colorWithRed:0.502 green:0.000 blue:1.000 alpha:1.000];
    UIColor *tan = [UIColor colorWithWhite:0.298 alpha:1.000];
    
    
    colors[0] = [NSArray arrayWithObjects:tan,orange,yellow,green,red,blue,nil];
    colors[1]= [NSArray arrayWithObjects:blue,yellow,orange,tan,red,purple,nil];
    colors[2] = [NSArray arrayWithObjects:yellow,green,orange,tan,purple,blue,nil];
    colors[3] = [NSArray arrayWithObjects:orange,tan,yellow,green,red,blue,nil];
    colors[4] = [NSArray arrayWithObjects:tan,red,orange,yellow,purple,blue, nil];
    colors[5] = [NSArray arrayWithObjects:blue,purple,orange,green,tan,red, nil];
    colors[6] = [NSArray arrayWithObjects:orange,blue,yellow,green,tan,purple,nil];
    
    NSDate *dayte = schoolDates[0];
    NSString *datText = [NSString stringWithFormat:@"%@ %@",[dayte stringDayOfWeek],[dayte stringWithDateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterNoStyle]];
    dateLabel.text =  datText;
    
    
    for (int i = 0; i<schoolDates.count; i++) {
        for (int j = 0; j<6; j++) {
            UIView *card = [[UIView alloc]initWithFrame:CGRectMake(i*sceduleScroll.frame.size.width, j*sceduleScroll.frame.size.height, sceduleScroll.frame.size.width, sceduleScroll.frame.size.height)];
            
            NSLog(@"%f",card.frame.origin.x);
            int dayofCycle = [(NSNumber *)schoolDaysOfCycle[i] intValue]-1;
            card.backgroundColor = colors[dayofCycle][j];
            int height = 90;
            UILabel *classLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, card.frame.size.height*0.4-(height*0.4), card.frame.size.width, height)];
            [classLabel setFont:[UIFont fontWithName:@"Futura" size:32.0]];
            [classLabel setNumberOfLines:0];
            [classLabel setTextColor:[UIColor whiteColor]];
            [classLabel setLineBreakMode:NSLineBreakByWordWrapping];
            [classLabel setText:[schedule classForDay:dayofCycle Block:j]];
            [classLabel setTextAlignment:NSTextAlignmentCenter];
            [card addSubview:classLabel];
            UILabel *timelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, classLabel.frame.origin.y+classLabel.frame.size.height-15, 320, 50)];
            timelabel.font = [UIFont fontWithName:@"Futura" size:22];
            timelabel.textColor = [UIColor whiteColor];
            timelabel.textAlignment = NSTextAlignmentCenter;
            timelabel.text = blockTimes[j];
            [card addSubview:timelabel];
            [cards addObject:card];
            [sceduleScroll addSubview:card];
            
        }
    }
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int page = floor((sceduleScroll.contentOffset.x+sceduleScroll.frame.size.width*0.5)/sceduleScroll.frame.size.width);
    dateLabel.alpha =  1-fabs((page*sceduleScroll.frame.size.width)-sceduleScroll.contentOffset.x)/(sceduleScroll.frame.size.width*0.5);
    NSDate *dayte = schoolDates[page];
    NSString *datText = [NSString stringWithFormat:@"%@ %@",[dayte stringDayOfWeek],[dayte stringWithDateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterNoStyle]];
    dateLabel.text =  datText;
    
}



- (IBAction)homeClicked:(id)sender {
    [sceduleScroll scrollRectToVisible:CGRectMake(0, 0, sceduleScroll.frame.size.width, sceduleScroll.frame.size.height) animated:YES];
}

- (IBAction)compressView:(id)sender {
    if (isCompressed) {
        //uncompress
        [UIView animateWithDuration:1.0 animations:^{
            compressionButton.transform = CGAffineTransformMakeRotation(0);
            
        }];
        
        for (UIView *card in cards) {
            [UIView animateWithDuration:1.3 animations:^{
                int i = 0;
                [card setFrame:CGRectMake(card.frame.origin.x, card.frame.origin.y*6.0, card.frame.size.width, card.frame.size.height*6.0)];
                for (UIView *sub in card.subviews) {
                    if (i==0) {
                        int height = 90;
                        sub.frame = CGRectMake(0, card.frame.size.height*0.4-(height*0.4), card.frame.size.width, height);
                    }
                    i++;
                }
            }];
        }
        
        sceduleScroll.contentSize = CGSizeMake(sceduleScroll.frame.size.width*schoolDates.count, sceduleScroll.frame.size.height*6);
        
        isCompressed = false;
        
    } else {
        [UIView animateWithDuration:1.0 animations:^{
            compressionButton.transform = CGAffineTransformMakeRotation(M_PI/2);
            
        }];
        
        //compress
        [UIView animateWithDuration:1.0 animations:^{
            [sceduleScroll setContentOffset:CGPointMake(sceduleScroll.contentOffset.x, 0)];
            
        } completion:^(BOOL finished) {
            
        }];
        for (UIView *card in cards) {
            [UIView animateWithDuration:1.4 animations:^{
                int i = 0;
                for (UIView *sub in card.subviews) {
                    if (i==0) {
                        sub.frame = CGRectMake(0, 0, card.frame.size.width, card.frame.size.height/6.0);
                        cardHeight = card.frame.size.height/6.0;
                    }
                    i++;
                }
                [card setFrame:CGRectMake(card.frame.origin.x, card.frame.origin.y/6.0, card.frame.size.width, card.frame.size.height/6.0)];
            }];
        }
        sceduleScroll.contentSize = CGSizeMake(sceduleScroll.frame.size.width*schoolDates.count, sceduleScroll.frame.size.height);
        
        isCompressed = YES;
    }
}

- (void)singleTapGestureCaptured:(UITapGestureRecognizer *)gesture
{
    if (isCompressed) {
      
        
        CGPoint touchPoint = [gesture locationInView:sceduleScroll];
        int block = floor(touchPoint.y/cardHeight);
        int pagesoff = floor(sceduleScroll.contentOffset.x/sceduleScroll.frame.size.width);
        
        UIView *card = cards[pagesoff*6+block];
        UILabel *title = card.subviews[0];
        NSString *className = title.text;
        if (block<6) {
            [UIView animateWithDuration:0.15 animations:^{
                title.alpha = 0.0;
            } completion:^(BOOL finished) {
                title.text = blockTimes[block];
                [UIView animateWithDuration:0.15 animations:^{
                    title.alpha = 1.0;
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.2 delay:1.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        title.alpha = 0.0;
                    } completion:^(BOOL finished) {
                        title.text = className;
                        [UIView animateWithDuration:0.2 animations:^{
                            title.alpha = 1.0;
                        }];
                        
                    }];
                }];
            }];
        }
    }
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return  UIStatusBarStyleLightContent;
}
@end
