//
//  LWMainViewController.m
//  LinWearKit_Demo
//
//  Created by LINWEAR on 2025-12-17.
//

#import "LWMainViewController.h"
#import "LWScanViewController.h"
#import "LWAnimationCmdModel.h"

@interface LWMainViewController () <LWDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIButton *titleView;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray <NSString *> *dataSource;

@end

static NSString *const LWMainCellID = @"UITableViewCell";

@implementation LWMainViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self reloadTitleView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 初始化SDK，注册委托代理
    [LinWearKit registerDelegate:self enableLog:YES];
    
    // 连接状态
    self.navigationItem.titleView = self.titleView;
    
    // 扫描/断开
    LWEAKSELF
    [self addRightBarButtonItem:@"扫描/断开" itemEvent:^{
        // 获取连接记录
        RLMDeviceModel *deviceModel = RLMDeviceModel.allObjects.lastObject;
        
        if (deviceModel) {
            // 断开蓝牙设备
            [LinWearKit disconnectDevice];
            // 删除设备记录
            [deviceModel deleteObject];
            // 刷新
            [weakSelf reloadTitleView];
        } else {
            // 扫描设备
            LWScanViewController *vc = [LWScanViewController new];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
    }];
    
    // 列表
    UITableView *tableView = [self mainTableView:self style:UITableViewStylePlain cellIds:@[LWMainCellID] headerFooterIds:nil];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    // 加载数据源
    [self loadDataSource];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.safeAreaInsets);
    }];
}

#pragma mark - 懒加载

- (UIButton *)titleView {
    if (!_titleView) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:UIImageMake(@"ble_not_connected") forState:UIControlStateNormal];
        [button setTitleColor:UIColor.systemRedColor forState:UIControlStateNormal];
        [button setImage:UIImageMake(@"ble_connecting") forState:UIControlStateHighlighted];
        [button setTitleColor:UIColor.systemBlueColor forState:UIControlStateHighlighted];
        [button setImage:UIImageMake(@"ble_connected") forState:UIControlStateSelected];
        [button setTitleColor:UIColor.systemGreenColor forState:UIControlStateSelected];
        button.titleLabel.font = LWFontBoldMake(18);
        button.userInteractionEnabled = NO;
        _titleView = button;
    }
    return _titleView;
}

#pragma mark - 刷新连接状态

- (void)reloadTitleView
{
    // 获取连接记录
    NSString *deviceName = [RLMDeviceModel.allObjects.lastObject deviceName];
    
    [self.titleView setTitle:IF_NULL(deviceName) ? @"无设备" : deviceName  forState:UIControlStateNormal];
    self.titleView.selected = [LinWearKit bleStatus] == LWBleStatusConnected;
    self.titleView.highlighted = [LinWearKit bleStatus] == LWBleStatusConnecting;
    
    [self.tableView reloadData];
}

#pragma mark - 加载数据源

