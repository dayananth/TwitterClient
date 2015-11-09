//
//  TweetDetailViewController.h
//  TwitterClient
//
//  Created by Ramasamy Dayanand on 11/8/15.
//  Copyright © 2015 Dayanand Ramasamy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@interface TweetDetailViewController : UIViewController
@property (nonatomic, strong) Tweet *tweet;

-(id) initWithTweet: (Tweet *) tweet;

@end
