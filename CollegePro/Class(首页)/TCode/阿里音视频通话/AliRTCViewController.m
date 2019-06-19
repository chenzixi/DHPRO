//
//  AliRTCViewController.m
//  CollegePro
//
//  Created by jabraknight on 2019/6/12.
//  Copyright © 2019 jabrknight. All rights reserved.
//

#import "AliRTCViewController.h"
#import "AliRTCLiveViewController.h"
#import "SFHttpSessionReq.h"
#import "MessageTableViewCell.h"
#import "DataItem.h"
#import "GLActionSheet.h"

@interface AliRTCViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView  *tableView;
//数据源集合
@property(nonatomic,strong) NSMutableArray *datalistArray;
//取消数据源集合
@property(nonatomic,strong) NSMutableArray * selectList;
//拨打电话
@property(nonatomic,strong)UIButton *buttonCancel;

@property(nonatomic,copy) NSString *ID;
@property(nonatomic,copy) NSString *phone;

@end

@implementation AliRTCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"视频通话";
    self.datalistArray = [NSMutableArray array];
    self.selectList = [NSMutableArray array];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0 , 0, 0, 0));
    }];
    //拨打电话
    [self.view addSubview:self.buttonCancel];
    
    [self laodList];
   
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.selectList) {
        self.buttonCancel.hidden = YES;
        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0 , 0, 0, 0));
        }];
        [self.selectList removeAllObjects];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"选择" style:UIBarButtonItemStylePlain target:
                                                  self action:@selector(editCell)];
    }
}

- (void)editCell{
    [self.tableView setEditing:!_tableView.editing animated:YES];
    if (self.tableView.editing) {
        [self.navigationItem.rightBarButtonItem setTitle:[NSString stringWithFormat:@"确定(%lu/%lu)",(unsigned long)self.selectList.count,(unsigned long)self.datalistArray.count]];//cell可编辑状态右导航切换主题
        self.buttonCancel.hidden = NO;
        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0 , 0, 50, 0));
        }];
    }else{
        [self.navigationItem.rightBarButtonItem setTitle:[NSString stringWithFormat:@"确定(%lu/%lu)",(unsigned long)self.selectList.count,(unsigned long)self.datalistArray.count]];
        if (self.selectList.count>0) {
            //选中的用户信息
            NSMutableArray *array = [NSMutableArray array];
            [self.selectList enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop){
                DataItem *model = self.selectList[idx];
                [array addObject:@{@"ID":model.Id,@"phone":model.Phone,@"name":model.Name}];
            }];
            //操作提示
            [GLActionSheet showWithDataSource:@[@"视频通话",@"语音通话",@"取消"]
                                        title:@"你可以选择以下通话操作"
                                  selectIndex:2
                                completeBlock:^(NSInteger index) {
                                    NSLog(@"%ld",(long)index);
                                    //数据回调
                                    AliRTCLiveViewController *aliRTCLive = [[AliRTCLiveViewController alloc]init];
                                    aliRTCLive.arrPersioninfo = array;
                                    //取消选择 右按钮变为选择同时处于非编辑状态、隐藏取消按钮
                                    if (index==2) {
                                        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"选择" style:UIBarButtonItemStylePlain target:
                                                                                  self action:@selector(editCell)];
                                        self.tableView.editing = NO;
                                        self.buttonCancel.hidden = YES;
                                        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
                                            make.edges.mas_equalTo(UIEdgeInsetsMake(0 , 0, 0, 0));
                                        }];
                                        return ;
                                    }
                                    aliRTCLive.audioOnlyMode = index;
                                    //            aliRTCLive.manageModel = manageModel;
                                    pushVC(aliRTCLive);
                                }];
            
            
        }else if (self.selectList.count==0){
            [self.tableView setEditing:YES animated:NO];
            [MBProgressHUD showWarnMessage:@"请至少选择一个人"];
        }
    }
