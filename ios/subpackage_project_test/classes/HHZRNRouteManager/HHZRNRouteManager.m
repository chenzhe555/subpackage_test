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
    [[NSNotificationCenter defaultCenter] addObserver:manager selector:@selector(loadCommonJS2:) name:RCTJavaScriptDidFailToLoadNotification object:nil];
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


-(void)loadCommonJS2:(NSNotification *)noti
{
  NSLog(@"notiii : \n %@",noti.object);
}


/**
 第一次加载Bundle文件
 */
-(void)loadFirstBundle:(HHZRNRouteModel *)model
{
  self.bridge = [[RCTBridge alloc] initWithDelegate:self launchOptions:nil];
  self.isLoadOnce = YES;
}

/**
 加载更多的Bundle文件
 */
-(void)loadMoreBundle
{
  
}

-(NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
  return [[NSBundle mainBundle] URLForResource:@"common" withExtension:@"bundle"];
}
@end
