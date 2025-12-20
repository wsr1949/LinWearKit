//
//  LWBaseViewController.m
//  LinWearKit_Demo
//
//  Created by LINWEAR on 2025-12-17.
//

#import "LWBaseViewController.h"

@interface LWBaseViewController ()

@end

@implementation LWBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = LWColorBackground;
}

/// 添加单个导航栏右按钮
- (void)addRightBarButtonItem:(NSString *)title itemEvent:(void (^)(void))itemEvent
{
    UIAction *action = [UIAction actionWithTitle:title image:nil identifier:nil handler:^(__kindof UIAction * _Nonnull action) {
        GCD_MAIN_QUEUE(^{
            if (itemEvent) itemEvent();
        });
    }];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom primaryAction:action];
    [button setTitleColor:LWColorTheme forState:UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

/// 安全区域
- (UIEdgeInsets)safeAreaInsets
{
    return self.view.safeAreaInsets;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
