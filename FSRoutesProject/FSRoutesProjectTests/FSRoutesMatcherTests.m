//
//  FSRoutesMatcherTests.m
//  FSRoutesProjectTests
//
//  Created by qfu on 24/09/2017.
//  Copyright © 2017 qfu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Expecta/Expecta.h>
#import <FSRoutes/FSRoutes.h>

NSURL *URLWithPath(NSString *path) {
    return [NSURL URLWithString:[NSString stringWithFormat:@"http://qfu.space%@", path]];
}

@interface FSRoutesMatcherTests : XCTestCase

@end

@implementation FSRoutesMatcherTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

#pragma mark - Initialization

- (void)test_initialization {
    // creates an instance with a route
    FSRoutesMatcher *matcher = nil;
    matcher = [FSRoutesMatcher matcherWithRule:@"xxx://test/:parm0"];
    expect(matcher).notTo.beNil();
    
    // does not create an instance with no route
    matcher = [FSRoutesMatcher matcherWithRule:@""];
    expect(matcher).to.beNil();
    
    // does not create an instance with :// prefix rule
    matcher = [FSRoutesMatcher matcherWithRule:@"://def/abc"];
    expect(matcher).to.beNil();
    
    // does not create an instance with // prefix rule
    matcher = [FSRoutesMatcher matcherWithRule:@"//def/abc"];
    expect(matcher).to.beNil();
}

- (void)test_rule_scheme_exist {
    FSRoutesMatcher *matcher = nil;
    matcher = [FSRoutesMatcher matcherWithRule:@"abc://def"];
    expect([matcher ruleScheme]).to.equal(@"abc");
    
    matcher = [FSRoutesMatcher matcherWithRule:@"https://def"];
    expect([matcher ruleScheme]).to.equal(@"https");
}

- (void)test_rule_scheme_not_exist {
    FSRoutesMatcher *matcher = nil;
    
    matcher = [FSRoutesMatcher matcherWithRule:@"def/abc"];
    expect([matcher ruleScheme]).to.beNil();
    
    matcher = [FSRoutesMatcher matcherWithRule:@"/def/abc"];
    expect([matcher ruleScheme]).to.beNil();
    
    matcher = [FSRoutesMatcher matcherWithRule:@"//def/abc"];
    expect([matcher ruleScheme]).to.beNil();
}

- (void)test_rule_expression {
    FSRoutesMatcher *matcher = nil;
    matcher = [FSRoutesMatcher matcherWithRule:@"abc://def"];
    expect([matcher ruleExpression]).to.equal(@"def");
    
    matcher = [FSRoutesMatcher matcherWithRule:@"abc://def/ghi"];
    expect([matcher ruleExpression]).to.equal(@"def/ghi");
    
    matcher = [FSRoutesMatcher matcherWithRule:@"/def/abc"];
    expect([matcher ruleExpression]).to.equal(@"/def/abc");
}

- (void)test_when_a_host_match {
    FSRoutesMatcher *matcher = [FSRoutesMatcher matcherWithRule:@"qfu.space"];
    expect(matcher).notTo.beNil();
    
    NSURL *url = URLWithPath(@"");
    FSRoutesMatchResult *result = [matcher match:url];
    expect(result).notTo.beNil();
    expect(result.match).to.equal(YES);
    expect(result.parameter).to.equal(@{});
}

- (void)test_when_a_host_not_match {
    FSRoutesMatcher *matcher = [FSRoutesMatcher matcherWithRule:@"qfu.me"];
    expect(matcher).notTo.beNil();
    
    NSURL *url = URLWithPath(@"");
    FSRoutesMatchResult *result = [matcher match:url];
    expect(result).notTo.beNil();
    expect(result.match).to.equal(NO);
    expect(result.parameter).to.equal(nil);
}

- (void)test_when_a_host_match_and_path_match {
    FSRoutesMatcher *matcher = [FSRoutesMatcher matcherWithRule:@"qfu.space/abc/def"];
    expect(matcher).notTo.beNil();
    
    NSURL *url = URLWithPath(@"/abc/def");
    FSRoutesMatchResult *result = [matcher match:url];
    expect(result).notTo.beNil();
    expect(result.match).to.equal(YES);
    expect(result.parameter).to.equal(@{});
}

