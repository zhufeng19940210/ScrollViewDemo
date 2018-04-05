//  ViewController.m
//  网易新闻Demo
//  Created by bailing on 2018/4/4.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import "ViewController.h"
#import "ZFContentTableViewController.h"
#import "FengfengLabel.h"
@interface ViewController () <UIScrollViewDelegate>
@property (nonatomic,strong)UIScrollView *titleScrollView;
@property (nonatomic,strong)UIScrollView *cotentScrollView;
@property (nonatomic,strong)NSMutableArray *titleArray;
@end
@implementation ViewController
-(NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSMutableArray arrayWithObjects:@"测试1",@"测试2",@"测试3",@"测试4",@"测试5", nil];
    }
    return _titleArray;
}
-(UIScrollView *)titleScrollView{
    if (!_titleScrollView) {
        _titleScrollView = [[UIScrollView alloc]init];
        _titleScrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, 45);
    }
    return _titleScrollView;
}
-(UIScrollView *)cotentScrollView{
    if (!_cotentScrollView) {
        _cotentScrollView = [[UIScrollView alloc]init];
        _cotentScrollView.frame = CGRectMake(0, 45, self.view.frame.size.width, self.view.frame.size.height - 45);
        _cotentScrollView.delegate = self;
        _cotentScrollView.bounces = NO;
        //这个属性很重要
        _cotentScrollView.pagingEnabled = YES;
        _cotentScrollView.showsVerticalScrollIndicator = NO;
        _cotentScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _cotentScrollView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.titleScrollView];
    [self.view addSubview:self.cotentScrollView];
    //创建子类
    ZFContentTableViewController *content1 = [[ZFContentTableViewController alloc]init];
    content1.title = @"军事";
    [self addChildViewController:content1];
    ZFContentTableViewController *content2 = [[ZFContentTableViewController alloc]init];
    content2.title = @"国际";
    [self addChildViewController:content2];
    ZFContentTableViewController *content3 = [[ZFContentTableViewController alloc]init];
    content3.title = @"教育";
    [self addChildViewController:content3];
    ZFContentTableViewController *content4 = [[ZFContentTableViewController alloc]init];
    content4.title = @"娱乐";
    [self addChildViewController:content4];
    ZFContentTableViewController *content5 = [[ZFContentTableViewController alloc]init];
    content5.title = @"政治";
    [self addChildViewController:content5];
    ZFContentTableViewController *content6 = [[ZFContentTableViewController alloc]init];
    content6.title = @"经济";
    [self addChildViewController:content6];
    ZFContentTableViewController *content7 = [[ZFContentTableViewController alloc]init];
    content7.title = @"体育";
    [self addChildViewController:content7];
    //setupTittle
    [self setupTilte];
    //默认选择第一个
    [self scrollViewDidEndScrollingAnimation:self.cotentScrollView];
}
-(void)setupTilte{
    CGFloat labelX = 0;
    CGFloat labelY = 0;
    CGFloat labelH = 45;
    CGFloat labelW = 100;
    for (int i = 0; i < self.childViewControllers.count; i++) {
        FengfengLabel *homeLabel = [[FengfengLabel alloc]init];
        labelX = i * labelW;
        homeLabel.frame = CGRectMake(labelX, labelY, labelW, labelH);
        homeLabel.text = [self.childViewControllers[i] title];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTap:)];
        [homeLabel addGestureRecognizer:tapGesture];
        homeLabel.tag = i;
        [self.titleScrollView addSubview:homeLabel];
        if (i == 0) {
            homeLabel.scale = 1;
        }
