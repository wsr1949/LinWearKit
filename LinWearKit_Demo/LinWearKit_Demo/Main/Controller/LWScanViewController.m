//
//  LWScanViewController.m
//  LinWearKit_Demo
//
//  Created by LINWEAR on 2025-12-17.
//

#import "LWScanViewController.h"
#import "LWScanCell.h"

@interface LWScanViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray <LWPeripheralModel *> *dataSource;

@property (nonatomic, strong) LWPeripheralModel *peripheralModel;

@end

static NSString *const LWScanCellID = @"LWScanCell";

@implementation LWScanViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if ([LinWearKit centralManagerState] == CBManagerStatePoweredOn) {
        // 开始扫描
        [LinWearKit startScanning];
    }
    else {
        [LWHUD showText:@"蓝牙未开启"];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    // 停止扫描
    [LinWearKit stopScanning];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"扫描";
    
    UITableView *tableView = [self mainTableView:self style:UITableViewStylePlain cellIds:@[LWScanCellID] headerFooterIds:nil];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    self.dataSource = NSMutableArray.array;
    
    /// 发现外围设备通知
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(discoverPeripheralNotification:) name:LWDiscoverPeripheralNotify object:nil];
    
    /// 设备连接状态通知
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(deviceConnectionResultNotification:) name:LWConnectionStatusNotify object:nil];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.safeAreaInsets);
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

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LWScanCell *cell = [tableView dequeueReusableCellWithIdentifier:LWScanCellID forIndexPath:indexPath];
    if (indexPath.row < self.dataSource.count) {
        LWPeripheralModel *peripheralModel = self.dataSource[indexPath.row];
        cell.titLabel.text = peripheralModel.deviceName;
        cell.detLabel.text = [NSString stringWithFormat:@"%@「适配号%@」", peripheralModel.deviceMac, peripheralModel.deviceMode];
        cell.rssiLabel.text = @(peripheralModel.RSSI).stringValue;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LWPeripheralModel *peripheralModel = self.dataSource[indexPath.row];
    [LWHUD showLoading:nil];
    self.peripheralModel = peripheralModel;
    
    [LWHUD showLoading:[NSString stringWithFormat:@"正在连接「%@」", peripheralModel.deviceName]];
    // 连接设备
    [LinWearKit connectingDevice:peripheralModel.deviceUUID timeout:60];
}


/// 发现外围设备通知
- (void)discoverPeripheralNotification:(NSNotification *)notification
{
    LWPeripheralModel *peripheralModel = (LWPeripheralModel *)notification.object;
    
    // 检查重复
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@", K_Predicate_Properky(LWPeripheralModel, deviceMac), peripheralModel.deviceMac];
    
    if (![self.dataSource filteredArrayUsingPredicate:predicate].count) {
        
        [self.dataSource addObject:peripheralModel];
        
        // 排序，信号由大到小
        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"RSSI" ascending:NO];
        [self.dataSource sortUsingDescriptors:@[sortDescriptor]];
        
        [self.tableView reloadData];
    }
}

/// 设备连接状态通知
- (void)deviceConnectionResultNotification:(NSNotification *)notification
{
    LWBleStatus status = (LWBleStatus)[notification.object integerValue];
    
    if (status == LWBleStatusConnected) // 已连接（初始化完成）
    {
        // 保存连接记录
        RLMDeviceModel *deviceModel = RLMDeviceModel.new;
        deviceModel.deviceName = self.peripheralModel.deviceName;
        deviceModel.deviceMac = self.peripheralModel.deviceMac;
        deviceModel.deviceMode = self.peripheralModel.deviceMode;
        deviceModel.deviceUUID = self.peripheralModel.peripheral.identifier.UUIDString;
        [deviceModel saveOrUpdateObject];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

@end
