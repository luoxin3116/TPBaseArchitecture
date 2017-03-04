//
//  AppDelegate.m
//  YYZN
//
//  Created by ccpg_it on 17/1/16.
//  Copyright © 2017年 ccpg_it. All rights reserved.
//

#import "AppDelegate.h"
#import "ENTabBarController.h"
#import "EWCacheManager.h"
#import "ZNNewFeatureViewController.h"
#import "ZNLoginViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {


    
    //注册DCURL的plist文件
    [DCURLRouter loadConfigDictFromPlist:@"DCURLRouter.plist"];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    [self.window makeKeyAndVisible];
    
    //新特性
    [self setNewFeature];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma mark - newFeature
- (void)setNewFeature{
    //得到最近的版本号
    NSString *latestVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"versionKey"];
    //得到当前的版本号
    //NSString *currentVersion = [NSBundle mainBundle].infoDictionary[versionKey];
    
    ZNNewFeatureViewController *newVc = [[ZNNewFeatureViewController alloc] init];
    
    ZNLoginViewController *loginVc = [[ZNLoginViewController alloc]init];
    
    //老版本
    if ([[NSBundle mainBundle].infoDictionary[@"CFBundleVersion"] isEqualToString:latestVersion] ) {
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:loginVc];
        nav.navigationBar.hidden = YES;
        self.window.rootViewController = nav;
    }else{
        //新版本
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:newVc];
        self.window.rootViewController = nav;
        nav.navigationBar.hidden = YES;
        [[NSUserDefaults standardUserDefaults] setObject:[NSBundle mainBundle].infoDictionary[@"CFBundleVersion"] forKey:@"versionKey"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

}

@end