//        UILabel *label = [[UILabel alloc]init];
//        labelX = i * labelW;
//        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
//        label.text = [self.childViewControllers[i] title];
//        label.textColor = [UIColor blackColor];
//        label.backgroundColor = [self randColor];
//        label.textAlignment = NSTextAlignmentCenter;
//        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTap:)];
//        [label addGestureRecognizer:tapGesture];
//        label.userInteractionEnabled = YES;
//        label.tag = i;
//        [self.titleScrollView addSubview:label];
    }
    // 设置contentSize
    self.titleScrollView.contentSize = CGSizeMake(7 * labelW, 0);
    self.cotentScrollView.contentSize = CGSizeMake(7 * [UIScreen mainScreen].bounds.size.width, 0);
}
-(void)labelTap:(UITapGestureRecognizer *)gesture{
    //[self.titleScrollView.subviews indexOfObject:tap.view];
    NSLog(@"gesture.tag:%ld",gesture.view.tag);
    NSInteger index = gesture.view.tag;
    // 让底部的内容scrollView滚动到对应位置
    CGPoint offset = self.cotentScrollView.contentOffset;
    offset.x = index * self.cotentScrollView.frame.size.width;
    [self.cotentScrollView setContentOffset:offset animated:YES];
}
-(UIColor *)randColor{
    CGFloat r = arc4random_uniform(256);
    CGFloat g = arc4random_uniform(256);
    CGFloat b = arc4random_uniform(256);
    return  [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1];
}
#pragma mark -- UIScrollViewDelegate
/*
scrollView结束了滚动动画以后就会调用这个方法
 （比如- (void)setContentOffset:(CGPoint)contentOffset animated:(BOOL)animated;方法执行的动画完毕后）
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    //一些临时的变量
    CGFloat width  = scrollView.frame.size.width;
    CGFloat height = scrollView.frame.size.height;
    CGFloat contenOffset = scrollView.contentOffset.x;
    //取出当前的索引的东西
    NSInteger index  = contenOffset / width;
    //上面的titleScrollView也跟着滚动
    FengfengLabel *titleLabel = self.titleScrollView.subviews[index];
    CGPoint contentOff = self.titleScrollView.contentOffset;
    // 中间对比下
    contentOff.x = titleLabel.center.x - width * 0.5;
    //左边超出东西了
    if (contentOff.x < 0) {
        contentOff.x = 0;
    }
    //右边的超出的东西
    //全局对比
    CGFloat maxTitleOffsetX = self.titleScrollView.contentSize.width - width;
    if (contentOff.x > maxTitleOffsetX) {
        NSLog(@"maxTitleOffsetX:%f",maxTitleOffsetX);
        contentOff.x = maxTitleOffsetX;
    }
    [self.titleScrollView setContentOffset:contentOff animated:YES];
    // 让其他label回到最初的状态
    for (FengfengLabel *otherLabel in self.titleScrollView.subviews) {
        if (otherLabel != titleLabel) otherLabel.scale = 0.0;
    }
    
    UIViewController *willShowVc = self.childViewControllers[index];
    //如果当前位置显示过了就不显示了
    if ([willShowVc isViewLoaded]) return;
    // 添加控制器的view到contentScrollView中;
    willShowVc.view.frame = CGRectMake(contenOffset, 0, width, height);
    [scrollView addSubview:willShowVc.view];
}
/**
 * 手指松开scrollView后，scrollView停止减速完毕就会调用这个
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}
/**
 * 只要scrollView在滚动，就会调用
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scale = scrollView.contentOffset.x / scrollView.frame.size.width;
    if (scale < 0 || scale > self.titleScrollView.subviews.count - 1) return;
    
    // 获得需要操作的左边label
    NSInteger leftIndex = scale;
    FengfengLabel *leftLabel = self.titleScrollView.subviews[leftIndex];
    
    // 获得需要操作的右边label
    NSInteger rightIndex = leftIndex + 1;
    FengfengLabel *rightLabel = (rightIndex == self.titleScrollView.subviews.count) ? nil : self.titleScrollView.subviews[rightIndex];
    
    // 右边比例
    CGFloat rightScale = scale - leftIndex;
    // 左边比例
    CGFloat leftScale = 1 - rightScale;
    
    // 设置label的比例
    leftLabel.scale = leftScale;
    rightLabel.scale = rightScale;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
