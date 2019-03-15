/**
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "AppDelegate.h"
#import "RootViewController.h"
#import <React/RCTBridge.h>



@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  RootViewController * root = [[RootViewController alloc] initWithNibName:@"RootViewController" bundle:nil];

  
  [[RCTBridge alloc] initWithBundleURL:[[NSBundle mainBundle] URLForResource:@"common" withExtension:@"bundle"] moduleProvider:nil launchOptions:nil];

  
  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  self.window.rootViewController = root;
  [self.window makeKeyAndVisible];
  return YES;
}

@end
