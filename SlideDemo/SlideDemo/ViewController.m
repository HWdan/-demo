//
//  ViewController.m
//  滑动demo
//
//  Created by mobilewise_mac_01 on 16/2/19.
//  Copyright © 2016年 com.cjt. All rights reserved.
//

#import "ViewController.h"
#import "SlideCollectionView.h"
#import "SlideView.h"
@interface ViewController ()<SlideCollectionViewDelegate,SlideViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //CollectionView
    self.view.backgroundColor = [UIColor whiteColor];
    SlideCollectionView *slide = [[SlideCollectionView alloc] init];
    slide.pageNumber = 6;
    slide.titles = @[@"设备信息0",@"应用管理1",@"内容管理2",@"配置策略3",@"应用商店4",@"安全浏览器5",@"安全扫描6",@"看看看7",@"应用商店8",@"安全浏览器9"];
    slide.images = @[@"icon_phone",@"icon_app",@"icon_file",@"icon_strategy",@"icon_appstore",@"icon_bowser",@"icon_bowser",@"icon_bowser",@"icon_appstore",@"icon_bowser"];
    slide.frame = CGRectMake(0, 30, self.view.bounds.size.width, 280);
    [slide createViewWithFrame:slide.frame];
    slide.slideCollectionViewDelegate = self;
    [self.view addSubview:slide];
    
    //ScrollView
    SlideView *slideView = [[SlideView alloc] init];
    slideView.pageNumber = 6;
    slideView.titles = @[@"设备信息0",@"应用管理1",@"内容管理2",@"配置策略3",@"应用商店4",@"安全浏览器5",@"安全扫描6",@"看看看7",@"应用商店8",@"安全浏览器9"];
    slideView.images = @[@"icon_phone",@"icon_app",@"icon_file",@"icon_strategy",@"icon_appstore",@"icon_bowser",@"icon_bowser",@"icon_bowser",@"icon_appstore",@"icon_bowser"];
    slideView.frame = CGRectMake(0, 320, self.view.bounds.size.width, 280);
    [slideView createViewWithFrame:slideView.frame];
    slideView.slideViewDelegate = self;
    [self.view addSubview:slideView];
}

- (void)slideCollectionView:(SlideCollectionView *)slideCollectionView didSelectAtIndex:(NSInteger)index {
    NSLog(@"SlideCollectionView选择：%ld",(long)index);
}

- (void)SlideView:(SlideView *)slideView didSelectAtIndex:(NSInteger)index {
    NSLog(@"SlideView选择：%ld",(long)index);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
