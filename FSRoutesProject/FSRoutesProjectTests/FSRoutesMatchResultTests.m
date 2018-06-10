//
//  FSRoutesMatchResultTests.m
//  FSRoutesProjectTests
//
//  Created by qfu on 2018/6/10.
//  Copyright © 2018 qfu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Expecta/Expecta.h>
#import <FSRoutes/FSRoutes.h>

@interface FSRoutesMatchResultTests : XCTestCase

@end

@implementation FSRoutesMatchResultTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)test_initialization {
    FSRoutesMatchResult *result = [[FSRoutesMatchResult alloc] init];
    expect(result).toNot.beNil();
    expect(result.match).to.equal(NO);
    expect(result.parameter).to.beNil();
    expect(result.description).toNot.beNil();
}

@end
