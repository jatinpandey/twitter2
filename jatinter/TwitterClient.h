//
//  TwitterClient.h
//  jatinter
//
//  Created by Jatin Pandey on 2/7/15.
//  Copyright (c) 2015 Jatin Pandey. All rights reserved.
//

#import "BDBOAuth1RequestOperationManager.h"
#import "User.h"
#import "Tweet.h"

@interface TwitterClient : BDBOAuth1RequestOperationManager

+ (TwitterClient *)sharedInstance;

- (void)loginWithCompletion:(void (^)(User *user, NSError *error))completion;

- (void)openUrl:(NSURL *)url;

- (void)getTimelineWithParams:(NSDictionary *)params completion:(void (^)(NSArray *tweets, NSError *error))completion;

- (void)retweet:(NSString *)tweetId completion:(void (^)(Tweet *tweet, NSError *error))completion;

@end
