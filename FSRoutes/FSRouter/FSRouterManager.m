//
//  FSRouterManager.m
//  FSRoutes
//
//  Created by qfu on 2018/6/11.
//

#import "FSRouterManager.h"
#import "FSRouter.h"
#import <objc/runtime.h>

#define FSRouterLoadMethodPrefix @"load_"

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

- (void)loadAllRoutes {
    unsigned int methodCount;
    Method *methodList = class_copyMethodList([self class], &methodCount);
    for (int i = 0; i < methodCount; i++) {
        SEL selector = method_getName(methodList[i]);
        const char * sel_name = sel_getName(selector);
        NSString *key = [NSString stringWithCString:sel_name encoding:NSUTF8StringEncoding];
        if ([key hasPrefix:@"load_"]) {
            IMP imp = [self methodForSelector:selector];
            void (*func)(id, SEL) = (void *)imp;
            func(self, selector);
        }
    }
    free(methodList);
}

@end
