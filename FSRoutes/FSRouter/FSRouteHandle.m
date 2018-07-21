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
                         rule:(nullable NSString *)rule
              routeParameters:(nullable NSDictionary *)routeParameters
            contextParameters:(nullable NSDictionary *)contextParameters {
    return [[FSRouteHandle alloc] initWithURL:URL
                                         rule:rule
                              routeParameters:routeParameters
                            contextParameters:contextParameters];
}

- (instancetype)initWithURL:(NSURL*)URL
                       rule:(NSString *)rule
            routeParameters:(NSDictionary *)routeParameters
          contextParameters:(NSDictionary *)contextParameters {
    self = [super init];
    if (self) {
        NSParameterAssert(URL);
        _URL = URL;
        _rule = rule;
        _queryParameters = [[_URL query] fs_parametersFromQueryString];
        _routeParameters = [routeParameters copy];
        _contextParameters = [contextParameters copy];
    }
    return self;
}

- (id)copyWithZone:(nullable NSZone *)zone {
    return [[self class] handleWithURL:self.URL
                                  rule:self.rule
                       routeParameters:self.routeParameters
                     contextParameters:self.contextParameters];
}

- (NSString *)description {
    return [NSString stringWithFormat:@" url   : %@ \n rule  : %@ \n param : %@ ", self.URL, self.rule, self.routeParameters];
}

@end
