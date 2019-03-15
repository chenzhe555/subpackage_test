//
//  HHZRNRouteModel.h
//  subpackage_project_test
//
//  Created by yunshan on 2019/3/15.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HHZRNRouteValueModel : NSObject
//bundle的名称
@property (nonatomic, copy) NSString * bundleName;
@property (nonatomic, assign) BOOL isHaveLoad;
@end

@interface HHZRNRouteModel : NSObject
//当前Route下Bundle对应的Key
@property (nonatomic, copy) NSString * key;
//是否预先加载
@property (nonatomic, assign) BOOL isPreLoad;
//key对应下的Value值
@property (nonatomic, strong) HHZRNRouteValueModel * valueModel;
@end

NS_ASSUME_NONNULL_END
