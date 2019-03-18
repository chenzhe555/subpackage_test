//
//  HHZRNRouteManager.m
//  subpackage_project_test
//
//  Created by yunshan on 2019/3/15.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "HHZRNRouteManager.h"
#import <SSZipArchive/SSZipArchive.h>

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
      NSURL * bundleURL = [self getBundleURL:bundleName];
      if (bundleURL) {
        NSData * otherBundleData = [NSData dataWithContentsOfFile:bundleURL.path
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
  }
  return [[RCTRootView alloc] initWithBridge:self.bridge moduleName:bundleName initialProperties:nil];
}

-(void)downloadBundleZipFile:(NSString *)urlString callback:(DownZipCallback)callback
{
  [callback copy];
  NSURLSessionDownloadTask * task = [[NSURLSession sharedSession] downloadTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    if (!error) {
      [SSZipArchive unzipFileAtPath:location.path toDestination:[self getSaveBundleUrlString] progressHandler:^(NSString * _Nonnull entry, unz_file_info zipInfo, long entryNumber, long total) {
        NSLog(@"entry:%@", entry);
        NSLog(@"zipInfo:%d", zipInfo);
        NSLog(@"entryNumber:%ld", entryNumber);
        NSLog(@"total:%ld", total);

      } completionHandler:^(NSString * _Nonnull path, BOOL succeeded, NSError * _Nullable error) {
        if (succeeded && !error) {
          callback(1);
        } else {
          callback(2);
        }
      }];
    }
  }];
  [task resume];
}

#pragma mark 辅助方法
-(NSURL *)getBundleURL:(NSString *)bundleName
{
  NSURL * bundleURL = [[NSBundle mainBundle] URLForResource:bundleName withExtension:@"bundle"];
  if (!bundleURL) {
    //如果项目里没有，从沙盒中再获取
    NSString * documentBundleUrlString = [[self getSaveBundleUrlString] stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@.bundle", bundleName]];
    if ([[NSFileManager defaultManager] fileExistsAtPath:documentBundleUrlString]) {
      bundleURL = [NSURL URLWithString:documentBundleUrlString];
    }
  }
  return bundleURL;
}


/**
 获取bundle文件存储路径
 */
-(NSString *)getSaveBundleUrlString
{
  return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}
@end