- (void)loadDataSource
{
    self.dataSource = @[
        @"设置设备系统类型",
        @"设置设备系统时间",
        @"设置设备系统语言",
        @"设置设备系统音量",
        @"获取设备系统音量",
        @"设置设备屏幕亮度",
        @"获取设备屏幕亮度",
        @"绑定宠物",
        @"解绑宠物",
        @"获取宠物状态",
        @"设置宠物进化",
        @"设置宠物奖励",
        @"设置今天天气",
        @"设置小时天气",
        @"添加新动画",
        @"设置设备停止录音",
        @"设置车载模式",
        @"获取车载模式",
        @"设置离线语音授权码",
        @"设置节日动画",
        @"设置设备地区",
        @"设置AI对话语音情绪",
        @"请求星历文件更新🚀",
        @"请求固件更新🚀",
        @"请求资源diff更新🚀",
        @"设备AI语音播放控制",
        @"获取设备版本信息",
        @"设置KWS命令词开关状态",
        @"设置POI打卡地列表",
        @"设置勿扰模式",
        @"获取勿扰模式",
        @"设置设备A2DP连接",
        @"响应设备交互",
        @"调试模式命令「恢复宠物默认形象」",
        @"设置设备执行动画命令",
        @"删除设备文件或目录",
    ];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LWMainCellID forIndexPath:indexPath];
    if (indexPath.row < self.dataSource.count) {
        cell.textLabel.text = [NSString stringWithFormat:@"%ld. %@", indexPath.row+1, self.dataSource[indexPath.row]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = self.dataSource[indexPath.row];
    
    if ([title isEqualToString:@"设置设备系统类型"])
    {
        [LinWearKit setDeviceSystemTypeWithCallback:^(NSError * _Nullable error) {
            NSLog(@"设置设备系统类型 %@", error ? @"失败" : @"成功");
        }];
    }
    else if ([title isEqualToString:@"设置设备系统时间"])
    {
        [LinWearKit setDeviceSystemTimeWithCallback:^(NSError * _Nullable error) {
            NSLog(@"设置设备系统时间 %@", error ? @"失败" : @"成功");
        }];
    }
    else if ([title isEqualToString:@"设置设备系统语言"])
    {
        [LinWearKit setDeviceSystemLanguage:LWLanguageType_EN withCallback:^(NSError * _Nullable error) {
            NSLog(@"设置设备系统语言 %@", error ? @"失败" : @"成功");
        }];
    }
    else if ([title isEqualToString:@"设置设备系统音量"])
    {
        [LinWearKit setDeviceSystemVolume:12 withCallback:^(NSError * _Nullable error) {
            NSLog(@"设置设备系统音量 %@", error ? @"失败" : @"成功");
        }];
    }
    else if ([title isEqualToString:@"获取设备系统音量"])
    {
        [LinWearKit getDeviceSystemVolumeWithCallback:^(NSNumber * _Nullable number, NSError * _Nullable error) {
            NSLog(@"获取设备系统音量 %@ 音量:%@", error ? @"失败" : @"成功", number);
        }];
    }
    else if ([title isEqualToString:@"设置设备屏幕亮度"])
    {
        [LinWearKit setDeviceScreenBrightness:90 withCallback:^(NSError * _Nullable error) {
            NSLog(@"设置设备屏幕亮度 %@", error ? @"失败" : @"成功");
        }];
    }
    else if ([title isEqualToString:@"获取设备屏幕亮度"])
    {
        [LinWearKit getDeviceScreenBrightnessWithCallback:^(NSNumber * _Nullable number, NSError * _Nullable error) {
            NSLog(@"获取设备屏幕亮度 %@ 亮度:%@", error ? @"失败" : @"成功", number);
        }];
    }
    else if ([title isEqualToString:@"绑定宠物"])
    {
        [LinWearKit bindAipetWithIdentifier:LWBindAipetIdentifier_Test withCallback:^(NSNumber * _Nullable number, NSError * _Nullable error) {
            // 注意业务状态 number
            NSLog(@"绑定宠物 %@", error ? @"失败" : @"成功");
        }];
    }
    else if ([title isEqualToString:@"解绑宠物"])
    {
        [LinWearKit unbindAipetWithIdentifier:LWBindAipetIdentifier_Test withCallback:^(NSNumber * _Nullable number, NSError * _Nullable error) {
            // 注意业务状态 number
            NSLog(@"解绑宠物 %@", error ? @"失败" : @"成功");
        }];
    }
    else if ([title isEqualToString:@"获取宠物状态"])
    {
        [LinWearKit getAipetStatusWithCallback:^(LWAipetStatusModel * _Nullable object, NSError * _Nullable error) {
            NSLog(@"获取宠物状态 %@", error ? @"失败" : @"成功");
        }];
    }
    else if ([title isEqualToString:@"设置宠物进化"])
    {
        LWAipetEvolvedModel *model = [LWAipetEvolvedModel new];
        model.evolvedType = 1017;
        model.evolvedAudio = 31301;
        
        [LinWearKit setEvolvedAipetWithModel:model withCallback:^(NSNumber * _Nullable number, NSError * _Nullable error) {
            // 注意业务状态 number
            NSLog(@"设置宠物进化 %@", error ? @"失败" : @"成功");
        }];
    }
    else if ([title isEqualToString:@"设置宠物奖励"])
    {
        LWAipetRewardModel *model = [LWAipetRewardModel new];
        model.rewardType = 32202;
        model.totalProgress = 80;
        model.currentProgress = 90;
        
        [LinWearKit setAipetRewardWithModel:model withCallback:^(NSError * _Nullable error) {
            NSLog(@"设置宠物奖励 %@", error ? @"失败" : @"成功");
        }];
    }
    else if ([title isEqualToString:@"设置今天天气"])
    {
        LWTodayWeatherModel *model = [LWTodayWeatherModel new];
        model.foreground = 22202;
        model.background = 15108;
        
        [LinWearKit setTodayWeatherWithModel:model withCallback:^(NSNumber * _Nullable number, NSError * _Nullable error) {
            // 注意业务状态 number
            NSLog(@"设置今天天气 %@", error ? @"失败" : @"成功");
        }];
    }
    else if ([title isEqualToString:@"设置小时天气"])
    {
        time_t timeInterval = NSDate.date.timeIntervalSince1970;
        struct tm *cTime = localtime(&timeInterval);
        
        LWHourWeatherModel *model = [LWHourWeatherModel new];
        model.hour = cTime->tm_hour;
        model.weatherCode = 15106;
        
        [LinWearKit setHourWeatherWithLists:@[model] withCallback:^(NSNumber * _Nullable number, NSError * _Nullable error) {
            // 注意业务状态 number
            NSLog(@"设置小时天气 %@", error ? @"失败" : @"成功");
        }];
    }
    else if ([title isEqualToString:@"添加新动画"])
    {
        LWAnimationModel *model = [LWAnimationModel new];
        model.type = 11202;
        model.name = @"打哈欠";
        model.count = 5;
        model.point_x = 0;
        model.point_y = 0;
        model.size_w = 100;
        model.size_h = 100;
        model.is_scale = NO;
        model.is_multi_form = NO;
        model.is_play_sound = YES;
        
        [LinWearKit addNewAnimationWithModel:model withCallback:^(NSNumber * _Nullable number, NSError * _Nullable error) {
            // 注意业务状态 number
            NSLog(@"添加新动画 %@", error ? @"失败" : @"成功");
        }];
    }
    else if ([title isEqualToString:@"设置设备停止录音"])
    {
        [LinWearKit setDeviceStopAudioRecordingWithCallback:^(NSError * _Nullable error) {
            NSLog(@"设置设备停止录音 %@", error ? @"失败" : @"成功");
        }];
    }
    else if ([title isEqualToString:@"设置车载模式"])
    {
        static BOOL carMode;
        carMode = !carMode;
        [LinWearKit setCarMode:carMode withCallback:^(NSNumber * _Nullable number, NSError * _Nullable error) {
            // 注意业务状态 number
            NSLog(@"设置车载模式 %@", error ? @"失败" : @"成功");
        }];
    }
    else if ([title isEqualToString:@"获取车载模式"])
    {
        [LinWearKit getCarModeWithCallback:^(NSNumber * _Nullable number, NSError * _Nullable error) {
            // 注意业务状态 number
            NSLog(@"获取车载模式 %@ 模式:%@", error ? @"失败" : @"成功", number.intValue==1 ? @"开启" : @"关闭");
        }];
    }
    else if ([title isEqualToString:@"设置离线语音授权码"])
    {
        // 获取连接记录
        RLMDeviceModel *deviceModel = RLMDeviceModel.allObjects.lastObject;
        
        // 请求离线语音授权码
        [LinWearKit requestOfflineVoiceAuthCodeWithMac:deviceModel.deviceMac withLang:@"en" withCallback:^(NSString * _Nullable object, NSError * _Nullable error) {
            
            NSLog(@"请求离线语音授权码 %@", error ? @"失败" : @"成功");
            
            if (IF_NULL(object)) return;
            
            [LinWearKit setOfflineVoiceAuthorizeCode:object withCallback:^(NSNumber * _Nullable number, NSError * _Nullable error) {
                // 注意业务状态 number
                NSLog(@"设置离线语音授权码 %@", error ? @"失败" : @"成功");
            }];
        }];
    }
    else if ([title isEqualToString:@"设置节日动画"])
    {
        LWHolidayAnimationModel *model = [LWHolidayAnimationModel new];
        model.month = 12;
        model.day = 25;
        model.foreground = 22305;
        model.background = 15210;
        model.background_detail = 81111;
        model.interactive_audio = 0;
        
        [LinWearKit setHolidayAnimationWithModel:model withCallback:^(NSNumber * _Nullable number, NSError * _Nullable error) {
            // 注意业务状态 number
            NSLog(@"设置节日动画 %@", error ? @"失败" : @"成功");
        }];
    }
    else if ([title isEqualToString:@"设置设备地区"])
    {
        [LinWearKit setDeviceAreaCode:81304 withCallback:^(NSNumber * _Nullable number, NSError * _Nullable error) {
            // 注意业务状态 number
            NSLog(@"设置设备地区 %@", error ? @"失败" : @"成功");
        }];
    }
    else if ([title isEqualToString:@"设置AI对话语音情绪"])
    {
        [LinWearKit setAiDialogueVoiceMoodCode:42102 withCallback:^(NSNumber * _Nullable number, NSError * _Nullable error) {
            // 注意业务状态 number
            NSLog(@"设置AI对话语音情绪 %@", error ? @"失败" : @"成功");
        }];
    }
    else if ([title isEqualToString:@"请求星历文件更新🚀"])
    {
        // 请求星历文件
        [LinWearKit requestEphemerisFileWithCallback:^(NSString * _Nullable object, NSError * _Nullable error) {
            NSLog(@"请求星历文件 %@", error ? @"失败" : @"成功");
            
            if (!error)
            {
                LWUploadFileNegotModel *negotModel = [LWUploadFileNegotModel new];
                negotModel.targetPath = @"/user/xgnss/"; // 星历目标路径
                negotModel.filePath = object;
                //negotModel.fileName = 不设置，SDK默认filePath.lastPathComponent
                negotModel.fileType = LWFileType_Ephemeris; // 星历
                negotModel.fileOperateType = LWFileOperateType_Upload;
                negotModel.resuming = YES;
                
                // 文件上传
                [self fileUploadWithNegotis:@[negotModel] index:0];
            }
        }];
    }
    else if ([title isEqualToString:@"请求固件更新🚀"])
    {
        // demo演示，从本地选择固件；实际业务中，这个应该从服务器中获取...
        [self documentPickerWithFirmware:^(NSArray<NSURL *> * _Nonnull documents)
         {
            NSString *filePath = documents.firstObject.path;
                        
            LWUploadFileNegotModel *negotModel = [LWUploadFileNegotModel new];
            negotModel.targetPath = @"/user/"; // 固件目标路径
            negotModel.filePath = filePath;
            //negotModel.fileName = 无需设置，固件特殊，SDK内部已固定名称
            negotModel.fileType = LWFileType_Firmware; // 固件
            negotModel.fileOperateType = LWFileOperateType_Upload;
            negotModel.resuming = YES;
            
            // 文件上传
            [self fileUploadWithNegotis:@[negotModel] index:0];
        }];
    }
    else if ([title isEqualToString:@"请求资源diff更新🚀"])
    {
        // demo演示，从本地选择资源；实际业务中，这个应该从服务器中获取...
        [self documentPickerWithResource:^(NSArray<NSURL *> * _Nonnull documents)
         {
            NSUInteger allCount = documents.count;
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"资源目标路径" message:@"资源文件diff更新目标路径" preferredStyle:UIAlertControllerStyleAlert];
            
            for (NSURL *document in documents)
            {
                [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                    textField.placeholder = [NSString stringWithFormat:@"%@ 资源目标路径", document.path.lastPathComponent];
                }];
            }

            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil]];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                //总大小
                NSUInteger allSize = 0;
                NSMutableArray <LWUploadFileNegotModel *> *negotis = NSMutableArray.array;
                
                for (int index = 0; index < allCount; index++) {
                    NSURL *document = documents[index];
                    UITextField *textField = alertController.textFields[index];
                    
                    if (IF_NULL(textField.text)) break;
                    
                    allSize += [NSData dataWithContentsOfURL:document].length;
                    
                    LWUploadFileNegotModel *negotModel = [LWUploadFileNegotModel new];
                    negotModel.targetPath = textField.text; // 资源目标路径
                    negotModel.filePath = document.path;
                    //negotModel.fileName = demo这里演示就不设置了，选择文件前请先确保文件命名正确，在实际应用中如果无法保证命令，则需要额外设置
                    negotModel.fileType = LWFileType_Default; // 资源
                    negotModel.fileOperateType = LWFileOperateType_Overwrite; // demo这里演示固定用了「覆盖」实际应按diff不同而使用相应的类型
                    negotModel.resuming = YES;
                    
                    [negotis addObject:negotModel];
                }
                
                if (negotis.count != allCount) {
                    [LWHUD showText:@"请输入对应文件目标路径"];
                    return;
                }

                
                // 1.资源文件diff更新协商
                [LinWearKit resourceFileDiffUpdateNegotiationWithSize:allSize withCallback:^(NSNumber * _Nullable number, NSError * _Nullable error) {
                    // 注意业务状态 number
                    NSLog(@"资源文件diff更新协商 %@", error ? @"失败" : @"成功");
                    
                    if (number.integerValue == 0 && !error) // 可以更新
                    {
                        // 文件上传
                        [self fileUploadWithNegotis:negotis.copy index:0];
                    }
                }];
                
            }]];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }];
    }
    else if ([title isEqualToString:@"设备AI语音播放控制"])
    {
        [LinWearKit deviceAiVoicePlaybackControl:YES withCallback:^(NSError * _Nullable error) {
            NSLog(@"设备AI语音播放控制 %@", error ? @"失败" : @"成功");
        }];
    }
    else if ([title isEqualToString:@"获取设备版本信息"])
    {
        [LinWearKit getDeviceVersionInfoWithCallback:^(LWDeviceVersionModel * _Nullable object, NSError * _Nullable error) {
            NSLog(@"获取设备版本信息 %@", error ? @"失败" : @"成功");
        }];
    }
    else if ([title isEqualToString:@"设置KWS命令词开关状态"])
    {
        [LinWearKit setKWSCommandWord:71101 status:YES withCallback:^(NSNumber * _Nullable number, NSError * _Nullable error) {
            // 注意业务状态 number
            NSLog(@"设置KWS命令词开关状态 %@", error ? @"失败" : @"成功");
        }];
    }
    else if ([title isEqualToString:@"设置POI打卡地列表"])
    {
        // POI打卡地数据
        NSArray *dataArr = @[
            @{@"type" : @(81401), @"name" : @"咖啡店", @"animation" : @(31101)},
            @{@"type" : @(81402), @"name" : @"轻食简餐店", @"animation" : @(31102)},
            @{@"type" : @(81403), @"name" : @"甜品店", @"animation" : @(31103)},
            @{@"type" : @(81404), @"name" : @"汉堡快餐店", @"animation" : @(31104)},
            @{@"type" : @(81409), @"name" : @"西餐厅", @"animation" : @(31109)},
            @{@"type" : @(81410), @"name" : @"日料店", @"animation" : @(31110)},
            @{@"type" : @(81408), @"name" : @"亚洲面馆", @"animation" : @(31108)},
            @{@"type" : @(81413), @"name" : @"电影院", @"animation" : @(31201)},
            @{@"type" : @(81417), @"name" : @"健身房", @"animation" : @(31301)},
            @{@"type" : @(81429), @"name" : @"服饰店", @"animation" : @(31605)}
        ];
        
        NSMutableArray<LWCheckInSpotsModel *> *spotsList = [NSMutableArray array];
        for (NSInteger i = 0; i < dataArr.count; i++) {
            NSDictionary *dict = dataArr[i];
            LWCheckInSpotsModel *spotsModel = [LWCheckInSpotsModel new];
            spotsModel.type = [dict[@"type"] integerValue];
            spotsModel.name = dict[@"name"];
            spotsModel.animation = [dict[@"animation"] integerValue];
            spotsModel.index = i;
            [spotsList addObject:spotsModel];
        }
        
        // 一次性发送全部10个POI
        [LinWearKit setPoiCheckInSpotsWithList:spotsList withCallback:^(NSError * _Nullable error) {
            // 打卡地更新 参@link devicePoiCheckInSpotsUpdateWithModel:
            NSLog(@"设置POI打卡地列表 %@", error ? @"失败" : @"成功");
        }];
    }
    else if ([title isEqualToString:@"设置勿扰模式"])
    {
        [LinWearKit setDoNotDisturbMode:NO withCallback:^(NSNumber * _Nullable number, NSError * _Nullable error) {
            // 注意业务状态 number
            NSLog(@"设置勿扰模式 %@", error ? @"失败" : @"成功");
        }];
    }
    else if ([title isEqualToString:@"获取勿扰模式"])
    {
        [LinWearKit getDoNotDisturbModeWithCallback:^(NSNumber * _Nullable number, NSError * _Nullable error) {
            // 注意业务状态 number
            NSLog(@"获取勿扰模式 %@", error ? @"失败" : @"成功");
        }];
    }
    else if ([title isEqualToString:@"设置设备A2DP连接"])
    {
        [LinWearKit setDeviceA2DPConnection:YES withCallback:^(NSNumber * _Nullable number, NSError * _Nullable error) {
            // 注意业务状态 number
            NSLog(@"设置设备A2DP连接 %@", error ? @"失败" : @"成功");
        }];
    }
    else if ([title isEqualToString:@"响应设备交互"])
    {
        [LinWearKit respondDeviceInteraction:0 withCallback:^(NSError * _Nullable error) {
            NSLog(@"响应设备交互 %@", error ? @"失败" : @"成功");
        }];
    }
    else if ([title isEqualToString:@"调试模式命令「恢复宠物默认形象」"])
    {
        [LinWearKit debugModeWithCommand:LWDebugModeCommand_RestorePet withCallback:^(NSError * _Nullable error) {
            NSLog(@"调试模式命令「恢复宠物默认形象」 %@", error ? @"失败" : @"成功");
        }];
    }
    else if ([title isEqualToString:@"设置设备执行动画命令"])
    {
        NSArray <LWAnimationCmdModel *> *cmds = @[
            [[LWAnimationCmdModel alloc] initWithKws:@"aimon sit down" command:LWAnimationCommand_0],
            [[LWAnimationCmdModel alloc] initWithKws:@"aimon down / lie down" command:LWAnimationCommand_1],
            [[LWAnimationCmdModel alloc] initWithKws:@"aimon good / good boy / good girl" command:LWAnimationCommand_2],
            [[LWAnimationCmdModel alloc] initWithKws:@"aimon shake hand / aimon paw" command:LWAnimationCommand_3],
            [[LWAnimationCmdModel alloc] initWithKws:@"aimon jump" command:LWAnimationCommand_4],
            [[LWAnimationCmdModel alloc] initWithKws:@"aimon say hi" command:LWAnimationCommand_5],
            [[LWAnimationCmdModel alloc] initWithKws:@"aimon kiss" command:LWAnimationCommand_6],
            [[LWAnimationCmdModel alloc] initWithKws:@"aimon wag tail" command:LWAnimationCommand_7],
        ];
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"动画命令" message:@"设置设备执行动画命令" preferredStyle:UIAlertControllerStyleActionSheet];
        // 命令
        for (LWAnimationCmdModel *model in cmds)
        {
            [alertController addAction:[UIAlertAction actionWithTitle:model.kws style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [LinWearKit setDeviceExecutionAnimationWithCommand:model.command withCallback:^(NSError * _Nullable error) {
                    NSLog(@"设置设备执行动画命令 %@", error ? @"失败" : @"成功");
                }];
                
            }]];
        }
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else if ([title isEqualToString:@"删除设备文件或目录"])
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"绝对路径" message:@"删除设备文件或目录" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = @"绝对路径";
        }];

        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UITextField *textField = alertController.textFields.firstObject;
            NSString *filePath = textField.text;
            if (IF_NULL(filePath)) return;
            
            [LinWearKit deleteDeviceFilesOrDirectories:filePath withCallback:^(NSNumber * _Nullable number, NSError * _Nullable error) {
                // 注意业务状态 number
                NSLog(@"删除设备文件或目录 %@", error ? @"失败" : @"成功");
            }];
            
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
}


