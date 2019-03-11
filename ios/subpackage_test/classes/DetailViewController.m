//
//  DetailViewController.m
//  subpackage_test
//
//  Created by yunshan on 2019/3/11.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "DetailViewController.h"
#import <React/RCTRootView.h>
#import "JSBridgeManager.h"
#import "RCTBridge+LoadOtherJS.h"
#import <React/RCTBridge+Private.h>

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  self.view.backgroundColor = [UIColor redColor];
  [self loadDetailBundle];
}

-(void)loadDetailBundle
{
  NSError *error = nil;
  //获取detail Bundle文件
  NSData * detailBundleData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] URLForResource:@"detail.ios" withExtension:@"bundle"].path
                                             options:NSDataReadingMappedIfSafe
                                               error:&error];
  if (!error && ![JSBridgeManager shareManager].isHaveLoadDetail) {
    //加载eDetailbundle
    [[JSBridgeManager shareManager].bridge.batchedBridge executeSourceCode:detailBundleData sync:NO];
    [JSBridgeManager shareManager].isHaveLoadDetail = YES;
  }
  RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:[JSBridgeManager shareManager].bridge moduleName:@"subpackage_test" initialProperties:nil];
  self.view = rootView;
}

@end
