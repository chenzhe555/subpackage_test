//
//  HHZRNRouteManager.h
//  subpackage_project_test
//
//  Created by yunshan on 2019/3/15.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HHZRNRouteModel.h"
#import <React/RCTBridge.h>
#import "RCTBridge+HHZLoadOtherJS.h"
#import <React/RCTRootView.h>

//下载进度
typedef void (^ProgressHandler)(NSString * _Nonnull source, long loadNum, long totalNum);
//下载结果
typedef void (^CompletionHandler)(NSString * _Nonnull path, BOOL success, NSError * _Nullable error);

NS_ASSUME_NONNULL_BEGIN

@interface HHZRNRouteManager : NSObject
//桥接bridge
@property (nonatomic, strong) RCTBridge * bridge;

/**
 获取当前Manager实例
 */
+(instancetype)shareManager;


/**
 以配置文件启动
 */
-(void)startWithConfig:(NSArray<HHZRNRouteModel *> *)modelArray;


/**
 生成RCTView对象

 @param key 当前Key
 */
-(RCTRootView *)generateRCTViewWithModuleName:(NSString *)moduleName key:(NSString *)key;


/**
 下载Bundle的Zip包

 @param url Zip包下载地址
 */
-(void)downloadBundleZipFile:(NSString *)urlString processHandler:(ProgressHandler)processHandler completionHandler:(CompletionHandler)completionHandler;
@end

NS_ASSUME_NONNULL_END