- (void)test_when_a_host_not_match_and_path_match {
    FSRoutesMatcher *matcher = [FSRoutesMatcher matcherWithRule:@"qfu.me/abc/:id"];
    expect(matcher).notTo.beNil();
    
    NSURL *url = URLWithPath(@"/abc/123");
    FSRoutesMatchResult *result = [matcher match:url];
    expect(result).notTo.beNil();
    expect(result.match).to.equal(NO);
    expect(result.parameter).to.equal(nil);
}

- (void)test_when_a_host_match_and_path_not_match {
    FSRoutesMatcher *matcher = [FSRoutesMatcher matcherWithRule:@"qfu.space/abc/:id"];
    expect(matcher).notTo.beNil();
    
    NSURL *url = URLWithPath(@"/def/123");
    FSRoutesMatchResult *result = [matcher match:url];
    expect(result).notTo.beNil();
    expect(result.match).to.equal(NO);
    expect(result.parameter).to.equal(nil);
}

- (void)test_when_a_host_not_match_and_path_not_match {
    FSRoutesMatcher *matcher = [FSRoutesMatcher matcherWithRule:@"qfu.me/abc/:id"];
    expect(matcher).notTo.beNil();
    
    NSURL *url = URLWithPath(@"/def/123");
    FSRoutesMatchResult *result = [matcher match:url];
    expect(result).notTo.beNil();
    expect(result.match).to.equal(NO);
    expect(result.parameter).to.equal(nil);
}

- (void)test_when_a_url_matches_a_route {
    FSRoutesMatcher *matcher = [FSRoutesMatcher matcherWithRule:@"/def"];
    expect(matcher).notTo.beNil();
    
    NSURL *url = URLWithPath(@"/def");
    FSRoutesMatchResult *result = [matcher match:url];
    expect(result).notTo.beNil();
    expect(result.match).to.equal(YES);
    expect(result.parameter).to.equal(@{});
}
    
- (void)test_when_a_url_matches_a_route_with_1_parameter {
    FSRoutesMatcher *matcher = [FSRoutesMatcher matcherWithRule:@"/def/:id"];
    expect(matcher).notTo.beNil();

    NSURL *url = URLWithPath(@"/def/123");
    FSRoutesMatchResult *result = [matcher match:url];
    expect(result).notTo.beNil();
    expect(result.match).to.equal(YES);
    expect(result.parameter[@"id"]).to.equal(@"123");
}
    
- (void)test_when_a_url_matches_a_route_with_2_parameter_style_1 {
    FSRoutesMatcher *matcher = [FSRoutesMatcher matcherWithRule:@"/def/:id/:name"];
    expect(matcher).notTo.beNil();
    
    NSURL *url = URLWithPath(@"/def/123/456");
    FSRoutesMatchResult *result = [matcher match:url];
    expect(result).notTo.beNil();
    expect(result.match).to.equal(YES);
    expect(result.parameter[@"id"]).to.equal(@"123");
    expect(result.parameter[@"name"]).to.equal(@"456");
}

- (void)test_when_a_url_matches_a_route_with_2_parameter_style_2 {
    FSRoutesMatcher *matcher = [FSRoutesMatcher matcherWithRule:@"/id/:id/name/:name"];
    expect(matcher).notTo.beNil();
    
    NSURL *url = URLWithPath(@"/id/123/name/qfu");
    FSRoutesMatchResult *result = [matcher match:url];
    expect(result).notTo.beNil();
    expect(result.match).to.equal(YES);
    expect(result.parameter[@"id"]).to.equal(@"123");
    expect(result.parameter[@"name"]).to.equal(@"qfu");
}

- (void)test_when_a_url_matches_a_route_with_2_parameter_style_3 {
    FSRoutesMatcher *matcher = [FSRoutesMatcher matcherWithRule:@"/:id/name/:name"];
    expect(matcher).notTo.beNil();
    
    NSURL *url = URLWithPath(@"/123/name/qfu");
    FSRoutesMatchResult *result = [matcher match:url];
    expect(result).notTo.beNil();
    expect(result.match).to.equal(YES);
    expect(result.parameter[@"id"]).to.equal(@"123");
    expect(result.parameter[@"name"]).to.equal(@"qfu");
}

@end
