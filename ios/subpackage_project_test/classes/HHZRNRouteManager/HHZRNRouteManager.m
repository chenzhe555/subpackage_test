//
//  HHZRNRouteManager.m
//  subpackage_project_test
//
//  Created by yunshan on 2019/3/15.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "HHZRNRouteManager.h"

@interface HHZRNRouteManager()
//加载Bundle模型数组
@property (nonatomic, strong) NSArray<HHZRNRouteModel *> * modelArray;
//是否已初始化加载过bridge
@property (nonatomic, assign) BOOL isLoadOnce;
@end

@implementation HHZRNRouteManager
+(instancetype)shareManager
{
  static HHZRNRouteManager * manager = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    manager = [HHZRNRouteManager new];
    [[NSNotificationCenter defaultCenter] addObserver:manager selector:@selector(loadCommonJS:) name:RCTJavaScriptDidLoadNotification object:nil];
  });
  return manager;
}

-(void)startWithConfig:(NSArray<HHZRNRouteModel *> *)modelArray
{
  self.modelArray = modelArray;
  for (HHZRNRouteModel * model in self.modelArray) {
    if (model.isPreLoad) {
      if (self.isLoadOnce) {
        
      } else {
        [self loadFirstBundle:model];
      }
    }
  }
}

-(void)loadCommonJS:(NSNotification *)noti
{
  NSLog(@"notiii : \n %@",noti.object);
}

/**
 第一次加载Bundle文件
 */
-(void)loadFirstBundle:(HHZRNRouteModel *)model
{
  self.bridge = [[RCTBridge alloc] initWithBundleURL:[[NSBundle mainBundle] URLForResource:model.valueModel.bundleName withExtension:@"bundle"] moduleProvider:nil launchOptions:nil];
  self.isLoadOnce = YES;
}

/**
 加载更多的Bundle文件
 */
-(void)loadMoreBundle
{
  
}

-(RCTRootView *)generateRCTViewWithModuleName:(NSString *)moduleName key:(NSString *)key
{
  NSString * bundleName = nil;
  for (HHZRNRouteModel * model in self.modelArray) {
    if ([model.key isEqualToString:key]) {
      bundleName = model.valueModel.bundleName;
      NSError *error = nil;
      //获取detail Bundle文件
      NSData * otherBundleData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] URLForResource:bundleName withExtension:@"bundle"].path
                                                         options:NSDataReadingMappedIfSafe
                                                           error:&error];
      if (!error && !model.valueModel.isHaveLoad) {
        //加载eDetailbundle
        [self.bridge.batchedBridge executeSourceCode:otherBundleData sync:NO];
        model.valueModel.isHaveLoad = YES;
        break;
      }
    }
  }
  return [[RCTRootView alloc] initWithBridge:self.bridge moduleName:bundleName initialProperties:nil];
}
@end
