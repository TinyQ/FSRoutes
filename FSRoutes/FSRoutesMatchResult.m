//
//  FSRoutesMatchResult.m
//  FSRoutes
//
//  Created by qfu on 21/09/2017.
//

#import "FSRoutesMatchResult.h"

@implementation FSRoutesMatchResult

- (NSString *)description {
    return [NSString stringWithFormat:@"isMatch : %@ routeParameter : %@", @(self.match),self.routeParameter];
}

@end
