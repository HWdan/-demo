//
//  SlideCollectionView.h
//  滑动demo
//
//  Created by mobilewise_mac_01 on 16/2/23.
//  Copyright © 2016年 com.cjt. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SlideCollectionView;
@protocol SlideCollectionViewDelegate <NSObject>

- (void)slideCollectionView:(SlideCollectionView *)slideCollectionView didSelectAtIndex:(NSInteger)index;

@end

@interface SlideCollectionView : UIView
@property (nonatomic, strong) NSArray *titles;//下标文字数组
@property (nonatomic, strong) NSArray *images;//图片名称数组
@property (nonatomic) NSInteger pageNumber;//一页的个数
@property (nonatomic, weak) id <SlideCollectionViewDelegate> slideCollectionViewDelegate;

- (void)createViewWithFrame:(CGRect)frame;


@end
