//
//  FSRoutes.m
//  Pods-FSRoutesProject
//
//  Created by qfu on 19/09/2017.
//

#import "FSRoutes.h"

@interface FSRoutes()

@property (nonatomic, strong) NSMutableOrderedSet *rules;

@end

@implementation FSRoutes

- (instancetype)init {
    self = [super init];
    if (self) {
        _rules = [NSMutableOrderedSet orderedSet];
    }
    return self;
}

- (void)dealloc {
    
}

- (BOOL)routeURL:(NSURL *)URL {
    return [self routeURL:URL parameters:nil];
}

- (BOOL)routeURL:(NSURL *)URL parameters:(nullable NSDictionary<NSString *, id> *)parameters {
    NSParameterAssert(URL);
    return NO;
}

@end
