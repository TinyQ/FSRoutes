//
//  NSURL+FSRouteParameters.m
//  FSRoutes
//
//  Created by qfu on 2018/6/12.
//

#import "NSURL+FSRouteParameters.h"
#import <objc/runtime.h>

@implementation NSURL (FSRouteParameters)
@dynamic routeParameters;

- (void)setAssociatedObject:(id)object {
    objc_setAssociatedObject(self, @selector(routeParameters), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)associatedObject {
    return objc_getAssociatedObject(self, @selector(routeParameters));
}

@end
