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

@property (nonatomic) NSMutableOrderedSet<FSRouteItem *> *routes;
@property (nonatomic) NSMutableDictionary<NSString *, FSRouteHandle *> *handlers;

@end

@implementation FSRouter

- (instancetype)init {
    self = [super init];
    if (self) {
        _routes = [NSMutableOrderedSet orderedSet];
        _handlers = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)addRoute:(FSRouteItem *)route handler:(FSRouteHandle *)handle {
    NSParameterAssert(route);
    NSParameterAssert(handle);
    // add route
    [self.routes addObject:route];
    // add handle
    for (NSString *pattern in route.patterns) {
        self.handlers[pattern] = handle;
    }
}

- (BOOL)canRoute:(NSURL *)URL {
    NSParameterAssert(URL);
    return [self routeURL:URL executeHandler:NO];
}

- (BOOL)routeURL:(NSURL *)URL {
    NSParameterAssert(URL);
    return [self routeURL:URL executeHandler:YES];
}

#pragma mark - Private

- (BOOL)routeURL:(NSURL *)URL executeHandler:(BOOL)executeHandler {
    NSParameterAssert(URL);
    // TODO :
    return NO;
}

@end
