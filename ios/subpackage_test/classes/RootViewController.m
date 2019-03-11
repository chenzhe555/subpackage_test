//
//  RootViewController.m
//  subpackage_test
//
//  Created by yunshan on 2019/3/11.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "RootViewController.h"
#import "DetailViewController.h"
#import "JSBridgeManager.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  [[JSBridgeManager shareManager] start];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)pushDetailVC:(id)sender {
  DetailViewController * vc = [[DetailViewController alloc] init];
  [self.navigationController pushViewController:vc animated:YES];
}

@end
