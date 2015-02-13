//
//  ComposeViewController.m
//  jatinter
//
//  Created by Jatin Pandey on 2/10/15.
//  Copyright (c) 2015 Jatin Pandey. All rights reserved.
//

#import "ComposeViewController.h"
#import "TwitterClient.h"

@interface ComposeViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UITextView *tweetView;
@property (weak, nonatomic) IBOutlet UILabel *tweetLengthLabel;
- (IBAction)onTweetButton:(id)sender;
- (IBAction)onBackButton:(id)sender;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tweetView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textViewDidChange:(UITextView *)textView {
    NSLog(@"Editing field");
    NSString *tweetText = self.tweetView.text;
    NSInteger length = [tweetText length];
    NSInteger remainingLength = 140 - length;
    NSLog(@"Length: %ld", (long)length);
    if (remainingLength < 0) {
        [self.tweetLengthLabel setTextColor:[UIColor redColor]];
    }
    self.tweetLengthLabel.text = [NSString stringWithFormat:@"%ld", remainingLength];
}

- (IBAction)onTweetButton:(id)sender {
    NSDictionary *params = @{@"status": self.tweetView.text};
    [[TwitterClient sharedInstance] POST:@"1.1/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Posted tweet!");
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failed to create tweet");
    }];

}

- (IBAction)onBackButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
