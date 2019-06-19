//
//  TodayViewController.m
//  CollegeProExtension
//
//  Created by jabraknight on 2019/5/27.
//  Copyright © 2019 jabrknight. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

#import "TodayTableHeaderView.h"
#import "TodayItemCell.h"
#import "TodayItemModel.h"
@interface TodayViewController () <NCWidgetProviding,  UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property(nonatomic,strong) UILabel *textLabel;
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
   

    // 将小组件的展现模式设置为可展开
    if (@available(iOS 10.0, *)) {
        self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeExpanded;
    }
    //设置extension的size
//    self.preferredContentSize = CGSizeMake(0, 80);
    [self.view addSubview:self.tableView];
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
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[TodayTableHeaderView alloc]init];
    
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 110;
}
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
#pragma mark - lazy load
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.estimatedRowHeight = 150;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        [_tableView registerClass:[TodayItemCell class] forCellReuseIdentifier:NSStringFromClass([TodayItemCell class])];
        _tableView.tableFooterView = [UIView new];

    }
    return _tableView;
}

@end
