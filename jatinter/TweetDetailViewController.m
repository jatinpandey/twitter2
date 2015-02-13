//
//  TweetDetailViewController.m
//  jatinter
//
//  Created by Jatin Pandey on 2/10/15.
//  Copyright (c) 2015 Jatin Pandey. All rights reserved.
//

#import "TweetDetailViewController.h"
#import "Tweet.h"
#import "UIImageView+AFNetworking.h"
#import "TwitterClient.h"

@interface TweetDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
- (IBAction)onReplyButton:(id)sender;
- (IBAction)onRetweetButton:(id)sender;
- (IBAction)onFavoriteButton:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@end

@implementation TweetDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tweetLabel.text = self.tweet.text;
    self.nameLabel.text = self.tweet.user.name;
    self.screenNameLabel.text = [NSString stringWithFormat:@"@%@", self.tweet.user.screenName];
    NSString *picUrl = self.tweet.user.profileImageUrl;
    [self.profileImageView setImageWithURL:[NSURL URLWithString:picUrl]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(onDoneButton)];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Compose" style:UIBarButtonItemStylePlain target:self action:@selector(onComposeButton)];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onReplyButton:(id)sender {
    
}

- (IBAction)onRetweetButton:(id)sender {
    NSLog(@"%@", self.tweet.tweetId);
    [[TwitterClient sharedInstance] retweet:self.tweet.tweetId completion:^(Tweet *tweet, NSError *error) {
        [[[UIAlertView alloc] initWithTitle:@"Retweeted" message:@"Lolol you copied someone" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    }];
}

- (IBAction)onFavoriteButton:(id)sender {
    
}

- (void)onDoneButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
