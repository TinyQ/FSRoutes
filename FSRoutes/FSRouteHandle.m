//
//  FSRouterHandler.m
//  FSRoutes
//
//  Created by qfu on 2018/6/11.
//

#import "FSRouteHandle.h"
#import "NSString+FSRouteParameters.h"

@implementation FSRouteHandle

- (instancetype)initWithURL:(NSURL*)URL
                       rule:(NSString *)rule
            routeParameters:(NSDictionary *)routeParameters {
    self = [super init];
    if (self) {
        _URL = URL;
        _rule = rule;
        _queryParameters = [[_URL query] fs_parametersFromQueryString];
        _routeParameters = [routeParameters copy];
    }
    return self;
}

@end
