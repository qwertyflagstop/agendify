//
//  SchoolSchedule.m
//  agendify
//
//  Created by Nick Peretti on 6/25/14.
//  Copyright (c) 2014 Nicholas Peretti. All rights reserved.
//

#import "SchoolSchedule.h"

@implementation SchoolSchedule {
    NSMutableArray *days;
}

/*
 -(id)initWithUsername:(NSString *)userName Password:(NSString *)password{
 self = [super init];
 if (self) {
 //Load Up the schedule
 NSData *dat = [[NSUserDefaults standardUserDefaults]objectForKey:@"tonyshuMini12345!"];
 NSArray *scedule = [NSKeyedUnarchiver unarchiveObjectWithData:dat];
 days = [NSMutableArray arrayWithArray:scedule];
 [self performSelector:@selector(sendDataFound) withObject:self afterDelay:1.0];
 NSString *lastUser = [[NSUserDefaults standardUserDefaults]objectForKey:@"user"];
 
 
 
 
 NSString *userKey = [NSString stringWithFormat:@"sced"];
 NSString *lastUser = [[NSUserDefaults standardUserDefaults]objectForKey:@"user"];
 NSData *dat = [[NSUserDefaults standardUserDefaults]objectForKey:userKey];
 NSArray *scedule = [NSKeyedUnarchiver unarchiveObjectWithData:dat];
 days = [NSMutableArray arrayWithArray:scedule];
 
 //Lets Load Up the schedule!
 
 if (scedule[0][0]==NULL || ![lastUser isEqualToString:userName]) {
 days = [[NSMutableArray alloc]init];
 for (int i =0; i<7; i++) {
 [days addObject:[[NSMutableArray alloc]init]];
 for (int j = 0; j<6; j++) {
 [days[i] setObject:@"FREE" atIndex:j];
 }
 }
 NSString *formattedString = [NSString stringWithFormat:@"http://alnoorgames.com/agendify/?username=%@&password=%@",userName,password];
 NSURL *url = [NSURL URLWithString:formattedString];
 NSURLRequest *request = [NSURLRequest requestWithURL:url];
 AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
 [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
 
 TFHpple *parser = [TFHpple hppleWithHTMLData:responseObject];
 NSLog(@"%@",[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding]);
 NSArray *elements = [parser searchWithXPathQuery:@"//div[contains(@id,'quickLookup')]/table"];
 TFHppleElement *table = elements[0];
 for (int i = 7; i<table.children.count-3; i+=2) {
 TFHppleElement *scedule = table.children[i];  //CHANGE TO I later;
 TFHppleElement *dayo = scedule.children[1];
 TFHppleElement *infon = scedule.children[14];
 NSString *classTimes = dayo.text;
 NSString *className = infon.text;
 NSLog(@"%@",className);
 if ([className rangeOfString:@"Advisory"].location==NSNotFound) {
 while ([classTimes rangeOfString:@"("].location!=NSNotFound){
 int parChar = (int)([classTimes rangeOfString:@"("].location);
 NSString *chunk = [classTimes substringToIndex:parChar];
 NSMutableArray *blocks = [[NSMutableArray alloc]init];
 for (int i = 0; i<chunk.length; i++) {
 NSString *ch = [NSString stringWithFormat:@"%c",[chunk characterAtIndex:i]];
 if ([self isInteger:ch]) {
 NSNumber *theInteger  = [NSNumber numberWithInt:[ch intValue]];
 [blocks addObject:theInteger];
 } else if([ch isEqualToString:@"-"]){
 int start =  [[NSString stringWithFormat:@"%c",[chunk characterAtIndex:i-1]]intValue];
 int end = [[NSString stringWithFormat:@"%c",[chunk characterAtIndex:i+1]]intValue];
 for (int j = start; j<=end; j++) {
 [blocks addObject:[NSNumber numberWithInt:j]];
 }
 }
 }
 NSMutableArray *array2 = [[NSMutableArray alloc]init];
 for (id obj in blocks)
 {
 if (![array2 containsObject:obj])
 {
 [array2 addObject: obj];
 }
 }
 //blocks now has the blocks
 blocks = array2;
 
 NSMutableArray *classDays = [[NSMutableArray alloc]init];
 NSString *new = [classTimes substringFromIndex:parChar+1];
 int parChar2 = (int)([new rangeOfString:@")"].location);
 NSString *chunk2 = [new substringToIndex:parChar2];
 for (int i = 0; i<chunk2.length; i++) {
 NSString *ch = [NSString stringWithFormat:@"%c",[chunk2 characterAtIndex:i]];
 if ([self isInteger:ch]) {
 NSNumber *theInteger  = [NSNumber numberWithInt:[ch intValue]];
 [classDays addObject:theInteger];
 } else if([ch isEqualToString:@"-"]){
 int start =  [[NSString stringWithFormat:@"%c",[chunk2 characterAtIndex:i-1]]intValue];
 int end = [[NSString stringWithFormat:@"%c",[chunk2 characterAtIndex:i+1]]intValue];
 for (int j = start; j<=end; j++) {
 [classDays addObject:[NSNumber numberWithInt:j]];
 }
 }
 }
 NSMutableArray *array3 = [[NSMutableArray alloc]init];
 for (id obj in classDays)
 {
 if (![array3 containsObject:obj])
 {
 [array3 addObject: obj];
 }
 }
 classDays=array3;
 
 for (NSNumber *day in classDays) {
 for (NSNumber *block in blocks) {
 days[day.intValue-1][block.intValue-1] = className;
 }
 }
 
 
 parChar2 = (int)[classTimes rangeOfString:@")"].location;
 classTimes = [classTimes substringFromIndex:parChar2+1];
 
 if (classTimes.length==0) break;
 
 while (![self isInteger:[NSString stringWithFormat:@"%c",[classTimes characterAtIndex:0]]]) {
 classTimes = [classTimes substringFromIndex:1];
 }
 }
 }
 }
 NSLog(@"loaded Scedule");
 for (int i = 0; i<7; i++) {
 for (int j =0; j<6; j++) {
 NSLog(@"day %i block %i is %@",i,j,days[i][j]);
 }
 }
 NSArray *scedData = [days copy];
 [[NSUserDefaults standardUserDefaults]setObject:userName forKey:@"user"];
 [[NSUserDefaults standardUserDefaults]setObject:[NSKeyedArchiver archivedDataWithRootObject:scedData] forKey:@"sced"];
 [[NSUserDefaults standardUserDefaults]synchronize];
 
 [[NSNotificationCenter defaultCenter]postNotification:[NSNotification notificationWithName:@"logged in" object:self]];
 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
 //handleFailure
 NSLog(@"FAILURE");
 }];
 [operation start];
 
 } else{
 NSLog(@"HERE");
 [[NSNotificationCenter defaultCenter]postNotification:[NSNotification notificationWithName:@"logged in" object:self]];
 }
 
 
 }
 return self;
 }
 */ //this is the original working log in

