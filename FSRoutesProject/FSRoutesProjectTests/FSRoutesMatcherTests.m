//
//  FSRoutesMatcherTests.m
//  FSRoutesProjectTests
//
//  Created by qfu on 24/09/2017.
//  Copyright © 2017 qfu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Expecta/Expecta.h>
#import <FSRoutes/FSRoutesMatcher.h>

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
    expect(matcher).notTo.beNil();
    
    matcher = [FSRoutesMatcher matcherWithRule:@""];
    expect(matcher).to.beNil();
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
