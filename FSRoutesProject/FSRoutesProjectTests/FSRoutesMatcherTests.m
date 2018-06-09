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

- (void)test_when_a_url_not_matches_a_route {
    FSRoutesMatcher *matcher = [FSRoutesMatcher matcherWithRule:@"/def"];
    expect(matcher).notTo.beNil();
    
    NSURL *url = URLWithPath(@"/abc");
    FSRoutesMatchResult *result = [matcher match:url];
    expect(result).notTo.beNil();
    expect(result.match).to.equal(NO);
    expect(result.parameter).to.equal(nil);
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

- (void)test_when_a_url_not_matches_a_route_with_1_parameter {
    FSRoutesMatcher *matcher = [FSRoutesMatcher matcherWithRule:@"/def/:id"];
    expect(matcher).notTo.beNil();
    
    NSURL *url = URLWithPath(@"/abc/123");
    FSRoutesMatchResult *result = [matcher match:url];
    expect(result).notTo.beNil();
    expect(result.match).to.equal(NO);
    expect(result.parameter).to.equal(nil);
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

- (void)test_wildcard_route {
    FSRoutesMatcher *matcher = [FSRoutesMatcher matcherWithRule:@".*"];
    NSURL *url = URLWithPath(@"/table/book/abc123/1418931000");
    NSURL *url2 = URLWithPath(@"/abc123");
    FSRoutesMatchResult *result = [matcher match:url];
    expect(result).notTo.beNil();
    expect(result.match).to.equal(YES);
    expect(result.parameter).to.equal(@{});
    
    FSRoutesMatchResult *result2 = [matcher match:url2];
    expect(result2).notTo.beNil();
    expect(result.match).to.equal(YES);
    expect(result2.parameter).to.equal(@{});
}

- (void)test_wildcard_to_route_parameters {
    FSRoutesMatcher *matcher = [FSRoutesMatcher matcherWithRule:@"/table/:path(.*)"];
    NSURL *url = URLWithPath(@"/table/some/path/which/should/be/in/route/parameters");
    FSRoutesMatchResult *result = [matcher match:url];
    expect(result).notTo.beNil();
    expect(result.match).to.equal(YES);
    expect(result.parameter).to.equal(@{@"path": @"some/path/which/should/be/in/route/parameters"});
}

- (void)test_matches_urls_with_commas {
    FSRoutesMatcher *matcher = [FSRoutesMatcher matcherWithRule:@"TenDay/:path"];
    NSURL *url = [NSURL URLWithString:@"twcweather://TenDay/33.89,-84.46?aw_campaign=com.weather.TWC.TWCWidget"];
    FSRoutesMatchResult *result = [matcher match:url];
    expect(result).notTo.beNil();
    expect(result.match).to.equal(YES);
    expect(result.parameter).to.equal(@{@"path": @"33.89,-84.46"});
}

- (void)test_matches_when_a_url_matches_a_parameterized_regex_route {
    FSRoutesMatcher *matcher = [FSRoutesMatcher matcherWithRule:@"/path/:name([a-zA-Z]+)/:id([0-9]+)"];
    NSURL *url = [NSURL URLWithString:@"/path/qfu/109"];
    FSRoutesMatchResult *result = [matcher match:url];
    expect(result).notTo.beNil();
    expect(result.match).to.equal(YES);
    expect(result.parameter).to.equal(@{@"name": @"qfu",
                                        @"id": @"109" });
}

- (void)test_some_named_groups_to_be_expressed_with_regex_and_not_others {
    FSRoutesMatcher *matcher = [FSRoutesMatcher matcherWithRule:@"/table/:table([a-zA-Z]+)/[a-z]+/:other([a-z]+)/:thing"];
    NSURL *url = [NSURL URLWithString:@"/table/anytable/anychair/another/anything"];
    FSRoutesMatchResult *result = [matcher match:url];
    expect(result).notTo.beNil();
    expect(result.match).to.equal(YES);
    expect(result.parameter).to.equal(@{@"table": @"anytable",
                                        @"other": @"another",
                                        @"thing": @"anything" });
}

- (void)test_when_the_url_path_does_not_match_regex_table_parameter {
    FSRoutesMatcher *matcher = [FSRoutesMatcher matcherWithRule:@"/table/:table([a-zA-Z]+)/:id([0-9])"];
    NSURL *url = [NSURL URLWithString:@"/table/table_name/109"];
    FSRoutesMatchResult *result = [matcher match:url];
    expect(result).notTo.beNil();
    expect(result.match).to.equal(NO);
    expect(result.parameter).to.equal(nil);
}

- (void)test_when_the_url_path_does_not_match_regex_id_parameter {
    FSRoutesMatcher *matcher = [FSRoutesMatcher matcherWithRule:@"/table/:table([a-zA-Z]+)/:id([0-9])"];
    NSURL *url = [NSURL URLWithString:@"/table/tableName/1a9"];
    FSRoutesMatchResult *result = [matcher match:url];
    expect(result).notTo.beNil();
    expect(result.match).to.equal(NO);
    expect(result.parameter).to.equal(nil);
}

- (void)test_does_not_match_partial_strings {
    FSRoutesMatcher *matcher = [FSRoutesMatcher matcherWithRule:@"me"];
    NSURL *url = [NSURL URLWithString:@"home"];
    FSRoutesMatchResult *result = [matcher match:url];
    expect(result).notTo.beNil();
    expect(result.match).to.equal(NO);
    expect(result.parameter).to.equal(nil);
}

- (void)test_matches_just_a_host_as_a_named_parameter {
    FSRoutesMatcher *matcher = [FSRoutesMatcher matcherWithRule:@":host"];
    NSURL *url = [NSURL URLWithString:@"scheme://myrandomhost?param1=value1&param2=value2"];
    FSRoutesMatchResult *result = [matcher match:url];
    expect(result).notTo.beNil();
    expect(result.match).to.equal(YES);
    expect(result.parameter[@"host"]).to.equal(@"myrandomhost");
}

- (void)test_allows_any_scheme_if_not_specified_in_the_route {
    NSURL *url1 = [NSURL URLWithString:@"derp://dpl.io/say/hello"];
    NSURL *url2 = [NSURL URLWithString:@"foo://dpl.io/say/hello"];
    
    FSRoutesMatcher *matcher = [FSRoutesMatcher matcherWithRule:@"/say/hello"];
    FSRoutesMatchResult *result1 = [matcher match:url1];
    expect(result1).notTo.beNil();
    expect(result1.match).to.equal(YES);
    
    FSRoutesMatchResult *result2 = [matcher match:url2];
    expect(result2).notTo.beNil();
    expect(result2.match).to.equal(YES);
}

- (void)test_matches_a_url_with_a_scheme_specific_route {
    NSURL *url1 = [NSURL URLWithString:@"derp://dpl.io/say/hello"];
    NSURL *url2 = [NSURL URLWithString:@"foo://dpl.io/say/hello"];
    
    FSRoutesMatcher *matcher = [FSRoutesMatcher matcherWithRule:@"derp://(.*)/say/hello"];
    FSRoutesMatchResult *result1 = [matcher match:url1];
    expect(result1).notTo.beNil();
    expect(result1.match).to.equal(YES);
    
    FSRoutesMatchResult *result2 = [matcher match:url2];
    expect(result2).notTo.beNil();
    expect(result2.match).to.equal(NO);
}

@end
