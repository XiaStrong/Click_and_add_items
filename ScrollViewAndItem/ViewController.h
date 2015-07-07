//
//  ViewController.h
//  ScrollViewAndItem
//
//  Created by Xia_Q on 15/7/7.
//  Copyright (c) 2015年 XiaQiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyItem.h"

@interface ViewController : UIViewController<UIScrollViewDelegate,MyItemDelegate,UIGestureRecognizerDelegate>

@property(nonatomic,strong)UIScrollView *scrollView;

-(void)addButton;

-(NSInteger)indexOfLocation:(CGPoint)location;

-(CGPoint)orginPointOfIndex:(NSInteger)index;

@end
