//
//  LWBaseNavigationController.m
//  LinWearKit_Demo
//
//  Created by LINWEAR on 2025-12-17.
//

#import "LWBaseNavigationController.h"

@interface LWBaseNavigationController ()

@end

@implementation LWBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSDictionary *attributes = @{
        NSForegroundColorAttributeName: LWColorText,
        NSFontAttributeName: LWFontBoldMake(18)
    };
    
    [self.navigationBar setTitleTextAttributes:attributes];
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
