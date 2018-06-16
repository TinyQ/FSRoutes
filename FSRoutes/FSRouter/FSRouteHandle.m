//
//  FSRouterHandler.m
//  FSRoutes
//
//  Created by qfu on 2018/6/11.
//

#import "FSRouteHandle.h"
#import "NSString+FSRouteParameters.h"

@implementation FSRouteHandle

+ (instancetype)handleWithURL:(NSURL*)URL
                         rule:(NSString *)rule
              routeParameters:(NSDictionary *)routeParameters {
    return [[FSRouteHandle alloc] initWithURL:URL rule:rule routeParameters:routeParameters];
}

- (instancetype)initWithURL:(NSURL*)URL
                       rule:(NSString *)rule
            routeParameters:(NSDictionary *)routeParameters {
    self = [super init];
    if (self) {
        NSParameterAssert(URL);
        NSParameterAssert(rule);
        _URL = URL;
        _rule = rule;
        _queryParameters = [[_URL query] fs_parametersFromQueryString];
        _routeParameters = [routeParameters copy];
    }
    return self;
}

@end
