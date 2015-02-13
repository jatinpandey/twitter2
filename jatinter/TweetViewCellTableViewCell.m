//
//  TweetViewCellTableViewCell.m
//  jatinter
//
//  Created by Jatin Pandey on 2/10/15.
//  Copyright (c) 2015 Jatin Pandey. All rights reserved.
//

#import "TweetViewCellTableViewCell.h"
#import "TwitterClient.h"

@implementation TweetViewCellTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)onReplyButton:(id)sender {
    
}

- (IBAction)onRetweetButton:(id)sender {
}

- (IBAction)onFavoriteButton:(id)sender {
    
}

- (void) favoriteWithId:(id)tweetId {
    NSDictionary *params = @{@"id": tweetId};
    [[TwitterClient sharedInstance] POST:@"1.1/favorites/create.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        ;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ;
    }];

}

@end
