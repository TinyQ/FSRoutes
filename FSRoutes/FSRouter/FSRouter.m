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

@interface FSRouter()

@property (nonatomic) NSMutableOrderedSet<FSRouteItem *> *routes;
@property (nonatomic) NSMutableOrderedSet<NSString *> *rules;
@property (nonatomic) NSMutableDictionary<NSString *, id> *handlers;

@property (nonatomic, copy) FSRouteHandler unmatchedHandler;

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

- (void)setUnmatchedURLHandler:(FSRouteUnmatchedHandler)handler {
    if (handler) {
        self.unmatchedHandler = [handler copy];
    }
}

- (BOOL)canRoute:(NSURL *)URL {
    NSParameterAssert(URL);
    return [self routeURL:URL context:nil executeHandler:NO];
}

- (BOOL)routeURL:(NSURL *)URL {
    NSParameterAssert(URL);
    return [self routeURL:URL context:nil executeHandler:YES];
}

- (BOOL)routeURL:(NSURL *)URL context:(nullable NSDictionary<NSString *,id> *)context {
    NSParameterAssert(URL);
    return [self routeURL:URL context:context executeHandler:YES];
}

#pragma mark - Private

- (BOOL)routeURL:(NSURL *)URL
         context:(nullable NSDictionary<NSString *,id> *)context
  executeHandler:(BOOL)executeHandler {
    NSParameterAssert(URL);
    
    BOOL didRoute = NO;
    BOOL isMatched = NO;
    
    FSRoutesMatchResult *matchResult = nil;
    
    for (NSString *rule in [self.rules copy]) {
        FSRoutesMatcher *matcher = [FSRoutesMatcher matcherWithRule:rule];
        matchResult = [matcher match:URL];
        // if not match, we're continue.
        if(!matchResult.match) {
            continue;
        }
        // if we shouldn't execute but it was a match, we're done now.
        if(!executeHandler) {
            return YES;
        }
        isMatched = YES;
        didRoute = [self executeURL:URL rule:rule result:matchResult context:context];
        // if it was routed successfully, we're done.
        if(didRoute) {
            break;
        }
    }
    
    // if, after everything, we did not route anything and we have an unmatched URL handler, then call it
    if (!isMatched && executeHandler && self.unmatchedHandler) {
        FSRouteHandle *handle = [FSRouteHandle handleWithURL:URL
                                                        rule:nil
                                             routeParameters:nil
                                           contextParameters:context];
        self.unmatchedHandler(handle);
    }
    
    return didRoute;
}

- (BOOL)executeURL:(NSURL *)URL
              rule:(NSString *)rule
            result:(FSRoutesMatchResult *)result
           context:(nullable NSDictionary<NSString *,id> *)context{
    NSParameterAssert(URL);
    NSParameterAssert(rule);
    NSParameterAssert(result);
    
    FSRouteHandler handler = self.handlers[rule];
    if(!handler) {
        return NO;
    }
    
    FSRouteHandle *handle = [FSRouteHandle handleWithURL:URL
                                                    rule:rule
                                         routeParameters:result.parameter
                                       contextParameters:context];
    return handler(handle);
}

@end
