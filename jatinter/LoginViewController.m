//
//  LoginViewController.m
//  jatinter
//
//  Created by Jatin Pandey on 2/6/15.
//  Copyright (c) 2015 Jatin Pandey. All rights reserved.
//

#import "LoginViewController.h"
#import "TwitterClient.h"
#import "HomeViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
- (IBAction)onLoginButton:(id)sender;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onLoginButton:(id)sender {
    
    [[TwitterClient sharedInstance] loginWithCompletion:^(User *user, NSError *error) {
        if (user != nil) {
            // Modally present home view
            NSLog(@"Oh hey waddup %@", user.name);
            HomeViewController *hvc = [[HomeViewController alloc] init];
            
            [self presentViewController:hvc animated:YES completion:nil];
        }
        else {
            // Present error view
            NSLog(@"ERRORRRR!");
        }
    }];
    
//    HomeViewController *hvc = [[HomeViewController alloc] init];
//    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:hvc];
//    [self presentViewController:nvc animated:YES completion:nil];
}

@end
