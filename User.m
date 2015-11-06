//
//  User.m
//  TwitterClient
//
//  Created by Ramasamy Dayanand on 11/5/15.
//  Copyright © 2015 Dayanand Ramasamy. All rights reserved.
//

#import "User.h"

@implementation User

-(id) initWithDictionary: (NSDictionary *)dictionary{
    
    self = [super init];
    if(self){
        self.name = dictionary[@"name"];
        self.profileImageUrl = dictionary[@"profile_image_url"];
        self.screenName = dictionary[@"screen_name"];
        self.tagLine = dictionary[@"description"];
    }
    
    return self;
}

@end
