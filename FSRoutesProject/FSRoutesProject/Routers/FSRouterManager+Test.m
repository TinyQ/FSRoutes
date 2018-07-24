//
//  FSRouterManager+Test.m
//  FSRoutesProject
//
//  Created by qfu on 2018/7/24.
//  Copyright © 2018 qfu. All rights reserved.
//

#import "FSRouterManager+Test.h"

@implementation FSRouterManager (Test)

- (void)load_test {
    FSRouteItem *route = [[FSRouteItem alloc] init];
    route.introdution = @"A test introdution.";
    route.rules = @[@"/test"];
    route.testURLs = @[@"router://test"];
    [self.router addRoute:route handler:^BOOL(FSRouteHandle * _Nonnull handle) {
        
        return NO;
    }];
}

@end
