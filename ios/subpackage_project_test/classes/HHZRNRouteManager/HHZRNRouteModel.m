//
//  HHZRNRouteModel.m
//  subpackage_project_test
//
//  Created by yunshan on 2019/3/15.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "HHZRNRouteModel.h"

@implementation HHZRNRouteValueModel

@end

@implementation HHZRNRouteModel
- (instancetype)init
{
  self = [super init];
  if (self) {
    self.valueModel = [[HHZRNRouteValueModel alloc] init];
  }
  return self;
}
@end
