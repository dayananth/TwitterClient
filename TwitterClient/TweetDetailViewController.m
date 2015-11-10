//
//  TweetDetailViewController.m
//  TwitterClient
//
//  Created by Ramasamy Dayanand on 11/8/15.
//  Copyright © 2015 Dayanand Ramasamy. All rights reserved.
//

#import "TweetDetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "TwitterClient.h"

@interface TweetDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeStampLabel;
@property (weak, nonatomic) IBOutlet UILabel *noOfTweetsLabel;
@property (weak, nonatomic) IBOutlet UILabel *noOfLikeLabel;
@end

@implementation TweetDetailViewController

-(id) initWithTweet: (Tweet *) tweet{
    self = [super init];
    if(self){
        self.tweet = tweet;
    }
    return self;
}

- (IBAction)onRetweet:(id)sender {
    [[TwitterClient sharedInstance] retweet:self.tweet.twetID completion:^(Tweet *tweet, NSError *error) {
        if(tweet != nil){
            NSLog(@"successfully retweeted");
        }else{
            NSLog(@"failed to retweet");
        }
    }];
}

- (IBAction)onFavourite:(id)sender {
    [[TwitterClient sharedInstance] favourite:self.tweet.twetID completion:^(Tweet *tweet, NSError *error) {
        if(tweet != nil){
            NSLog(@"successfully favourited");
        }else{
            NSLog(@"failed to favourite");
        }
    }];
}


- (IBAction)onReply:(id)sender {

}

//- (IBAction)onRetweet:(id)sender {
//
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = NO;
    
    NSLog(self.tweet.user.profileImageUrl);
    NSURL *url = [NSURL URLWithString:self.tweet.user.profileImageUrl];
    NSURLRequest *urlReq = [NSURLRequest requestWithURL:url];
    
    [self.profileImage setImageWithURLRequest:urlReq placeholderImage:NULL success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
        [UIView transitionWithView:self.profileImage
                          duration:0.3
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
                            self.profileImage.image = image;
                        }
                        completion:NULL];
    }
                                          failure:NULL];
    self.userNameLabel.text = self.tweet.user.name;
    self.timeStampLabel.text = self.tweet.formattedDate;
    self.tweetLabel.text = self.tweet.text;
    self.noOfLikeLabel.text = [NSString stringWithFormat:@"%ld likes",self.tweet.noOfLikes];
    self.noOfTweetsLabel.text = [NSString stringWithFormat:@"%ld  retweets",self.tweet.noOfReTweets];
//    [self.tweetLabel sizeToFit];
    
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


@end
