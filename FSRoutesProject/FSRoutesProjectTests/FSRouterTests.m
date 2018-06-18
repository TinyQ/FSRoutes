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
}

- (void)tearDown {
    [super tearDown];
}

- (void)test_initialization {
    expect(self.router).notTo.beNil();
    expect(self.router.routes).notTo.beNil();
    expect(self.router.rules).notTo.beNil();
    expect(self.router.handlers).notTo.beNil();
}

- (void)test_add_route {
    FSRouteItem *item = [[FSRouteItem alloc] init];
    item.introdution = @"test introdution";
    item.testURLs = @[@"https://github.com/TinyQ/FSRoutes"];
    item.rules = @[@"/TinyQ/FSRoutes"];
    [self.router addRoute:item handler:^BOOL(FSRouteHandle *handle) {
        
        return YES;
    }];
    expect(item).notTo.beNil();
    expect(self.router.routes).to.contain(item);
    expect(self.router.rules).to.contain(@"/TinyQ/FSRoutes");
}

- (void)test_can_route {
    FSRouteItem *item = [[FSRouteItem alloc] init];
    item.introdution = @"test introdution";
    item.testURLs = @[@"https://github.com/TinyQ/FSRoutes"];
    item.rules = @[@"/TinyQ/FSRoutes"];
    [self.router addRoute:item handler:^BOOL(FSRouteHandle *handle) {
        
        return YES;
    }];
    NSURL *URL = [NSURL URLWithString:@"https://github.com/TinyQ/FSRoutes"];
    expect([self.router canRoute:URL]).to.beTruthy();
    
    NSURL *URL2 = [NSURL URLWithString:@"https://gitlab.com/TinyQ/FSRoutes"];
    expect([self.router canRoute:URL2]).to.beTruthy();
    
    NSURL *URL3 = [NSURL URLWithString:@"https://gitlab.com/ABC/FSRoutes"];
    expect([self.router canRoute:URL3]).to.beFalsy();
}

@end
