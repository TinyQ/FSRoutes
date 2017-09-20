//
//  FSRoutesMatcher.m
//  FSRoutes
//
//  Created by qfu on 21/09/2017.
//

#import "FSRoutesMatcher.h"

@interface FSRoutesMatcher()

@property (nonatomic) NSString *rule;

@end

@implementation FSRoutesMatcher

+ (instancetype)matcherWithRule:(NSString *)rule {
    NSParameterAssert(rule);
    return [[FSRoutesMatcher alloc] initWithRule:rule];;
}

- (instancetype)initWithRule:(NSString *)rule {
    self = [super init];
    if (self) {
        _rule = rule;
    }
    return self;
}

- (FSRoutesMatchResult *)match:(NSURL *)url {
    return nil;
}

@end
