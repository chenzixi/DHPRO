//
//  TodayViewController.m
//  CollegeProExtension
//
//  Created by jabraknight on 2019/5/27.
//  Copyright © 2019 jabrknight. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import <sys/sysctl.h>
#import <mach/mach.h>

#import "TodayTableHeaderView.h"
#import "TodayItemCell.h"
#import "TodayItemModel.h"
@interface TodayViewController () <NCWidgetProviding,  UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property(nonatomic,strong) UILabel *textLabel;

@property(nonatomic,strong) UILabel *labelTitleName;
@property(nonatomic,strong) UILabel *labelUsedMemory;

@property(nonatomic,strong) UIView *subView;
@property (nonatomic, strong) NSMutableArray * dataArray;

@property (nonatomic, assign) unsigned long long fileSystemSize;
@property (nonatomic, assign) unsigned long long freeSize;
@property (nonatomic, assign) unsigned long long usedSize;
@property (nonatomic, assign) double usedRate;
@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     <?xml version="1.0" encoding="UTF-8"?>
     <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
     <plist version="1.0">
     <string>TodayViewController</string>NSExtensionMainStoryboard
     </plist>

     */
   

    // 将小组件的展现模式设置为可展开 ”展开120=40 headview330=110  4x209+539=458“
    if (@available(iOS 10.0, *)) {
        self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeExpanded;
    }
    //设置extension的size
//    self.preferredContentSize = CGSizeMake(0, 80);
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.labelUsedMemory];
    [self.view addSubview:self.labelTitleName];

    _labelTitleName.text = [NSString stringWithFormat:@"%llu,%f,%llu,%llu",self.fileSystemSize,self.usedRate,self.freeSize,self.usedSize];
    
    _labelUsedMemory.text = [NSString stringWithFormat:@"%f 设备的总容量和可用容量:%@,%@ 可用容量：%f,当前任务所占用的内存%fMB",[self getTotalDiskSpace],[TodayViewController totalDiskSpace],[TodayViewController freeDiskSpace],[self availableMemory],[self usedMemory]];
    
    
    NSString *urlString = [NSString stringWithFormat:@"CollegeProTodayExtensionDemo://set/markCode=%@&code=%@&yesclose=%@&stockName=%@",@"10200",@"200",@"YES",[@"高晨阳" stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    NSArray * array = @[
                        @{@"icon":@"bangzhu",
                          @"handerUrl":@"CollegeProTodayExtensionDemo://message",
                          @"title":@"消息"},
                        @{@"icon":@"fankui",
                          @"handerUrl":@"CollegeProTodayExtensionDemo://adress",
                          @"title":@"地址管理"},
                        @{@"icon":@"gerenxinxi",
                          @"handerUrl":@"CollegeProTodayExtensionDemo://work",
                          @"title":@"工作"},
                        @{@"icon":@"kefu",
                          @"handerUrl":@"CollegeProTodayExtensionDemo://my",
                          @"title":@"我的"},
                        @{@"icon":@"shezhi",
                          @"handerUrl":urlString,
                          @"title":@"设置"},

                        ];
    for (NSDictionary * dic in  array) {
        TodayItemModel*manageModel = [TodayItemModel new];
        manageModel.icon =dic[@"icon"];
        manageModel.handerUrl = dic[@"handerUrl"];
        manageModel.titlename = dic[@"title"];
        [self.dataArray addObject:manageModel];
    }
//    [self.tableView reloadData];
    
    
//    NSUserDefaults *userDefault = [[NSUserDefaults alloc] initWithSuiteName:@"group.com.dhtest.CollegePro.CollegeProExtension"];
//    [userDefault setObject:@"tips" forKey:@"com.dhtest.CollegePro.CollegeProExtension.tips"];
//
//    NSUserDefaults *userDefault = [[NSUserDefaults alloc] initWithSuiteName:@"group.DonYau.today"];
//    NSString *textStr = [userDefault valueForKey:@"com.dhtest.CollegePro.CollegeProExtension.tips"];
//    _textLabel.text = textStr;
}
#pragma mark- lazy
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //点击跳转到APP
    [self.extensionContext openURL:[NSURL URLWithString:@"CollegeProTodayExtensionDemo://enterApp"] completionHandler:nil];
}
#pragma mark - UITableViewDataSource
//有多少个section需要加载到table里
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TodayItemCell *descriptioncell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TodayItemCell class])];
    if (descriptioncell == nil) {
        descriptioncell = [[TodayItemCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:NSStringFromClass([TodayItemCell class])];
    }
    TodayItemModel*manageModel = self.dataArray[indexPath.row];
    descriptioncell.model = manageModel;
    return descriptioncell;
}

#pragma mark - UITableViewDelegate
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//
//    UIView *headerView = [[TodayTableHeaderView alloc]init];
//
//    return headerView;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 110;
//}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TodayItemModel * model = self.dataArray[indexPath.row];
    [self.extensionContext openURL:[NSURL URLWithString:model.handerUrl] completionHandler:nil];

//    NSString *path = [NSString stringWithFormat:@"CollegeProExtension://%zd",indexPath.row];
//    NSURL *url = [NSURL URLWithString:path];
//    [self openContainingAPPWithURL:url];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}
- (void)openContainingAPPWithURL:(NSURL *)URL {
    [self.extensionContext openURL:URL completionHandler:nil];
}