//

}
//取消选择
- (void)cancelStateSelected:(UIButton *)btn{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"选择" style:UIBarButtonItemStylePlain target:
                                              self action:@selector(editCell)];
    [self.tableView setEditing:NO animated:NO];
    self.buttonCancel.hidden = NO;
    [self.selectList removeAllObjects];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0 , 0, 0, 0));
    }];
}
- (void)laodList{
    __weak typeof(self) weakSelf = self;
    [[SFHttpSessionReq shareInstance]  POSTRequestWithUrl:@"http://testapi.iuoooo.com/jrtc.api/Jinher.AMP.JRTC.RealTime.svc/GetUserList" parameters:Nil resHander:^(NSDictionary * _Nullable resData) {
        BOOL IsSuccess = ([resData[@"Obj"] isEqualToString:@"200"]);
        
        if (IsSuccess) {
            NSArray *loginArr = resData[@"Data"];
//            DataItem*manageModel = [DataItem new];
//            [manageModel setValuesForKeysWithDictionary:loginArr];
//            [weakSelf.datalistArray addObject:manageModel];
   
            weakSelf.datalistArray = [DataItem mj_objectArrayWithKeyValuesArray:loginArr];
            UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithTitle:@"选择" style:UIBarButtonItemStylePlain target:
                                      self action:@selector(editCell)];
            self.navigationItem.rightBarButtonItem = item;

            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tableView reloadData];
            });
        }
    } resError:^(NSString * _Nullable error) {
        NSLog(@"==%@==",error);
    }];
}
#pragma mark - tableViewDelegate&DataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datalistArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *ID =@"MessageTableViewCell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ID];
//    }
    MessageTableViewCell *descriptioncell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MessageTableViewCell class])];
    DataItem*manageModel = self.datalistArray[indexPath.row];
    descriptioncell.manageModel = manageModel;
    return descriptioncell;
    
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.navigationItem.rightBarButtonItem.title rangeOfString:@"确定"].location !=NSNotFound) {
        if (self.selectList.count>=9) {
            [MBProgressHUD showWarnMessage:@"最多选择10人"];
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
        }
        else{
            [self.selectList addObject:self.datalistArray[indexPath.row]];//当选中时操作移除的数组增加选中转态数组里面的元素
        }
        [self.navigationItem.rightBarButtonItem setTitle:[NSString stringWithFormat:@"确定(%lu/%lu)",(unsigned long)self.selectList.count,(unsigned long)self.datalistArray.count]];
    }
    else
    {
        DataItem *model = self.datalistArray[indexPath.row];
        NSString *string = [NSString stringWithFormat:@"tel://%@",model.Phone];
        NSURL *url = [NSURL URLWithString:string];
        [[UIApplication sharedApplication] openURL:url];
    }
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.navigationItem.rightBarButtonItem.title rangeOfString:@"确定"].location !=NSNotFound) {
        [self.selectList removeObject:self.datalistArray[indexPath.row]];//非选中就移除
        [self.navigationItem.rightBarButtonItem setTitle:[NSString stringWithFormat:@"确定(%lu/%lu)",(unsigned long)self.selectList.count,(unsigned long)self.datalistArray.count]];
    }
}
- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = [UIColor redColor];
        _tableView.estimatedRowHeight = 150;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        [_tableView registerClass:[MessageTableViewCell class] forCellReuseIdentifier:NSStringFromClass([MessageTableViewCell class])];
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (UIButton *)buttonCancel{
    if (!_buttonCancel) {
        _buttonCancel = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonCancel setFrame:CGRectMake(0.0 ,DH_DeviceHeight-50 ,DH_DeviceWidth ,50.0)];
        [_buttonCancel setTitle:@"取消" forState:(UIControlStateNormal)];
        [_buttonCancel setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        _buttonCancel.backgroundColor = [UIColor colorWithRed:0.043 green:0.722 blue:0.729 alpha:1.000];
        [_buttonCancel addTarget:self action:@selector(cancelStateSelected:) forControlEvents:(UIControlEventTouchUpInside)];
        _buttonCancel.hidden = YES;
    }
    return _buttonCancel;

}
- (void)dealloc{
    [self.selectList removeAllObjects];
    
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
