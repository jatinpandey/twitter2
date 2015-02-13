//
//  User.h
//  jatinter
//
//  Created by Jatin Pandey on 2/8/15.
//  Copyright (c) 2015 Jatin Pandey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

extern NSString * const UserDidLoginNotification;
extern NSString * const UserDidLogoutNotification;

@property (strong, nonatomic) NSString *screenName;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *profileImageUrl;
@property (strong, nonatomic) NSString *tagline;

- (id)initWithDictionary:(NSDictionary *)dict;

+ (User *)currentUser;
+ (void)setCurrentUser:(User *)currentUser;
+ (void)logout;

@end
