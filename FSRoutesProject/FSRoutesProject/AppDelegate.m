//
//  AppDelegate.m
//  FSRoutesProject
//
//  Created by qfu on 19/09/2017.
//  Copyright © 2017 qfu. All rights reserved.
//

#import "AppDelegate.h"
#import <FSRoutes/FSRoutes.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // load all routes form FSRouterManager`s category.
    [[FSRouterManager shared] loadAllRoutes];
    
    return YES;
}

@end
