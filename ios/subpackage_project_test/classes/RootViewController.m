//
//  RootViewController.m
//  subpackage_project_test
//
//  Created by yunshan on 2019/3/15.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "RootViewController.h"
#import "HHZRNRouteManager.h"
#import "RNViewController.h"
#import <HHZAlert/HHZToastView.h>

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  [self loadBundles];
  [self downloadBundle];
}

-(void)loadBundles
{
  NSMutableArray * mutaArr = [NSMutableArray array];
  HHZRNRouteModel * model1 = [[HHZRNRouteModel alloc] init];
  model1.key = @"COMMON_KEY";
  model1.isPreLoad = YES;
  model1.valueModel.bundleName = @"common";
  
  HHZRNRouteModel * model2 = [[HHZRNRouteModel alloc] init];
  model2.key = @"GOODS_DETAIL_KEY";
  model2.isPreLoad = NO;
  model2.valueModel.bundleName = @"goodsdetail";
  
  HHZRNRouteModel * model3 = [[HHZRNRouteModel alloc] init];
  model3.key = @"ORDER_LIST_KEY";
  model3.isPreLoad = NO;
  model3.valueModel.bundleName = @"orderlist";
  
  HHZRNRouteModel * model4 = [[HHZRNRouteModel alloc] init];
  model4.key = @"SECKILL_KEY";
  model4.isPreLoad = NO;
  model4.valueModel.bundleName = @"seckill";
  
  [mutaArr addObject:model1];
  [mutaArr addObject:model2];
  [mutaArr addObject:model3];
  [mutaArr addObject:model4];
  
  [[HHZRNRouteManager shareManager] startWithConfig:mutaArr];
}

-(void)downloadBundle
{
  [[HHZRNRouteManager shareManager] downloadBundleZipFile:@"http://localhost/xy3.zip" processHandler:^(NSString * _Nonnull source, long loadNum, long totalNum) {
    
  } completionHandler:^(NSString * _Nonnull path, BOOL success, NSError * _Nullable error) {
    if (success && !error) {
      dispatch_async(dispatch_get_main_queue(), ^{
        [[HHZToastView shareManager] showToastInCenter:@"下载成功"];
      });
    }
  }];
}


- (IBAction)goToGoodsDetailAction:(id)sender {
  RNViewController * vc = [[RNViewController alloc] init];
  vc.key = @"GOODS_DETAIL_KEY";
  vc.moduleName = @"goodsdetail";
  [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)goToOrderListAction:(id)sender {
  RNViewController * vc = [[RNViewController alloc] init];
  vc.key = @"ORDER_LIST_KEY";
  vc.moduleName = @"orderlist";
  [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)goToSeckillAction:(id)sender {
  RNViewController * vc = [[RNViewController alloc] init];
  vc.key = @"SECKILL_KEY";
  vc.moduleName = @"seckill";
  [self.navigationController pushViewController:vc animated:YES];
}


@end
