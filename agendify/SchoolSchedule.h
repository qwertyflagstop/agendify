//
//  SchoolSchedule.h
//  agendify
//
//  Created by Nick Peretti on 6/25/14.
//  Copyright (c) 2014 Nicholas Peretti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "TFHpple.h"

@interface SchoolSchedule : NSObject

-(id)initWithUsername: (NSString *)userName Password:(NSString *)password;

-(NSString *)classForDay:(int)day Block:(int)block;


@end
