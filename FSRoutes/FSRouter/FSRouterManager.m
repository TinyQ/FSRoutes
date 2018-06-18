//
//  FSRouterManager.m
//  FSRoutes
//
//  Created by qfu on 2018/6/11.
//

#import "FSRouterManager.h"
#import "FSRouter.h"
#import <objc/runtime.h>

@interface FSRouterManager()

@property (nonatomic) FSRouter *router;

@end

@implementation FSRouterManager

+ (instancetype)shared {
    static id instance = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _router = [[FSRouter alloc] init];
    }
    return self;
}

@end