#pragma mark - 文件上传

/// 文件上传
- (void)fileUploadWithNegotis:(NSArray <LWUploadFileNegotModel *> *)negotis index:(NSInteger)index
{
    if (index >= negotis.count) return;
    
    LWUploadFileNegotModel *negotModel = negotis[index];
    
    // 1.文件上传协商
    [LinWearKit fileUploadNegotiationWithModel:negotModel withCallback:^(LWUploadNegotModel * _Nullable object, NSError * _Nullable error) {
        NSLog(@"📃文件上传协商 %@", error ? @"失败" : @"成功");
        
        if (!error && object.negotType == LWFileUploadNegotType_Allow)
        {
            LWUploadFileModel *uploadModel = [LWUploadFileModel new];
            uploadModel.filePath = negotModel.filePath;
            uploadModel.fileOffset = object.fileOffset;
            
            // 2.开始上传
            [LinWearKit startUploadingFilesWithModel:uploadModel withProgressCallback:^(int progress) {
                
                [LWHUD showProgress:(CGFloat)progress/100.0 text:[NSString stringWithFormat:@"%d%%", progress]];
                
            } withCallback:^(NSError * _Nullable error) {
                
                [LWHUD showText:[NSString stringWithFormat:@"📃文件上传 %@", error ? @"失败" : @"成功"]];
                if (!error) {
                    [self fileUploadWithNegotis:negotis index:index+1]; // 继续检查上传
                }
            }];
        }
    }];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - LWDelegate

/// SDK日志
- (void)outputSdkLog:(NSString *)logText
{
    NSLog(@"%@", logText);
}


/// 中心蓝牙状态
- (void)centralBluetoothStatus:(CBManagerState)status
{
    if (status == CBManagerStatePoweredOn) // 蓝牙已打开
    {
        // 获取连接记录
        RLMDeviceModel *deviceModel = RLMDeviceModel.allObjects.lastObject;
        // 有连接记录，主动连接一下
        if (!IF_NULL(deviceModel.deviceUUID))
        {
            [LinWearKit connectingDevice:deviceModel.deviceUUID timeout:0];
        }
    }
}


/// 发现外围设备
- (void)discoverPeripheral:(LWPeripheralModel * _Nonnull)peripheralModel
{
    [NSNotificationCenter.defaultCenter postNotificationName:LWDiscoverPeripheralNotify object:peripheralModel];
}


/// BLE连接状态
- (void)bleConnectionStatus:(LWBleStatus)status error:(NSError * _Nullable)error
{
    [self reloadTitleView];
    
    if (status == LWBleStatusConnecting) { // 连接中（初始化中）
        
        [LWHUD showLoading:@"连接中（初始化中）"];
    }
    else if (status == LWBleStatusConnected) { // 已连接（初始化完成）所有命令交互在此回调后才可进行✅
        
        [LWHUD showText:@"连接成功✅"];
        
        // 初始化成功，交互举例...
        
        // 1. 绑定宠物
        [LinWearKit bindAipetWithIdentifier:LWBindAipetIdentifier_Test withCallback:^(NSNumber * _Nullable number, NSError * _Nullable error) {
            // 注意业务状态 number
            NSLog(@"绑定宠物 %@", error ? @"失败" : @"成功");
        }];
        
        // 2. 设置设备系统类型，⚠️重要：每次连接成功都必须设置
        [LinWearKit setDeviceSystemTypeWithCallback:^(NSError * _Nullable error) {
            NSLog(@"设置设备系统类型 %@", error ? @"失败" : @"成功");
        }];
        
        // 3. 设置设备系统时间
        [LinWearKit setDeviceSystemTimeWithCallback:^(NSError * _Nullable error) {
            NSLog(@"设置设备系统时间 %@", error ? @"失败" : @"成功");
        }];
        
        // 其他业务交互...
    }
    else if (status == LWBleStatusDisconnect) { // 连接断开
        
        [LWHUD showText:@"连接断开"];
    }
    else if (status == LWBleStatusConnectionFailed) { // 连接失败
        
        [LWHUD showText:[NSString stringWithFormat:@"连接失败❌\n%@", error.localizedDescription]];
    }
    
    [NSNotificationCenter.defaultCenter postNotificationName:LWConnectionStatusNotify object:@(status)];
}


/// 设备开始录音
- (void)deviceDidStartAudioRecordingWithFunction:(LWAudioFunction)function
{
    NSLog(@"设备开始录音 功能 %lu", function);
}


/// 设备录音数据
- (void)deviceAudioRecordingWithAudioData:(NSData *)audioData audioFormat:(LWAudioFormat)audioFormat
{
    NSLog(@"音频数据 %ld", audioData.length);
}


/// 设备结束录音
- (void)deviceDidEndAudioRecording
{
    NSLog(@"设备结束录音");
}


/// 宠物状态更新
- (void)aiPetStatusUpdateWithModel:(LWAipetStatusModel *)aipetStatusModel
{
    NSLog(@"宠物状态更新 %@", aipetStatusModel);
}


/// 撸宠动作更新
- (void)aiPetActionUpdateWithModel:(LWAipetActionModel *)aipetActionModel
{
    NSLog(@"撸宠动作更新 %@", aipetActionModel);
}


/// 设备开始POI打卡
- (void)deviceDidStartPoiCheckInWithTimeOut:(NSInteger)timeOut type:(LWPoiCheckInType)type device:(NSString *)device
{
    NSLog(@"设备开始POI打卡 超时时间 %ld", timeOut);
}


/// 设备POI打卡更新
- (void)devicePoiCheckInUpdateWithModel:(LWPoiCheckInModel *)poiCheckInModel
{
    NSLog(@"设备POI打卡更新 %@", poiCheckInModel);
}

/// 设备资源缺失
- (void)deviceResourcesMissingWithModel:(LWDeviceResourcesModel *)resourcesModel
{
    NSLog(@"设备资源缺失 %@", resourcesModel);
}

/// 设备发起交互
- (void)deviceInitiatesInteractionWithType:(LWInteractionType)interactionType latitude:(double)latitude longitude:(double)longitude
{
    NSLog(@"设备发起交互 %lu", interactionType);
}

/// 设备POI打卡地更新
- (void)devicePoiCheckInSpotsUpdateWithModel:(LWCheckInSpotsResultModel *)checkInSpotsModel
{
    NSLog(@"设备POI打卡地更新 %@", checkInSpotsModel);
}

/// 设备取消AI对话
- (void)deviceCancelsAiDialogue
{
    NSLog(@"设备取消AI对话");
}

/// 设备BR连接配对状态
- (void)deviceBrConnectionPairingStatus:(LWPairingStatus)status
{
    NSLog(@"设备BR连接配对状态 %lu", status);
}

@end
