//
//  Tweet.m
//  TwitterClient
//
//  Created by Ramasamy Dayanand on 11/5/15.
//  Copyright © 2015 Dayanand Ramasamy. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

-(id) initWithDictionary: (NSDictionary *)dictionary{
    
    self = [self init];
    if(self){
        self.twetID = dictionary[@"id"];
        self.text = dictionary[@"text"];
        self.user = [[User  alloc] initWithDictionary:dictionary[@"user"]];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"EEE MMM d HH:mm:ss Z y";
        self.createdAt = [dateFormatter dateFromString:dictionary[@"created_at"]];
        dateFormatter.dateFormat = @"yyyy-MM-dd hh:mm a";
        self.formattedDate = [dateFormatter stringFromDate:self.createdAt];
//        NSDate *date1 = [NSDate date];
//        NSLog(@"%@f is the time difference ", [date1 timeIntervalSinceDate:self.createdAt]);
    }
    
    return self;
}

+(NSArray *) tweetsWithArray: (NSArray *) tweetsArray{
    NSMutableArray *tweets = [NSMutableArray array];
    
    for(NSDictionary *dictionary in tweetsArray){
        [tweets addObject:[[Tweet alloc] initWithDictionary:dictionary]];
    }
    
    return tweets;
}

@end
