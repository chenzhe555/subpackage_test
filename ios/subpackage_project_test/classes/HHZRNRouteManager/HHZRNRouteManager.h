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

NS_ASSUME_NONNULL_BEGIN

@interface HHZRNRouteManager : NSObject<RCTBridgeDelegate>
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
@end

NS_ASSUME_NONNULL_END
