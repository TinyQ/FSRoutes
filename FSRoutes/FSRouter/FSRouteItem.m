//
//  FSRouterItem.m
//  FSRoutes
//
//  Created by qfu on 2018/6/11.
//

#import "FSRouteItem.h"

@implementation FSRouteItem

- (id)copyWithZone:(nullable NSZone *)zone {
    FSRouteItem *item = [[FSRouteItem alloc] init];
    item.introdution = self.introdution;
    item.testURLs = self.testURLs;
    item.rules = self.rules;
    return item;
}

@end
