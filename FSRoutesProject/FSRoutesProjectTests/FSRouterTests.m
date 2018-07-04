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

@end

@implementation FSRouterTests

- (void)setUp {
    [super setUp];
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

- (void)test_router_handler {
    FSRouter *router = [[FSRouter alloc] init];
    //
    FSRouteItem *item = [[FSRouteItem alloc] init];
    item.introdution = @"test introdution";
    item.testURLs = @[@"https://github.com/TinyQ/FSRoutes"];
    item.rules = @[@"/TinyQ/FSRoutes"];
    
    __block FSRouteHandle *result = nil;
    
    [router addRoute:item handler:^BOOL(FSRouteHandle *handle) {
        result = [handle copy];
        return YES;
    }];
    
    NSURL *URL = [NSURL URLWithString:@"https://github.com/TinyQ/FSRoutes"];
    expect([router routeURL:URL]).to.beTruthy();
    expect(result).notTo.beNil();
    expect(result.URL.absoluteString).to.equal(URL.absoluteString);
    expect(result.rule).to.equal(@"/TinyQ/FSRoutes");
    expect(result.queryParameters).to.beNil();
    expect(result.routeParameters).to.beNil();
}

- (void)test_router_handler_with_query_parameters {
    FSRouter *router = [[FSRouter alloc] init];
    //
    FSRouteItem *item = [[FSRouteItem alloc] init];
    item.introdution = @"test introdution";
    item.testURLs = @[@"https://github.com/TinyQ/FSRoutes"];
    item.rules = @[@"/TinyQ/FSRoutes"];
    
    __block FSRouteHandle *result = nil;
    
    [router addRoute:item handler:^BOOL(FSRouteHandle *handle) {
        result = [handle copy];
        return YES;
    }];
    
    NSURL *URL = [NSURL URLWithString:@"https://github.com/TinyQ/FSRoutes?abc=123&def=456"];
    
    expect([router routeURL:URL]).to.beTruthy();
    expect(result).notTo.beNil();
    expect(result.URL).to.equal(URL);
    expect(result.rule).to.equal(@"/TinyQ/FSRoutes");
    expect(result.queryParameters).to.equal(@{@"abc":@"123", @"def":@"456"});
    expect(result.routeParameters).to.beNil();
}

- (void)test_router_handler_with_unmatch_handler {
    FSRouter *router = [[FSRouter alloc] init];
    //
    FSRouteItem *item = [[FSRouteItem alloc] init];
    item.introdution = @"test introdution";
    item.testURLs = @[@"https://github.com/TinyQ/FSRoutes"];
    item.rules = @[@"/TinyQ/FSRoutes"];
    //
    __block FSRouteHandle *result = nil;
    [router addRoute:item handler:^BOOL(FSRouteHandle * _Nonnull handle) {
        result = [handle copy];
        return YES;
    }];
    //
    __block FSRouteHandle *unmatchResult = nil;
    [router setUnmatchedURLHandler:^(FSRouteHandle * _Nonnull handle) {
        unmatchResult = [handle copy];
    }];
    
    NSURL *URL = [NSURL URLWithString:@"https://github.com/TinyQ/Unmatch/FSRoutes?abc=123&def=456"];
    
    expect([router canRoute:URL]).to.beFalsy();
    expect([router routeURL:URL]).to.beFalsy();
    expect(result).to.beNil();
    expect(unmatchResult).notTo.beNil();
    expect(unmatchResult.URL).to.equal(URL);
}

@end
