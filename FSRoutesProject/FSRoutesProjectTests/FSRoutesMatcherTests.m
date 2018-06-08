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
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)test_Initialization {
    FSRoutesMatcher *matcher = nil;
    matcher = [FSRoutesMatcher matcherWithRule:@"xxx://test/:parm0"];
    NSLog(@"%@",matcher);
    expect(matcher).notTo.beNil();
    
    matcher = [FSRoutesMatcher matcherWithRule:@""];
    NSLog(@"%@",matcher);
    expect(matcher).to.beNil();
}

- (void)test_ruleScheme {
    FSRoutesMatcher *matcher = nil;
    matcher = [FSRoutesMatcher matcherWithRule:@"abc://def"];
    expect([matcher ruleScheme]).to.equal(@"abc");
    
    matcher = [FSRoutesMatcher matcherWithRule:@"/def/abc"];
    expect([matcher ruleScheme]).to.beNil();
}

- (void)test_ruleExpression {
    FSRoutesMatcher *matcher = nil;
    matcher = [FSRoutesMatcher matcherWithRule:@"abc://def"];
    expect([matcher ruleExpression]).to.equal(@"def");
    
    matcher = [FSRoutesMatcher matcherWithRule:@"/def/abc"];
    expect([matcher ruleExpression]).to.equal(@"/def/abc");
}

- (void)test_ruleParameter_0 {
    FSRoutesMatcher *matcher = [FSRoutesMatcher matcherWithRule:@"/def"];
    expect(matcher).notTo.beNil();
    
    NSURL *url = URLWithPath(@"/def");
    FSRoutesMatchResult *result = [matcher match:url];
    expect(result).notTo.beNil();
    expect(result.match).to.equal(YES);
    expect(result.parameter).to.equal(@{});
}
    
- (void)test_ruleParameter_1 {
    FSRoutesMatcher *matcher = [FSRoutesMatcher matcherWithRule:@"/def/:id"];
    expect(matcher).notTo.beNil();

    NSURL *url = URLWithPath(@"/def/123");
    FSRoutesMatchResult *result = [matcher match:url];
    expect(result).notTo.beNil();
    expect(result.match).to.equal(YES);
    expect(result.parameter[@"id"]).to.equal(@"123");
}
    
- (void)test_ruleParameter_2 {
    FSRoutesMatcher *matcher = [FSRoutesMatcher matcherWithRule:@"/def/:id/:name"];
    expect(matcher).notTo.beNil();
    
    NSURL *url = URLWithPath(@"/def/123/456");
    FSRoutesMatchResult *result = [matcher match:url];
    expect(result).notTo.beNil();
    expect(result.match).to.equal(YES);
    expect(result.parameter[@"id"]).to.equal(@"123");
    expect(result.parameter[@"name"]).to.equal(@"456");
}

@end
