//
//  ImageListViewController.m
//  iOS-CacheDemo
//
//  Created by 黎明 on 2017/8/3.
//  Copyright © 2017年 黎明. All rights reserved.
//

#import "ImageListViewController.h"
#import "LMCommand.h"
#import "UIImageView+Cache.h"
#import "LMImageListModel.h"
#import "LMImageTableViewCell.h"

@interface ImageListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *imageListArray;

@property (nonatomic, strong) LMImageListModel *imageListModel;

@end

@implementation ImageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.imageListArray = [NSMutableArray arrayWithCapacity:0];
    
    [self setupSubViews];
    [self requestImageList];
}

- (void)setupSubViews
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.imageListArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    LMImageContentMolde *imageContentModel = self.imageListArray[section];
    return imageContentModel.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LMImageContentMolde *imageContentModel = self.imageListArray[indexPath.section];
    LMImageModel *imageModel = imageContentModel.list[indexPath.row];
    
    LMImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[LMImageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    [cell.fullImageView imageCacheWithURL:[NSURL URLWithString:imageModel.big]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = width * 2.0 / 3.0;
    return height;
}

- (void)requestImageList
{
    __weak typeof(self) weakSelf = self;
    [LMCommand searchImage:self.imageCodeModel.id page:1 completionHandler:^(id  _Nullable object, NSError * _Nullable error) {
        if (error != nil) {
            
        } else {
            weakSelf.imageListModel = [LMImageListModel mj_objectWithKeyValues:object];
            [weakSelf.imageListArray addObjectsFromArray:weakSelf.imageListModel.pagebean.contentlist];
            [weakSelf.tableView reloadData];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