#pragma mark - NCWidgetProviding
-(void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize  API_AVAILABLE(ios(10.0)){
    if (activeDisplayMode == NCWidgetDisplayModeExpanded) {
        // 设置展开的新高度
        self.preferredContentSize = CGSizeMake(0, 5*70.0+110.0);
    }else{
        self.preferredContentSize = maxSize;//系统默认的高度为110
    }
}
//数据更新时调用的方法 系统会定期更新扩展
- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData
    
    // 取出数据
    NSString * myData = [[[NSUserDefaults alloc] initWithSuiteName:@"group.com.dhtest.CollegePro.CollegeProExtension"] valueForKey:@"myShareData"];
    NSLog(@"草泥马的数据呢？ %@",myData);
    [self.tableView reloadData];
    completionHandler(NCUpdateResultNewData);
    
}
//设置扩展UI边距
- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets{
    return UIEdgeInsetsZero;
}
- (void)updateSizes
{
    // Retrieve the dictionary with the attributes from NSFileManager
    NSDictionary *dict = [[NSFileManager defaultManager]
                          attributesOfFileSystemForPath:NSHomeDirectory()
                          error:nil];
    
    // Set the values
    self.fileSystemSize = [[dict valueForKey:NSFileSystemSize]
                           unsignedLongLongValue];
    self.freeSize       = [[dict valueForKey:NSFileSystemFreeSize]
                           unsignedLongLongValue];
    self.usedSize       = self.fileSystemSize - self.freeSize;
}
- (void)updateInterface
{
//    double rate = self.usedRate; // retrieve the cached value
//    self.percentLabel.text = [NSString stringWithFormat:@"%.1f%%", (rate * 100)];
//    self.barView.progress = rate;
}
-(void)updateDetailsLabel
{
    NSByteCountFormatter *formatter = [[NSByteCountFormatter alloc] init];
    [formatter setCountStyle:NSByteCountFormatterCountStyleFile];
    
//    self.detailsLabel.text =
//    [NSString stringWithFormat:@"Used:\t%@\nFree:\t%@\nTotal:\t%@",
//     [formatter stringFromByteCount:self.usedSize],
//     [formatter stringFromByteCount:self.freeSize],
//     [formatter stringFromByteCount:self.fileSystemSize]];
}
//硬盘容量

- (float)getTotalDiskSpace

{
    
    float totalSpace;
    
    NSError * error;
    
    NSDictionary * infoDic = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[self getHomeDirectory] error: &error];
    
    if (infoDic) {
        
        NSNumber * fileSystemSizeInBytes = [infoDic objectForKey: NSFileSystemSize];
        
        totalSpace = [fileSystemSizeInBytes floatValue]/1024.0f/1024.0f/1024.0f;
        
        return totalSpace;
        
    } else {
        
        NSLog(@"Error Obtaining System Memory Info: Domain = %@, Code = %ld", [error domain], (long)[error code]);
        
        return 0;
        
    }
    
}

- (NSString *)getHomeDirectory

{
    
    NSString * homePath = NSHomeDirectory();
    
    return homePath;
    
}

/*
 
 如何获取设备的总容量和可用容量
 
 */

+ (NSNumber *)totalDiskSpace

{
    
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    
    return [fattributes objectForKey:NSFileSystemSize];
    
}

+ (NSNumber *)freeDiskSpace

{
    
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    
    return [fattributes objectForKey:NSFileSystemFreeSize];
    
}
// 获取当前设备可用内存(单位：MB）

- (double)availableMemory

{
    
    vm_statistics_data_t vmStats;
    
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    
    kern_return_t kernReturn = host_statistics(mach_host_self(),
                                               
                                               HOST_VM_INFO,
                                               
                                               (host_info_t)&vmStats,
                                               
                                               &infoCount);
    
    
    
    if (kernReturn != KERN_SUCCESS) {
        
        return NSNotFound;
        
    }
    return ((vm_page_size *vmStats.free_count) / 1024.0) / 1024.0;
    
}

// 获取当前任务所占用的内存（单位：MB）

- (double)usedMemory

{
    
    task_basic_info_data_t taskInfo;
    
    mach_msg_type_number_t infoCount = TASK_BASIC_INFO_COUNT;
    
    kern_return_t kernReturn = task_info(mach_task_self(),
                                         
                                         TASK_BASIC_INFO,
                                         
                                         (task_info_t)&taskInfo,
                                         
                                         &infoCount);
    
    
    
    if (kernReturn != KERN_SUCCESS
        
        ) {
        
        return NSNotFound;
        
    }
    
    
    
    return taskInfo.resident_size / 1024.0 / 1024.0;
    
}
#pragma mark - lazy load
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.frame = CGRectMake(0, 110, self.view.frame.size.width-8, 70*5);
        _tableView.dataSource = self;
        _tableView.delegate = self;
//        _tableView.estimatedRowHeight = 70;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        [_tableView registerClass:[TodayItemCell class] forCellReuseIdentifier:NSStringFromClass([TodayItemCell class])];
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}
- (UILabel *)labelTitleName {
    if (!_labelTitleName) {
        _labelTitleName = [[UILabel alloc]init];
        _labelTitleName.frame  =CGRectMake(10, 5, self.view.frame.size.width-10, 15);
        _labelTitleName.numberOfLines = 0;
        _labelTitleName.text = @"精灵球";
    }
    return _labelTitleName;
}
- (UILabel *)labelUsedMemory {
    if (!_labelUsedMemory) {
        _labelUsedMemory = [[UILabel alloc]init];
        _labelUsedMemory.frame  =CGRectMake(10, 20, self.view.frame.size.width-10, 60);
        _labelUsedMemory.text = @"精灵球";
        [_labelUsedMemory sizeToFit];
        _labelUsedMemory.numberOfLines = 5;
    }
    return _labelUsedMemory;
}
@end
