//
//  AppDelegate.m
//  dbstandupemail
//
//  Created by Daniele Bogo on 27/07/2015.
//  Copyright (c) 2015 Daniele Bogo. All rights reserved.
//

#import "AppDelegate.h"
#import "DBSESignInViewController.h"
#import "DBSETimeLineViewController.h"


@interface AppDelegate ()

@property (nonatomic, strong) id rootViewController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeRootViewControllers:) name:kDBSEUpdateRootViewController object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutAction) name:kDBSELogout object:nil];
    
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.rootViewController = self.rootViewController;
    
    [_window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - Observer

- (void)changeRootViewControllers:(NSNotification *)notification
{
    _window.rootViewController = self.rootViewController;
}

- (void)logoutAction
{
    [[DBSEUserCredentials sharedInstance] logout];
    
    _window.rootViewController = self.rootViewController;
}


#pragma mark - Override

- (id)rootViewController
{
    DBSEUserCredentials *credentials = [DBSEUserCredentials sharedInstance];
    if (credentials) {
        [credentials loadCredentialsIfFound];
    }
    
    UINavigationController *navigationController = [UINavigationController new];
    navigationController.navigationBarHidden = YES;
    
    if (!credentials.isLoggedIn) {
        DBSESignInViewController *signinViewController = [DBSESignInViewController new];
        navigationController.viewControllers = @[signinViewController];
    } else {
        DBSETimeLineViewController *timelineViewController = [DBSETimeLineViewController new];
        navigationController.viewControllers = @[timelineViewController];
    }
    
    return navigationController;
}

#pragma mark - Private methods

- (NSString *)dbse_sqliteName
{
    return [NSString stringWithFormat:@"%@.sqlite", [DBSEUserCredentials sharedInstance].userAuthId];
}

@end
