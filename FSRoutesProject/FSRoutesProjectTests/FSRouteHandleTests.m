//
//  FSRouteHandleTests.m
//  FSRoutesProjectTests
//
//  Created by qfu on 2018/6/17.
//  Copyright © 2018 qfu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Expecta/Expecta.h>
#import <FSRoutes/FSRoutes.h>

@interface FSRouteHandleTests : XCTestCase

@end

@implementation FSRouteHandleTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)test_initialization {
    NSURL *URL = [NSURL URLWithString:@"https://github.com/TinyQ/FSRoutes"];
    FSRouteHandle *handle = [FSRouteHandle handleWithURL:URL rule:@"/TinyQ/FSRoutes" routeParameters:nil contextParameters:nil];
    expect(handle).notTo.beNil();
}

- (void)test_when_url_not_parameters {
    NSURL *URL = [NSURL URLWithString:@"https://github.com/TinyQ/FSRoutes"];
    FSRouteHandle *handle = [FSRouteHandle handleWithURL:URL rule:@"/TinyQ/FSRoutes" routeParameters:nil contextParameters:nil];
    expect(handle).notTo.beNil();
    expect(handle.URL.absoluteString).equal(@"https://github.com/TinyQ/FSRoutes");
    expect(handle.rule).equal(@"/TinyQ/FSRoutes");
    expect(handle.queryParameters).to.beNil();
    expect(handle.routeParameters).to.beNil();
}

- (void)test_has_route_parameters {
    NSURL *URL = [NSURL URLWithString:@"https://github.com/TinyQ/FSRoutes"];
    FSRouteHandle *handle = [FSRouteHandle handleWithURL:URL rule:@"/TinyQ/FSRoutes" routeParameters:@{@"abc":@"def"} contextParameters:nil];
    expect(handle).notTo.beNil();
    expect(handle.URL.absoluteString).equal(@"https://github.com/TinyQ/FSRoutes");
    expect(handle.rule).equal(@"/TinyQ/FSRoutes");
    expect(handle.queryParameters).to.beNil();
    expect(handle.routeParameters).equal(@{@"abc":@"def"});
}

- (void)test_has_query_parameters {
    NSURL *URL = [NSURL URLWithString:@"https://github.com/TinyQ/FSRoutes?abc=123&def=456"];
    FSRouteHandle *handle = [FSRouteHandle handleWithURL:URL rule:@"/TinyQ/FSRoutes" routeParameters:@{@"abc":@"def"} contextParameters:nil];
    expect(handle).notTo.beNil();
    expect(handle.URL.absoluteString).equal(@"https://github.com/TinyQ/FSRoutes?abc=123&def=456");
    expect(handle.rule).equal(@"/TinyQ/FSRoutes");
    expect(handle.queryParameters).equal(@{@"abc":@"123", @"def":@"456"});
    expect(handle.routeParameters).equal(@{@"abc":@"def"});
}

- (void)test_has_context_parameters {
    NSURL *URL = [NSURL URLWithString:@"https://github.com/TinyQ/FSRoutes?abc=123&def=456"];
    FSRouteHandle *handle = [FSRouteHandle handleWithURL:URL rule:@"/TinyQ/FSRoutes" routeParameters:@{@"abc":@"def"} contextParameters:@{@"abc":@"def"}];
    expect(handle).notTo.beNil();
    expect(handle.URL.absoluteString).equal(@"https://github.com/TinyQ/FSRoutes?abc=123&def=456");
    expect(handle.rule).equal(@"/TinyQ/FSRoutes");
    expect(handle.queryParameters).equal(@{@"abc":@"123", @"def":@"456"});
    expect(handle.routeParameters).equal(@{@"abc":@"def"});
    expect(handle.contextParameters).equal(@{@"abc":@"def"});
}

@end
