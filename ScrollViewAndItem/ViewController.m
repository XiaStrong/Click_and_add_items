//
//  ViewController.m
//  ScrollViewAndItem
//
//  Created by Xia_Q on 15/7/7.
//  Copyright (c) 2015年 XiaQiang. All rights reserved.
//

#import "ViewController.h"
#import "NextViewController.h"


@interface ViewController ()
{
    NSMutableArray *_items;
    UIButton *_addButton;
    int _page;
    BOOL _isMoving;
    BOOL _isEditing;
    UITapGestureRecognizer *_singletap;
    NSMutableArray *_dataArr;
    NSMutableDictionary *_dict;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _page = 0;
    _isEditing = NO;
    _dataArr=[[NSMutableArray alloc]init];
    _dict=[[NSMutableDictionary alloc]init];
    _items=[[NSMutableArray alloc]init];

    
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(10, 100, rect.size.width-20, 140)];
    _scrollView.backgroundColor=[UIColor yellowColor];
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    
    _addButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _addButton.frame=CGRectMake(20, 20, wide, wide);
    _addButton.backgroundColor=[UIColor orangeColor];
    [_addButton setTitle:@"+" forState:UIControlStateNormal];
    [_addButton addTarget:self action:@selector(addButton) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_addButton];
    
    
    
    [_scrollView setPagingEnabled:NO];
    _singletap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [_singletap setNumberOfTapsRequired:1];
    _singletap.delegate = self;
    [_scrollView addGestureRecognizer:_singletap];

}




//这是增加按钮
- (void)addButton {
    
    NextViewController *nvc=[[NextViewController alloc]init];
    
    [nvc setGetDict:^(NSMutableDictionary *dict) {
        if (dict.count!=0) {
            for (UIView *view in _scrollView.subviews ) {
                if ([view isKindOfClass:[MyItem class]]) {
                    [view removeFromSuperview];
                }
            }
            
            [_dict removeAllObjects];
            [_items removeAllObjects];
 
        }
        
        
        [_dict addEntriesFromDictionary:dict];
        
        NSArray *arr=[_dict allKeys];
        
        NSLog(@"%@",_dict);
        
        for (int n=0; n<arr.count; n++) {
            
            CGRect frame = CGRectMake(20, 20, wide, high);
            
            frame.origin.x=frame.origin.x+(n)*wide+20*(n);
            
            MyItem *gridItem = [[MyItem alloc] initWithTitle:[NSString stringWithFormat:@"%@",[arr objectAtIndex:n]] withImageName:@"nil" atIndex:n editable:YES];
            [gridItem setFrame:frame];
            [gridItem setAlpha:1];
            gridItem.delegate = self;
            [_items insertObject:gridItem atIndex:n];
            [_scrollView addSubview:gridItem];
            
        }
        CGRect frame = CGRectMake(20, 20, wide, wide);
        
        frame.origin.x = frame.origin.x  +(wide + 20) * arr.count;
        
        [_scrollView setContentSize:CGSizeMake((arr.count+1)*(20+wide)+20, _scrollView.frame.size.height)];
        
        [UIView animateWithDuration:0.2f animations:^{
            
            [_addButton setFrame:frame];
            
        }];
        
    }];
    
    [self.navigationController pushViewController:nvc animated:YES];
    
}


-(void)itemDidClick:(MyItem *)item
{
    NSLog(@"item at index %ld did clicked",item.index);

}

//删除按钮时
-(void)itemDidDeleted:(MyItem *)item atIndex:(NSInteger)index
{
    
    MyItem *lastItem=[_items lastObject];
    
    CGRect myRect=lastItem.frame;
    

    
    MyItem  *myitem = [_items objectAtIndex:index];

    
    NSLog(@"item count %ld",_items.count);
    
    [_items removeObjectAtIndex:index];
    
    [UIView animateWithDuration:0.2 animations:^{
        
        CGRect lastFrame = myitem.frame;
        
        CGRect curFrame;
        
        NSLog(@"%ld",_items.count);
        
        for (int i=(int)index; i < [_items count]; i++) {
            
            MyItem *temp = [_items objectAtIndex:i];
            
            curFrame = temp.frame;
            
            [temp setFrame:lastFrame];
            
            lastFrame = curFrame;
            
            [temp setIndex:i];
            
        }
        
        [_addButton setFrame:CGRectMake(myRect.origin.x, 20, wide, wide)];
        
        [_scrollView setContentSize:CGSizeMake((_items.count+1)*(20+wide)+20, _scrollView.frame.size.height)];
    }];
    
    [myitem removeFromSuperview];
}


-(void)itemDidEnterEditMode:(MyItem *)item
{
    NSLog(@"Items count:%ld",[_items count]);
    for (MyItem *item in _items) {
        NSLog(@"%ld",item.index);
        [item enableEditing];
    }
    _addButton.enabled=YES;
    _isEditing = YES;
}


- (void) handleSingleTap:(UITapGestureRecognizer *) gestureRecognizer{
    if (_isEditing) {
        for (MyItem *item in _items) {
            [item disableEditing];
        }
    }
    _addButton.enabled=YES;
    _isEditing = NO;
}



- (NSInteger)indexOfLocation:(CGPoint)location{
    
    NSInteger index = location.x  / (wide + 20);
    
    return index;
    
}

- (CGPoint)orginPointOfIndex:(NSInteger)index{
    CGPoint point = CGPointZero;
    
    if (index > [_items count] || index < 0) {
        return point;
    }else{
        point.x=index*(20+wide);
        return  point;
    }
}

@end
