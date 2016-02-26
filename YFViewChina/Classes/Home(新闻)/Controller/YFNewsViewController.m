//
//  YFNewsViewController.m
//  YFViewChina
//
//  Created by qianfneg on 16/1/18.
//  Copyright © 2016年 杨飞. All rights reserved.
//

#import "YFNewsViewController.h"
#import "YFTableViewController.h"
#import "YFTitleLabel.h"
#define VIEW_WIDTH  self.view.frame.size.width
#define VIEW_HEIGHT self.view.frame.size.height
@interface YFNewsViewController () <UIScrollViewDelegate>
@property (nonatomic, strong) NSArray *infoArray;

@property (weak, nonatomic) IBOutlet UIScrollView *topScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *bigScrollView;
/**
 *  俩个View之间的红线
 */
@property (weak, nonatomic) IBOutlet UIView *redUnderLine;

@end

@implementation YFNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加导航label
    [self addTitleLabels];
    // 添加控制器
    [self addControllers];
    // 添加默认控制器,第一个tableView (父类指针指向子类对象)
    UIViewController *vc = [self.childViewControllers firstObject];
    vc.view.frame = self.bigScrollView.bounds;
    [self.bigScrollView addSubview:vc.view];
    self.bigScrollView.showsHorizontalScrollIndicator = NO;
    self.bigScrollView.delegate = self;
    self.bigScrollView.contentSize = CGSizeMake(self.infoArray.count * VIEW_WIDTH, 0);

    self.topScrollView.showsHorizontalScrollIndicator = NO;
    self.topScrollView.showsVerticalScrollIndicator = NO;
//    self.topScrollView.delegate = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    YFTitleLabel *label = [self.topScrollView.subviews firstObject];
    label.scale = 1.0;
}

- (NSArray *)infoArray {
    if (_infoArray == nil) {
        NSString *infoPath = [[NSBundle mainBundle] pathForResource:@"NewsURL.plist" ofType:nil];
        _infoArray = [NSArray arrayWithContentsOfFile:infoPath];
    }
    return _infoArray;
}

// 添加头部标题
- (void)addTitleLabels {
// titleLabel的大小
#define LABEL_W   70
    for (NSInteger i = 0; i < self.infoArray.count; ++i) {
        CGFloat labelW = LABEL_W;
        CGFloat labelH = 40;
        CGFloat labelX = i *labelW;
        CGFloat labelY = 0;
        YFTitleLabel *label = [[YFTitleLabel alloc] initWithFrame:CGRectMake(labelX, labelY, labelW, labelH)];
        label.text = self.infoArray[i][@"title"];
        label.tag = i;
        [self.topScrollView addSubview:label];
        label.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClicked:)];
        [label addGestureRecognizer:tap];
    }
    self.topScrollView.contentSize = CGSizeMake(LABEL_W*self.infoArray.count, 0);
}
// 添加控制器
- (void)addControllers {
    for (NSInteger i = 0; i < self.infoArray.count; ++i) {
        YFTableViewController *tvc = [UIStoryboard storyboardWithName:@"News" bundle:nil].instantiateInitialViewController;
        tvc.urlString = self.infoArray[i][@"urlString"];
        [self addChildViewController:tvc];
    }
}
- (void)labelClicked:(UITapGestureRecognizer *)tap {
    YFTitleLabel *label = (YFTitleLabel *)tap.view;
    CGFloat offSetX = label.tag *VIEW_WIDTH;
    [self.bigScrollView setContentOffset:CGPointMake(offSetX, 0) animated:YES];
}
// 代码设置偏移量结束
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
// 滚动结束创建相应的控制器
    NSInteger index = scrollView.contentOffset.x/VIEW_WIDTH;
    YFTableViewController *tvc = self.childViewControllers[index];
    tvc.index = index;
    tvc.view.frame = self.bigScrollView.bounds;
    
    [self.bigScrollView addSubview:tvc.view];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if ([scrollView isEqual:self.topScrollView]) {
//        NSLog(@"===========");
//        return;
//    }
//    
    CGFloat value = ABS(scrollView.contentOffset.x / VIEW_WIDTH);
    NSUInteger leftIndex = (int)value;
    NSUInteger rightIndex = leftIndex + 1;
    CGFloat scaleRight = value - leftIndex;
    CGFloat scaleLeft = 1 - scaleRight;
    YFTitleLabel *labelLeft = self.topScrollView.subviews[leftIndex];
    labelLeft.scale = scaleLeft;
    if (rightIndex < self.topScrollView.subviews.count) {
        YFTitleLabel *labelRight = self.topScrollView.subviews[rightIndex];
        labelRight.scale = scaleRight;
    }
    //改变topScrollView的offset
//    if (value < 3) {
//        CGPoint offset = CGPointMake(value*LABEL_W, 0);
//        [self.topScrollView setContentOffset:offset];
//    }
//    //改变下划线位置
//    if (value > 3) {
//        CGPoint center = self.redUnderLine.center;
//        center.x = (value-3)*LABEL_W+LABEL_W/2;
//        self.redUnderLine.center = center;
//    }
}
//手动拖拽减速结束
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
