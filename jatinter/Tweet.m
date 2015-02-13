//
//  Tweet.m
//  jatinter
//
//  Created by Jatin Pandey on 2/8/15.
//  Copyright (c) 2015 Jatin Pandey. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

- (id)initWithDictionary:(NSDictionary *)dict {
    
    self = [super init];
    if (self) {
        self.text = dict[@"text"];
        self.tweetId = dict[@"id_str"];
        self.user = [[User alloc] initWithDictionary:dict[@"user"]];
        NSString *createdAtString = dict[@"created_at"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"EEE MMM d HH:mm:ss Z y";
        self.tweetedAt = [formatter dateFromString:createdAtString];
    }
    
    return self;
}

+ (NSArray *)tweetsFromArray:(NSArray *)dictArray {
    
    NSMutableArray *tweets = [NSMutableArray array];
    for (NSDictionary *dict in dictArray) {
        Tweet *tweet = [[Tweet alloc] initWithDictionary:dict];
        [tweets addObject:tweet];
    }
    return tweets;
}

@end
