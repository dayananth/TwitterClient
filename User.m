//
//  User.m
//  TwitterClient
//
//  Created by Ramasamy Dayanand on 11/5/15.
//  Copyright © 2015 Dayanand Ramasamy. All rights reserved.
//

#import "User.h"
#import "TwitterClient.h"

@interface User ()

@property (nonatomic, strong) NSDictionary *dictionary;

@end

@implementation User

-(id) initWithDictionary: (NSDictionary *)dictionary{
    
    self = [super init];
    if(self){
        self.dictionary = dictionary;
        self.name = dictionary[@"name"];
        self.profileImageUrl = dictionary[@"profile_image_url"];
        self.screenName = dictionary[@"screen_name"];
        self.tagLine = dictionary[@"description"];
    }
    
    return self;
}

NSString * const kCurrentUserKey = @"kCurrentUserKey";

static User *_currentUser = nil;

+ (User *)currentUser{
    if(_currentUser == nil){
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:kCurrentUserKey];
        if(data != nil){
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            _currentUser = [[User alloc] initWithDictionary:dic];
        }
    }
    return _currentUser;
}


+ (void)setCurrentUser: (User *) user{
    _currentUser = user;
    if(_currentUser != nil){
        NSData *data = [NSJSONSerialization dataWithJSONObject:user.dictionary options:0 error:NULL];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:kCurrentUserKey];
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:kCurrentUserKey];
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void) logout{
    [User setCurrentUser:nil];
    [[TwitterClient sharedInstance].requestSerializer removeAccessToken];
}

@end
