//
//  SlideCollectionView.m
//  滑动demo
//
//  Created by mobilewise_mac_01 on 16/2/23.
//  Copyright © 2016年 com.cjt. All rights reserved.
//

#import "SlideCollectionView.h"
#define IMGEWIDTH 39.0
#define ViewToScrollViewDistance 23.0
#define DistanceSpace 15.0
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface HDCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel     *label;
@end

@implementation HDCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        const CGFloat factor = ScreenHeight / 667.0;;
        self.backgroundColor = [UIColor whiteColor];
        _imageView = [[UIImageView alloc] init];
        _label = [[UILabel alloc] init];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = [UIColor blackColor];
        _label.font = [UIFont systemFontOfSize:15.0 *factor];
        self.imageView.frame = CGRectMake((frame.size.width - IMGEWIDTH * factor) / 2, ViewToScrollViewDistance * factor, IMGEWIDTH * factor, IMGEWIDTH * factor);
        self.label.frame = CGRectMake(0, IMGEWIDTH * factor + (ViewToScrollViewDistance + DistanceSpace) * factor, frame.size.width, DistanceSpace * factor);
        [self addSubview:self.imageView];
        [self addSubview:self.label];
    }
    return self;
}
@end

@interface SlideCollectionView ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic) BOOL pageControlPages;
@end

@implementation SlideCollectionView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)createViewWithFrame:(CGRect)frame {
    self.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
    //创建一个layout布局类
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为垂直流布局:UICollectionViewScrollDirectionVertical
    //设置布局方向为水平流布局:
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //设置每个item的大小为100*100
    layout.itemSize = CGSizeMake(frame.size.width / (self.pageNumber / 2), (frame.size.height - 15.0) / 2);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    //创建collectionView 通过一个布局策略layout来创建
    UICollectionView *collect = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - 15.0) collectionViewLayout:layout];
    collect.contentSize = CGSizeMake(frame.size.width * (self.titles.count / self.pageNumber), frame.size.height - 15.0);
    collect.showsHorizontalScrollIndicator = NO;
    collect.pagingEnabled = YES;
    collect.backgroundColor = [UIColor whiteColor];
    //代理设置
    collect.delegate = self;
    collect.dataSource = self;
    //注册item类型 这里使用系统的类型
    [collect registerClass:[HDCollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
    [self addSubview:collect];
    if (self.pageControlPages) {
        UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((frame.size.width - 50.0) / 2, frame.size.height - 15.0, 50.0, 15.0)];
        pageControl.numberOfPages = self.titles.count / self.pageNumber;
        pageControl.currentPageIndicatorTintColor = [UIColor grayColor];
        pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        pageControl.tag = 201;
        [self addSubview:pageControl];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int current = (scrollView.contentOffset.x + self.bounds.size.width - 1) / self.bounds.size.width;
    //根据 scrollView 的位置对 page 的当前页赋值
    UIPageControl *page = (UIPageControl *)[self viewWithTag:201];
    page.currentPage = current;
}

#pragma mark - UICollectionViewDataSource
//返回分区个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.titles.count / self.pageNumber;
}
//返回每个分区的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.pageNumber;
}
//返回每个item
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HDCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    UIView *view = [[UIView alloc] initWithFrame:cell.bounds];
    view.backgroundColor = [UIColor lightGrayColor];
    cell.selectedBackgroundView = view;
    for (NSInteger i = 0; i < self.titles.count / self.pageNumber; i++) {
        if (indexPath.section == i) {
            if (indexPath.row % 2 == 0) {
                cell.imageView.image = [UIImage imageNamed:self.images[indexPath.row / 2 + i * self.pageNumber]];
                cell.label.text = self.titles[indexPath.row / 2 + i * self.pageNumber];
                if ([self.titles[indexPath.row / 2 + i * self.pageNumber] isEqualToString:@""]) {
                    view.backgroundColor = [UIColor whiteColor];
                }
            }
            else {
                cell.imageView.image = [UIImage imageNamed:self.images[(indexPath.row - 1) / 2 + self.pageNumber / 2 * ( 2 * i + 1)]];
                cell.label.text = self.titles[(indexPath.row - 1) / 2 + self.pageNumber / 2 * ( 2 * i + 1)];
                if ([self.titles[(indexPath.row - 1) / 2 + self.pageNumber / 2 * ( 2 * i + 1)] isEqualToString:@""]) {
                    view.backgroundColor = [UIColor whiteColor];
                }
            }
        }
    }
    return cell;
}

//UICollectionView被选中时调用的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    for (NSInteger i = 0; i < self.titles.count / self.pageNumber; i++) {
        NSInteger index;
        if (indexPath.section == i) {
            if (indexPath.row % 2 == 0) {
                index = (indexPath.row / 2 + i * self.pageNumber);
            }
            else {
                index = (indexPath.row - 1) / 2 + self.pageNumber / 2 * ( 2 * i + 1);
            }
            [self.slideCollectionViewDelegate slideCollectionView:self didSelectAtIndex:index];
        }
    }
}

#pragma mark - getter and setter
- (void)setTitles:(NSArray *)titles {
    if (_titles != titles) {
        if (titles.count < self.pageNumber) {
            self.pageControlPages = NO;
        }
        else {
            self.pageControlPages = YES;
        }
        if (titles.count % self.pageNumber != 0) {
            NSMutableArray *mArr =[[NSMutableArray alloc] init];
            mArr = [titles mutableCopy];
            for (int i = 0; i < (self.pageNumber - titles.count % self.pageNumber); i++) {
                [mArr addObject:@""];
            }
            _titles = [mArr copy];
        }
        else {
            _titles = titles;
            
        }
    }
}

- (void)setImages:(NSArray *)images {
    if (_images != images) {
        if (images.count % self.pageNumber != 0) {
            NSMutableArray *mArr =[[NSMutableArray alloc] init];
            mArr = [images mutableCopy];
            for (int i = 0; i < (self.pageNumber - images.count % self.pageNumber); i++) {
                [mArr addObject:@""];
            }
            _images = [mArr copy];
        }
        else {
            _images = images;
        }
    }
}

- (void)setPageNumber:(NSInteger)pageNumber {
    if (_pageNumber != pageNumber) {
        _pageNumber = pageNumber;
    }
}

- (void)setPageControlPages:(BOOL)pageControlPages {
    if (_pageControlPages != pageControlPages) {
        _pageControlPages = pageControlPages;
    }
}

@end
