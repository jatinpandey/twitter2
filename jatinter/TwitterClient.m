//
//  TwitterClient.m
//  jatinter
//
//  Created by Jatin Pandey on 2/7/15.
//  Copyright (c) 2015 Jatin Pandey. All rights reserved.
//

#import "TwitterClient.h"

NSString * const kTwitterKey = @"DzndJYMNBJRmCbf0rOGfOCebo";
NSString * const kTwitterSecret = @"A4h5Kn8oJT36VBih7fnfPIvn4aTzm9rRrhe3XnvrFbIAvPQluY";
NSString * const baseUrl = @"https://api.twitter.com";

@interface TwitterClient ()

@property (strong, nonatomic) void (^loginCompletion)(User *user, NSError *error);

@end

@implementation TwitterClient

+ (TwitterClient *) sharedInstance {
    static TwitterClient *instance = nil;
    

    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[TwitterClient alloc] initWithBaseURL:[NSURL URLWithString:baseUrl] consumerKey:kTwitterKey consumerSecret:kTwitterSecret];
        }
    });
        
    return instance;
}

- (void)loginWithCompletion:(void (^)(User *user, NSError *error))completion {
    
    self.loginCompletion = completion;

    [self.requestSerializer removeAccessToken];
    [self fetchRequestTokenWithPath:@"oauth/request_token" method:@"GET" callbackURL:[NSURL URLWithString:@"jatinter://oauth"] scope:nil success:^(BDBOAuth1Credential *requestToken) {
        NSLog(@"Got request token!");
        
        NSURL *authUrl = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.twitter.com/oauth/authorize?oauth_token=%@", requestToken.token]];
        [[UIApplication sharedApplication] openURL:authUrl];
        
    } failure:^(NSError *error) {
        NSLog(@"Failed to get token :(");
        self.loginCompletion(nil, error);
    }];
}

- (void)openUrl:(NSURL *)url {
    [self fetchAccessTokenWithPath:@"oauth/access_token" method:@"POST" requestToken: [BDBOAuth1Credential credentialWithQueryString:url.query] success:^(BDBOAuth1Credential *accessToken) {
        
        NSLog(@"You're in");
        
        [self.requestSerializer saveAccessToken:accessToken];
        [self GET:@"1.1/account/verify_credentials.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            User *currentUser = [[User alloc] initWithDictionary:responseObject];
            [User setCurrentUser:currentUser];
            self.loginCompletion(currentUser, nil);

//            NSLog(@"Username: %@", currentUser.screenName);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Failed to get user");
            self.loginCompletion(nil, error);

        }];
        
        
    } failure:^(NSError *error) {
        NSLog(@"No access token dawg");
        self.loginCompletion(nil, error);
    }];
    
}

- (void)getTimelineWithParams:(NSDictionary *)params completion:(void (^)(NSArray *tweets, NSError *error))completion {
    [self GET:@"1.1/statuses/home_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *tweets = [Tweet tweetsFromArray:responseObject];
        completion(tweets, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failed to GET tweets");
        completion(nil, error);
    }];
}

- (void)retweet:(NSString *)tweetId completion:(void (^)(Tweet *tweet, NSError *error))completion {
    NSString *url = [NSString stringWithFormat:@"1.1/statuses/retweet/%@.json", tweetId];
    NSLog(@"%@", url);
    [self POST:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        Tweet *x = [[Tweet alloc] initWithDictionary:responseObject];
        completion(x, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Whoops retweet failed");
        completion(nil, error);
    }];
}

@end
