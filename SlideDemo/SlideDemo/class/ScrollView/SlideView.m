//
//  SlideView.m
//  滑动demo
//
//  Created by mobilewise_mac_01 on 16/2/19.
//  Copyright © 2016年 com.cjt. All rights reserved.
//

#import "SlideView.h"

@interface SlideView ()<UIScrollViewDelegate>

@end

@implementation SlideView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _labelHeight = 15.0;
        _viewToScrollViewDistance = 23.0;
        _imageViewToLabelDistance = 50.0;
        _labelFont = 15.0;
        _pageControlWidth = 50.0;
    }
    return self;
}

- (void)createViewWithFrame:(CGRect)frame {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    [self addSubview:scrollView];
    
    NSInteger j = 0;
    CGFloat pageControlHeight = 0.0;
    for (NSInteger i = 0; i < self.titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(buttonTouchedUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [button addTarget:self action:@selector(buttonTouchUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
        [button addTarget:self action:@selector(buttonTouchedDown:) forControlEvents:UIControlEventTouchDown];
        [button addTarget:self action:@selector(buttonTouchCancel:) forControlEvents:UIControlEventTouchCancel];
        button.tag = i;
        
//        UIView *view = [[UIView alloc] init];
//        view.tag = i;
//        view.userInteractionEnabled = YES;
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap:)];
//        [view addGestureRecognizer:tap];
        UIImageView *imageView = [[UIImageView alloc] init];
        UIImage *image = [UIImage imageNamed:self.images[i]];
        imageView.image = image;
        UILabel *label = [[UILabel alloc] init];
        label.text = self.titles[i];
        label.font = [UIFont systemFontOfSize:self.labelFont];
        label.textColor = [UIColor blackColor];
        CGFloat buttonSpace = (frame.size.width / (self.pageNumber / 2) - image.size.width) / 2;
        CGFloat y;
        if ((i % (self.pageNumber / 2) == 0)&&(i % self.pageNumber == 0)) {
            j = i - (self.pageNumber / 2) * (i / self.pageNumber);
            y = self.viewToScrollViewDistance;
        } else if ((i % (self.pageNumber / 2) == 0)&&(i % self.pageNumber != 0)){
            j = i - (self.pageNumber / 2) * (i / self.pageNumber + 1);
            y = image.size.height + self.viewToScrollViewDistance * 2 + self.labelHeight * 2 + 28.0;
        }
        pageControlHeight = image.size.height * 2 + self.viewToScrollViewDistance * 2 + self.labelHeight * 4 + 28.0 *2;
        button.frame = CGRectMake(frame.size.width / (self.pageNumber / 2) * j , y - self.viewToScrollViewDistance, frame.size.width / (self.pageNumber / 2), image.size.height + self.labelHeight * 2 + self.viewToScrollViewDistance + 28.0);
//        view.frame = CGRectMake(frame.size.width / (self.pageNumber / 2) * j , y, frame.size.width / (self.pageNumber / 2), image.size.height + self.labelHeight * 2 + self.viewToScrollViewDistance + 28.0);
        imageView.frame = CGRectMake(buttonSpace * (2 * j + 1) + image.size.width * j , y, image.size.width, image.size.height);
        label.frame = CGRectMake(frame.size.width / (self.pageNumber / 2) * j , y + image.size.height + self.labelHeight, frame.size.width / (self.pageNumber / 2), self.labelHeight);
        label.textAlignment = NSTextAlignmentCenter;
        j++;
//        [scrollView addSubview:view];
        [scrollView addSubview:button];
        [scrollView addSubview:imageView];
        [scrollView addSubview:label];
    }
    
    if (self.titles.count > self.pageNumber) {
        scrollView.contentSize = CGSizeMake(frame.size.width * ((self.titles.count - 1) / self.pageNumber + 1), frame.size.height);
        UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((self.bounds.size.width - self.pageControlWidth) / 2, pageControlHeight, self.pageControlWidth, 15.0)];
        pageControl.numberOfPages = (self.titles.count + self.pageNumber - 1) / self.pageNumber;
        pageControl.currentPageIndicatorTintColor = [UIColor grayColor];
        pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        pageControl.tag = 201;
        [self addSubview:pageControl];
    } else {
        scrollView.contentSize = CGSizeMake(frame.size.width, frame.size.height);
    }

}

- (void)buttonTouchedUpInside:(UIButton *)button {
    NSLog(@"buttonTouchedUpInside");
    button.backgroundColor = [UIColor whiteColor];
    [self.slideViewDelegate SlideView:self didSelectAtIndex:button.tag];
}

- (void)buttonTouchUpOutside:(UIButton *)button {
    NSLog(@"buttonTouchUpOutside");
    button.backgroundColor = [UIColor whiteColor];
}

- (void)buttonTouchedDown:(UIButton *)button {
    NSLog(@"buttonTouchedDown");
    button.backgroundColor = [UIColor lightGrayColor];
}

- (void)buttonTouchCancel:(UIButton *)button {
    NSLog(@"buttonTouchCancel");
    button.backgroundColor = [UIColor whiteColor];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    // 记录 scrollView 的当前位置，第几页
    int current = scrollView.contentOffset.x / self.bounds.size.width;
    //根据 scrollView 的位置对 page 的当前页赋值
    UIPageControl *page = (UIPageControl *)[self viewWithTag:201];
    page.currentPage = current;
}

#pragma mark - 点击事件
- (void)viewTap:(UITapGestureRecognizer *)tapGR {
    UIView *view = (UIView *)tapGR.view;
    [self.slideViewDelegate SlideView:self didSelectAtIndex:view.tag];
}

#pragma mark - getter and setter
- (void)setTitles:(NSArray *)titles {
    if (_titles != titles) {
        _titles = titles;
    }
}

- (void)setImages:(NSArray *)images {
    if (_images != images) {
        _images = images;
    }
}

- (void)setPageNumber:(NSInteger)pageNumber {
    if (_pageNumber != pageNumber) {
        _pageNumber = pageNumber;
    }
}

- (void)setLabelHeight:(CGFloat)labelHeight {
    if (_labelHeight != labelHeight) {
        _labelHeight = labelHeight;
    }
}

- (void)setViewToScrollViewDistance:(CGFloat)viewToScrollViewDistance {
    if (_viewToScrollViewDistance != viewToScrollViewDistance) {
        _viewToScrollViewDistance = viewToScrollViewDistance;
    }
}

- (void)setImageViewToLabelDistance:(CGFloat)imageViewToLabelDistance {
    if (_imageViewToLabelDistance != imageViewToLabelDistance) {
        _imageViewToLabelDistance = imageViewToLabelDistance;
    }
}

- (void)setLabelFont:(float)labelFont {
    if (_labelFont != labelFont) {
        _labelFont = labelFont;
    }
}

- (void)setPageControlWidth:(CGFloat)pageControlWidth {
    if (_pageControlWidth != pageControlWidth) {
        _pageControlWidth = pageControlWidth;
    }
}

@end
