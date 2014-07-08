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
    [sceduleScroll setShowsHorizontalScrollIndicator:NO];
    [sceduleScroll setShowsVerticalScrollIndicator:NO];
    [sceduleScroll setBounces:NO];
    
    NSMutableArray *colors = [[NSMutableArray alloc]init];
    UIColor *green = [UIColor colorWithRed:0.200 green:0.674 blue:0.220 alpha:1.000];
    UIColor *blue = [UIColor colorWithRed:0.154 green:0.501 blue:0.674 alpha:1.000];
    UIColor *yellow = [UIColor colorWithRed:0.896 green:0.770 blue:0.232 alpha:1.000];
    UIColor *red = [UIColor colorWithRed:1.000 green:0.218 blue:0.242 alpha:1.000];
    UIColor *orange = [UIColor colorWithRed:0.795 green:0.329 blue:0.065 alpha:1.000];
    UIColor *purple = [UIColor colorWithRed:0.502 green:0.000 blue:1.000 alpha:1.000];
    UIColor *tan = [UIColor colorWithRed:1.000 green:0.725 blue:0.366 alpha:1.000];
    
    
    colors[0] = [NSArray arrayWithObjects:tan,orange,yellow,green,red,blue,nil];
    colors[1]= [NSArray arrayWithObjects:blue,yellow,orange,tan,red,purple,nil];
    colors[2] = [NSArray arrayWithObjects:yellow,green,orange,tan,purple,blue,nil];
    colors[3] = [NSArray arrayWithObjects:orange,tan,yellow,green,red,blue,nil];
    colors[4] = [NSArray arrayWithObjects:tan,red,orange,yellow,purple,blue, nil];
    colors[5] = [NSArray arrayWithObjects:blue,purple,orange,green,tan,red, nil];
    colors[6] = [NSArray arrayWithObjects:orange,blue,yellow,green,tan,purple,nil];
    
    
    
    for (int i = 0; i<7; i++) {
        for (int j = 0; j<6; j++) {
            UIView *card = [[UIView alloc]initWithFrame:CGRectMake(i*self.view.frame.size.width, j*self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
            card.backgroundColor = colors[i][j];
            int height = 200;
            UILabel *classLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, card.frame.size.height*0.5-(height*0.5), 320, height)];
            [classLabel setFont:[UIFont fontWithName:@"Futura" size:32.0]];
            [classLabel setNumberOfLines:0];
            [classLabel setTextColor:[UIColor whiteColor]];
            [classLabel setLineBreakMode:NSLineBreakByWordWrapping];
            [classLabel setText:[schedule classForDay:i Block:j]];
            [classLabel setTextAlignment:NSTextAlignmentCenter];
            [card addSubview:classLabel];
            [sceduleScroll addSubview:card];
        
        }
    }
    
}




- (IBAction)homeClicked:(id)sender {
}

- (IBAction)compressView:(id)sender {
}
@end
