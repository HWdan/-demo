//
//  SlideView.h
//  滑动demo
//
//  Created by mobilewise_mac_01 on 16/2/19.
//  Copyright © 2016年 com.cjt. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SlideView;
@protocol SlideViewDelegate <NSObject>
- (void)SlideView:(SlideView *)slideView didSelectAtIndex:(NSInteger)index;
@end

@interface SlideView : UIView
@property (nonatomic, strong) NSArray *titles;//下标文字数组
@property (nonatomic, strong) NSArray *images;//图片名称数组
@property (nonatomic) NSInteger pageNumber;//一页的个数
@property (nonatomic) CGFloat   labelHeight;//label的高度
@property (nonatomic) CGFloat   viewToScrollViewDistance;//view到ScrollView的距离
@property (nonatomic) CGFloat   imageViewToLabelDistance;//button到label的距离
@property (nonatomic) CGFloat   pageControlWidth;
@property (nonatomic) float     labelFont;
@property (nonatomic, weak) id <SlideViewDelegate> slideViewDelegate;

- (void)createViewWithFrame:(CGRect)frame;

@end
