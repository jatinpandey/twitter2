//
//  TweetViewCellTableViewCell.h
//  jatinter
//
//  Created by Jatin Pandey on 2/10/15.
//  Copyright (c) 2015 Jatin Pandey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetViewCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
- (IBAction)onReplyButton:(id)sender;
- (IBAction)onRetweetButton:(id)sender;
- (IBAction)onFavoriteButton:(id)sender;

@end
