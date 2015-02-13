//
//  HomeViewController.m
//  jatinter
//
//  Created by Jatin Pandey on 2/6/15.
//  Copyright (c) 2015 Jatin Pandey. All rights reserved.
//

#import "HomeViewController.h"
#import "Tweet.h"
#import "TweetViewCellTableViewCell.h"
#import "TwitterClient.h"
#import "ComposeViewController.h"
#import "TweetDetailViewController.h"
#import "UIImageView+AFNetworking.h"

@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *tweets;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(onLogoutButton)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Compose" style:UIBarButtonItemStylePlain target:self action:@selector(onComposeButton)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
    [[TwitterClient sharedInstance] GET:@"1.1/statuses/home_timeline.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *tweets = [Tweet tweetsFromArray:responseObject];
        self.tweets = tweets;
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failed to get tweets");
    }];

    UINib *tweetViewCell = [UINib nibWithNibName:@"TweetViewCellTableViewCell" bundle:nil];
    [self.tableView registerNib:tweetViewCell forCellReuseIdentifier:@"TweetViewCellTableViewCell"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetViewCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetViewCellTableViewCell"];
    cell.tweetLabel.text = @"This is a tweet lemme make it long for auto layout tooos egisdfjo gfdgsfsd gfdg fgdsg df long rgklfgjfdljgjf dlgjfhgs djfklghjkh gjfkdhg jflhsgj fjsdklg jfldkhgjfsg fdgg fdsg";
    cell.nameLabel.text = @"Jatin Pandey";
    Tweet *currentTweet = [self.tweets objectAtIndex:indexPath.row];
    cell.tweetLabel.text = currentTweet.text;
    cell.nameLabel.text = currentTweet.user.name;
    cell.screenNameLabel.text = [NSString stringWithFormat:@"@%@", currentTweet.user.screenName];
    [cell.profileImageView setImageWithURL:[NSURL URLWithString:currentTweet.user.profileImageUrl]];
    NSDateFormatter *dateFormatter=[NSDateFormatter new];
    [dateFormatter setDateFormat:@"DD-MM-YYYY HH:mm:SS"];
    cell.timestampLabel.text = [dateFormatter stringFromDate:currentTweet.tweetedAt];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetDetailViewController *dvc = [[TweetDetailViewController alloc] init];
    dvc.tweet = [self.tweets objectAtIndex:indexPath.row];
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:dvc];
    [self presentViewController:nvc animated:YES completion:nil];
}

- (void) onDoneButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)onComposeButton {
        ComposeViewController *cvc = [[ComposeViewController alloc] init];
        [self presentViewController:cvc animated:YES completion:nil];
}

- (void)onLogoutButton {
//    [[[UIAlertView alloc] initWithTitle:@"Whoops!" message:@"Incomplete clone, my bad" delegate:self cancelButtonTitle:@"FUUUUUU" otherButtonTitles:nil] show];
    [User logout];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) onRefresh {
    [[TwitterClient sharedInstance] GET:@"1.1/statuses/home_timeline.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *tweets = [Tweet tweetsFromArray:responseObject];
        self.tweets = tweets;
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failed to get tweets");
    }];

    [self.refreshControl endRefreshing];
}

@end
