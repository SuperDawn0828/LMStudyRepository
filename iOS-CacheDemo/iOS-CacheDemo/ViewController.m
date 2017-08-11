//
//  ViewController.m
//  iOS-CacheDemo
//
//  Created by 黎明 on 2017/8/3.
//  Copyright © 2017年 黎明. All rights reserved.
//

#import "ViewController.h"
#import "LMCommand.h"
#import "LMImageListTypeModel.h"
#import "ImageTypeViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) LMImageListTypeModel *imageTypeListModel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubview];
    [self requestImageTypeList];
}

- (void)setupSubview
{
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.imageTypeListModel.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LMImageTypeModel *typeModel = self.imageTypeListModel.list[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = typeModel.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LMImageTypeModel *typeModel = self.imageTypeListModel.list[indexPath.row];
    ImageTypeViewController *imageTypeVC = [[ImageTypeViewController alloc] init];
    imageTypeVC.typeModel = typeModel;
    [self.navigationController pushViewController:imageTypeVC animated:true];
}

- (void)requestImageTypeList
{
    __weak typeof(self) weakSelf = self;
    [LMCommand imageType:^(NSString * _Nullable object, NSError * _Nullable error) {
        if (error != nil) {
            
        } else {
            if ([object isKindOfClass:[NSDictionary class]]) {
                weakSelf.imageTypeListModel = [LMImageListTypeModel mj_objectWithKeyValues:object];
                [weakSelf.tableView reloadData];
            }
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