-(id)initWithUsername:(NSString *)userName Password:(NSString *)password{
    
    self = [super init];
    
    NSString *userKey = [NSString stringWithFormat:@"sced"];
    NSString *lastUser = [[NSUserDefaults standardUserDefaults]objectForKey:@"user"];
    NSData *dat = [[NSUserDefaults standardUserDefaults]objectForKey:userKey];
    NSArray *scedule = [NSKeyedUnarchiver unarchiveObjectWithData:dat];
    days = [NSMutableArray arrayWithArray:scedule];

    
    
    //Lets Load Up the schedule!
    if (![lastUser isEqualToString:userName]) {
        days = [[NSMutableArray alloc]init];
        for (int i =0; i<7; i++) {
            [days addObject:[[NSMutableArray alloc]init]];
            for (int j = 0; j<6; j++) {
                [days[i] setObject:@"FREE" atIndex:j];
            }
        }
        NSString *formattedString = [NSString stringWithFormat:@"http://alnoorgames.com/agendify/?username=%@&password=%@",userName,password];
        NSURL *url = [NSURL URLWithString:formattedString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            TFHpple *parser = [TFHpple hppleWithHTMLData:responseObject];
            
            NSArray *elements = [parser searchWithXPathQuery:@"//table[@class = \"grid linkDescList\"]"];
            if (elements.count == 0) {
                [[NSNotificationCenter defaultCenter]postNotificationName:@"errorLogin" object:nil];
                
            } else {
                TFHppleElement *table = elements[0];
                for (int i = 3; i<table.children.count; i+=2) {
                    TFHppleElement *item = table.children[i];
                    NSString *classTimes = [(TFHppleElement *)item.children[1] text];
                    NSString *className = [(TFHppleElement *)item.children[5] text];
                    
                    
                    if ([className rangeOfString:@"Advisory"].location==NSNotFound) {
                        while ([classTimes rangeOfString:@"("].location!=NSNotFound){
                            int parChar = (int)([classTimes rangeOfString:@"("].location);
                            NSString *chunk = [classTimes substringToIndex:parChar];
                            NSMutableArray *blocks = [[NSMutableArray alloc]init];
                            for (int i = 0; i<chunk.length; i++) {
                                NSString *ch = [NSString stringWithFormat:@"%c",[chunk characterAtIndex:i]];
                                if ([self isInteger:ch]) {
                                    NSNumber *theInteger  = [NSNumber numberWithInt:[ch intValue]];
                                    [blocks addObject:theInteger];
                                } else if([ch isEqualToString:@"-"]){
                                    int start =  [[NSString stringWithFormat:@"%c",[chunk characterAtIndex:i-1]]intValue];
                                    int end = [[NSString stringWithFormat:@"%c",[chunk characterAtIndex:i+1]]intValue];
                                    for (int j = start; j<=end; j++) {
                                        [blocks addObject:[NSNumber numberWithInt:j]];
                                    }
                                }
                            }
                            NSMutableArray *array2 = [[NSMutableArray alloc]init];
                            for (id obj in blocks)
                            {
                                if (![array2 containsObject:obj])
                                {
                                    [array2 addObject: obj];
                                }
                            }
                            //blocks now has the blocks
                            blocks = array2;
                            
                            NSMutableArray *classDays = [[NSMutableArray alloc]init];
                            NSString *new = [classTimes substringFromIndex:parChar+1];
                            int parChar2 = (int)([new rangeOfString:@")"].location);
                            NSString *chunk2 = [new substringToIndex:parChar2];
                            for (int i = 0; i<chunk2.length; i++) {
                                NSString *ch = [NSString stringWithFormat:@"%c",[chunk2 characterAtIndex:i]];
                                if ([self isInteger:ch]) {
                                    NSNumber *theInteger  = [NSNumber numberWithInt:[ch intValue]];
                                    [classDays addObject:theInteger];
                                } else if([ch isEqualToString:@"-"]){
                                    int start =  [[NSString stringWithFormat:@"%c",[chunk2 characterAtIndex:i-1]]intValue];
                                    int end = [[NSString stringWithFormat:@"%c",[chunk2 characterAtIndex:i+1]]intValue];
                                    for (int j = start; j<=end; j++) {
                                        [classDays addObject:[NSNumber numberWithInt:j]];
                                    }
                                }
                            }
                            NSMutableArray *array3 = [[NSMutableArray alloc]init];
                            for (id obj in classDays)
                            {
                                if (![array3 containsObject:obj])
                                {
                                    [array3 addObject: obj];
                                }
                            }
                            classDays=array3;
                            
                            for (NSNumber *day in classDays) {
                                for (NSNumber *block in blocks) {
                                    days[day.intValue-1][block.intValue-1] = className;
                                }
                            }
                            
                            
                            parChar2 = (int)[classTimes rangeOfString:@")"].location;
                            classTimes = [classTimes substringFromIndex:parChar2+1];
                            
                            if (classTimes.length==0) break;
                            
                            while (![self isInteger:[NSString stringWithFormat:@"%c",[classTimes characterAtIndex:0]]]) {
                                classTimes = [classTimes substringFromIndex:1];
                            }
                        }
                    }
                    
                }
                NSLog(@"loaded Scedule");
                for (int i = 0; i<7; i++) {
                    for (int j =0; j<6; j++) {
                        NSLog(@"day %i block %i is %@",i,j,days[i][j]);
                    }
                }
                NSArray *scedData = [days copy];
                [[NSUserDefaults standardUserDefaults]setObject:userName forKey:@"user"];
                [[NSUserDefaults standardUserDefaults]setObject:[NSKeyedArchiver archivedDataWithRootObject:scedData] forKey:@"sced"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                [[NSNotificationCenter defaultCenter]postNotification:[NSNotification notificationWithName:@"logged in" object:self]];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //handleFailure
            NSLog(@"FAILURE");
        }];
        [operation start];
        
    } else{
        NSLog(@"HERE");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter]postNotification:[NSNotification notificationWithName:@"logged in" object:self]];
        });
    }
    return self;
}

-(NSString *)classForDay:(int)day Block:(int)block{
    return days[day][block];
}

- (BOOL)isInteger:(NSString *)toCheck {
    if([toCheck intValue] != 0) {
        return true;
    } else if([toCheck isEqualToString:@"0"]) {
        return true;
    } else {
        return false;
    }
}

-(void)sendDataFound{
    [[NSNotificationCenter defaultCenter]postNotification:[NSNotification notificationWithName:@"logged in" object:self]];
}

@end
