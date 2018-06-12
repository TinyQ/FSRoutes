//
//  FSRouter.m
//  FSRoutes
//
//  Created by qfu on 2018/6/11.
//

#import "FSRouter.h"
#import "FSRouteItem.h"
#import "FSRouteHandle.h"
#import "FSRoutesMatcher.h"
#import "FSRoutesMatchResult.h"
#import "NSURL+FSRouteParameters.h"

@interface FSRouter()

@property (nonatomic) NSMutableOrderedSet<FSRouteItem *> *routes;
@property (nonatomic) NSMutableOrderedSet<NSString *> *rules;
@property (nonatomic) NSMutableDictionary<NSString *, id> *handlers;

@end

@implementation FSRouter

- (instancetype)init {
    self = [super init];
    if (self) {
        _routes = [NSMutableOrderedSet orderedSet];
        _rules = [NSMutableOrderedSet orderedSet];
        _handlers = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)addRoute:(FSRouteItem *)route handler:(FSRouteHandler)handler {
    NSParameterAssert(route);
    NSParameterAssert(handler);
    // add route
    [self.routes addObject:route];
    // add handle
    for (NSString *rule in route.rules) {
        [self.rules addObject:rule];
        [self.handlers setObject:handler forKey:rule];
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
    
    BOOL didRoute = NO;
    BOOL isMatched = NO;
    
    FSRoutesMatchResult *matchResult = nil;
    
    for (NSString *rule in [self.rules copy]) {
        FSRoutesMatcher *matcher = [FSRoutesMatcher matcherWithRule:rule];
        didRoute = [matcher match:URL];
        // if not match, we're continue.
        if(!matchResult.match) {
            continue;
        }
        // if we shouldn't execute but it was a match, we're done now.
        if(!executeHandler) {
            return YES;
        }
        isMatched = YES;
        didRoute = [self executeURL:URL rule:rule result:matchResult];
        // if it was routed successfully, we're done.
        if(didRoute) {
            break;
        }
    }
    return didRoute;
}

- (BOOL)executeURL:(NSURL *)URL rule:(NSString *)rule result:(FSRoutesMatchResult *)result {
    NSParameterAssert(URL);
    NSParameterAssert(rule);
    NSParameterAssert(result);
    
    FSRouteHandler handler = self.handlers[rule];
    if(!handler) {
        return NO;
    }
    
    FSRouteHandle *handle = [[FSRouteHandle alloc] initWithURL:URL
                                                          rule:rule
                                               routeParameters:result.parameter];
    return handler(handle);
}

@end
