//
//  TweetsViewController.m
//  TwitterClient
//
//  Created by Ramasamy Dayanand on 11/6/15.
//  Copyright © 2015 Dayanand Ramasamy. All rights reserved.
//

#import "TweetsViewController.h"
#import "User.h"
#import "TwitterClient.h"
#import "Tweet.h"

@interface TweetsViewController ()

- (IBAction)OnLogout:(id)sender;
@end

@implementation TweetsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[TwitterClient sharedInstance] homeTimeLineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
        for(Tweet *tweet in tweets){
            NSLog(@"tweet text: %@", tweet.text);
        }
    }];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)OnLogout:(id)sender {
    [User logout];
}
@end
