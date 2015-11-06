//
//  TwitterClient.m
//  TwitterClient
//
//  Created by Ramasamy Dayanand on 11/4/15.
//  Copyright © 2015 Dayanand Ramasamy. All rights reserved.
//

#import "TwitterClient.h"

NSString * const kTwitterConsumerKey = @"cHqTCRFyQfnlFLrBgEPWMfiKI";
NSString * const KTwitterConsumerSecret = @"23dAKkHxGtIH9qwplMJIZZ4pFMZ4azDPwAcZn9WzjB7vK6OsXK";
NSString * const kTwitterBaseUrl = @"https://api.twitter.com";

@interface TwitterClient ()

@property (nonatomic, strong) void (^loginCompletion) (User *user, NSError *error);

@end

@implementation TwitterClient

+ (TwitterClient *)sharedInstance {
    static TwitterClient *instance  = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(instance == nil){
            instance = [[TwitterClient alloc] initWithBaseURL:[NSURL URLWithString:kTwitterBaseUrl] consumerKey:kTwitterConsumerKey consumerSecret:KTwitterConsumerSecret];
        }
    });

    return instance;
}

-(void)loginWithCompletion:(void (^) (User *user, NSError *error))completion {
    self.loginCompletion = completion;
    
    [self.requestSerializer removeAccessToken];
    [self fetchRequestTokenWithPath:@"oauth/request_token" method:@"GET" callbackURL:[NSURL URLWithString:@"cptwitterdemo://oauth"] scope:nil success:^(BDBOAuth1Credential *requestToken) {
        NSURL *authURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.twitter.com/oauth/authorize?oauth_token=%@", requestToken.token]];
        [[UIApplication sharedApplication] openURL:authURL];
        NSLog(@"Got the request token");
        
    }failure:^(NSError *error) {
        NSLog(@"Failed to get the request token");
        self.loginCompletion(nil, error);
    }];
}

-(void) openURL:(NSURL* )url{
    
    [self fetchAccessTokenWithPath:@"oauth/access_token" method:@"POST" requestToken:[BDBOAuth1Credential credentialWithQueryString:url.query ] success:^(BDBOAuth1Credential *accessToken) {
        [self.requestSerializer saveAccessToken:accessToken];
        
        [self GET:@"1.1/account/verify_credentials.json" parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            
            User *user = [[User alloc] initWithDictionary:responseObject];
            NSLog(@"Current user:%@", user.name);
            
            self.loginCompletion(user, nil);
            
        } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
            NSLog(@"Failed getting the current user");
            self.loginCompletion(nil, error);
        }];
        
        
//        [self GET:@"1.1/statuses/home_timeline.json" parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//            NSArray *tweets = [Tweet tweetsWithArray:responseObject];
//            
//        } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
//            NSLog(@"Failed getting the tweets");
//        }];
        
        
        NSLog(@"Got the access token");
    } failure:^(NSError *error) {
        NSLog(@"failed to get the token");
        self.loginCompletion(nil, error);
    }];
    
}

@end
