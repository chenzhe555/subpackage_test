//
//  RCTBridge+HHZLoadOtherJS.h
//  subpackage_project_test
//
//  Created by yunshan on 2019/3/15.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import <React/RCTBridge+Private.h>

NS_ASSUME_NONNULL_BEGIN

@interface RCTBridge (HHZLoadOtherJS)
-(void)executeSourceCode:(NSData *)sourceCode sync:(BOOL)sync;
@end

NS_ASSUME_NONNULL_END
