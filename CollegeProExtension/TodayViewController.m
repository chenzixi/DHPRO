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

@interface TodayViewController () <NCWidgetProviding,  UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 将小组件的展现模式设置为可展开
    if (@available(iOS 10.0, *)) {
        self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeExpanded;
    }
    
    [self.view addSubview:self.tableView];
    
    // Do any additional setup after loading the view.
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier];
    }
    
    NSArray *titleArr = @[@"帮助",@"反馈",@"个人信息",@"客服",@"设置"];
    cell.imageView.image = [UIImage imageNamed:titleArr[indexPath.row]];
    cell.textLabel.text = titleArr[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[TodayTableHeaderView alloc]init];
    
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *path = [NSString stringWithFormat:@"TodayExtension://%zd",indexPath.row];
    NSURL *url = [NSURL URLWithString:path];
    [self openContainingAPPWithURL:url];
}

- (void)openContainingAPPWithURL:(NSURL *)URL {
    [self.extensionContext openURL:URL completionHandler:nil];
}

#pragma mark - NCWidgetProviding
-(void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize  API_AVAILABLE(ios(10.0)){
    if (activeDisplayMode == NCWidgetDisplayModeExpanded) {
        // 设置展开的新高度
        self.preferredContentSize = CGSizeMake(0, 335.0);
    }else{
        self.preferredContentSize = maxSize;
    }
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData
    
    completionHandler(NCUpdateResultNewData);
}

#pragma mark - lazy load
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

@end
