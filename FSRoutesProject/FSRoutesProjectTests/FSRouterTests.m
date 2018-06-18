//
//  FSRouterTests.m
//  FSRoutesProjectTests
//
//  Created by qfu on 2018/6/18.
//  Copyright © 2018 qfu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Expecta/Expecta.h>
#import <FSRoutes/FSRoutes.h>

@interface FSRouterTests : XCTestCase

@property (nonatomic,strong) FSRouter *router;

@end

@implementation FSRouterTests

- (void)setUp {
    [super setUp];
    self.router = [[FSRouter alloc] init];
    //
    FSRouteItem *item = [[FSRouteItem alloc] init];
    item.introdution = @"test introdution";
    item.testURLs = @[@"https://github.com/TinyQ/FSRoutes"];
    item.rules = @[@"/TinyQ/FSRoutes"];
    //
    [self.router addRoute:item handler:^BOOL(FSRouteHandle *handle) {
        return YES;
    }];
}

- (void)tearDown {
    [super tearDown];
}

- (void)test_initialization {
    FSRouter *router = [[FSRouter alloc] init];
    //
    expect(router).notTo.beNil();
    expect(router.routes).notTo.beNil();
    expect(router.rules).notTo.beNil();
    expect(router.handlers).notTo.beNil();
}

- (void)test_add_route {
    FSRouter *router = [[FSRouter alloc] init];
    //
    FSRouteItem *item = [[FSRouteItem alloc] init];
    item.introdution = @"test introdution";
    item.testURLs = @[@"https://github.com/TinyQ/FSRoutes"];
    item.rules = @[@"/TinyQ/FSRoutes"];
    [router addRoute:item handler:^BOOL(FSRouteHandle *handle) {
        return YES;
    }];
    //
    expect(item).notTo.beNil();
    expect(router.routes).to.contain(item);
    expect(router.rules).to.contain(@"/TinyQ/FSRoutes");
}

- (void)test_can_route {
    FSRouter *router = [[FSRouter alloc] init];
    //
    FSRouteItem *item = [[FSRouteItem alloc] init];
    item.introdution = @"test introdution";
    item.testURLs = @[@"https://github.com/TinyQ/FSRoutes"];
    item.rules = @[@"/TinyQ/FSRoutes"];
    [router addRoute:item handler:^BOOL(FSRouteHandle *handle) {
        return YES;
    }];
    NSURL *URL = [NSURL URLWithString:@"https://github.com/TinyQ/FSRoutes"];
    expect([router canRoute:URL]).to.beTruthy();
    
    NSURL *URL2 = [NSURL URLWithString:@"https://gitlab.com/TinyQ/FSRoutes"];
    expect([router canRoute:URL2]).to.beTruthy();
    
    NSURL *URL3 = [NSURL URLWithString:@"https://gitlab.com/ABC/FSRoutes"];
    expect([router canRoute:URL3]).to.beFalsy();
}

- (void)test_route_URL {
    NSURL *URL = [NSURL URLWithString:@"https://github.com/TinyQ/FSRoutes"];
    expect([self.router routeURL:URL]).to.beTruthy();
}

- (void)test_route_URL_with_query_parameters {
    NSURL *URL = [NSURL URLWithString:@"https://github.com/TinyQ/FSRoutes?abc=123&def=456"];
    expect([self.router routeURL:URL]).to.beTruthy();
}

@end
