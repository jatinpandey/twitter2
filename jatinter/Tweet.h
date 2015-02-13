//
//  Tweet.h
//  jatinter
//
//  Created by Jatin Pandey on 2/8/15.
//  Copyright (c) 2015 Jatin Pandey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Tweet : NSObject

@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSDate *tweetedAt;
@property (strong, nonatomic) User *user;
@property (strong, nonatomic) NSString *tweetId;

- (id)initWithDictionary:(NSDictionary *)dict;

+ (NSArray *)tweetsFromArray:(NSArray *)dictArray;

@end
