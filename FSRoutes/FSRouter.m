//
//  FSRouter.m
//  FSRoutes
//
//  Created by qfu on 2018/6/11.
//

#import "FSRouter.h"
#import "FSRouteItem.h"
#import "FSRouteHandle.h"

@interface FSRouter()

@end

@implementation FSRouter

- (void)addRoute:(FSRouteItem *)router handler:(FSRouteHandle *)handle {
    
}

- (BOOL)canRoute:(NSURL *)URL {
    return NO;
}

- (BOOL)routeURL:(NSURL *)URL {
    return NO;
}

@end
