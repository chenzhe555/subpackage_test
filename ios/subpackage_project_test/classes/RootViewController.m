//
//  RootViewController.m
//  subpackage_project_test
//
//  Created by yunshan on 2019/3/15.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "RootViewController.h"
#import "HHZRNRouteManager.h"

#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  [self loadBundles];
}

-(void)loadBundles
{
  NSMutableArray * mutaArr = [NSMutableArray array];
  HHZRNRouteModel * model1 = [[HHZRNRouteModel alloc] init];
  model1.key = @"COMMON_KEY";
  model1.isPreLoad = YES;
  model1.valueModel.bundleName = @"common";
  
  HHZRNRouteModel * model2 = [[HHZRNRouteModel alloc] init];
  model2.key = @"GOODS_DETAIL";
  model2.isPreLoad = NO;
  model2.valueModel.bundleName = @"goodsdetail";
  
  HHZRNRouteModel * model3 = [[HHZRNRouteModel alloc] init];
  model3.key = @"ORDER_LIST";
  model3.isPreLoad = NO;
  model3.valueModel.bundleName = @"orderlist";
  
  HHZRNRouteModel * model4 = [[HHZRNRouteModel alloc] init];
  model4.key = @"SECKILL";
  model4.isPreLoad = NO;
  model4.valueModel.bundleName = @"seckill";
  
  [mutaArr addObject:model1];
  [mutaArr addObject:model2];
  [mutaArr addObject:model3];
  [mutaArr addObject:model4];
  
  [[HHZRNRouteManager shareManager] startWithConfig:mutaArr];
}

-(void)loadRCTView
{
  NSError *error = nil;
  //获取detail Bundle文件
  NSData * detailBundleData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] URLForResource:@"allbusiness.ios" withExtension:@"bundle"].path
                                                     options:NSDataReadingMappedIfSafe
                                                       error:&error];
  [[HHZRNRouteManager shareManager].bridge.batchedBridge executeSourceCode:detailBundleData sync:NO];
  RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:[HHZRNRouteManager shareManager].bridge moduleName:@"subpackage_project_test" initialProperties:nil];
  self.view = rootView;
  
}

- (IBAction)goToGoodsDetailAction:(id)sender {
}

- (IBAction)goToOrderListAction:(id)sender {
}

- (IBAction)goToSeckillAction:(id)sender {
}


@end
