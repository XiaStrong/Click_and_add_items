//
//  MyItem.m
//  ScrollViewAndItem
//
//  Created by Xia_Q on 15/7/7.
//  Copyright (c) 2015年 XiaQiang. All rights reserved.
//

#import "MyItem.h"
@implementation MyItem

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(id)initWithTitle:(NSString *)title withImageName:(NSString *)imageName atIndex:(NSInteger)index editable:(BOOL)removable
{
    self=[super initWithFrame:CGRectMake(0, 0, wide, high)];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        _normalImage=[UIImage imageNamed:imageName];
        self.isEditing=NO;
        _index=index;
        self.isRemovable=removable;
        
        _button=[UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame=CGRectMake(0, 0, wide, high-20);
        _button.backgroundColor=[UIColor greenColor];
        [_button setBackgroundImage:_normalImage forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_button];
        
        _titleLable=[[UILabel alloc]initWithFrame:CGRectMake(0, high-20, wide, 20)];
        _titleLable.text=title;
        _titleLable.textAlignment=NSTextAlignmentCenter;
        [self addSubview:_titleLable];
        
        UILongPressGestureRecognizer *longPress=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
        [self addGestureRecognizer:longPress];
        
        if (self.isRemovable) {
            _deleteButton=[UIButton buttonWithType:UIButtonTypeCustom];
            _deleteButton.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, 20, 20);
            [_deleteButton setImage:[UIImage imageNamed:@"deletbutton.png"] forState:UIControlStateNormal];
            [_deleteButton addTarget:self action:@selector(removeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            _deleteButton.hidden=YES;
            [self addSubview:_deleteButton];
        }
    }
    return self;
}

#pragma mark-控件点击事件
//按钮点击事件
-(void)clickItem:(id)sender
{
    [_delegate itemDidClick:self];
}

- (void) longPress:(UILongPressGestureRecognizer *) gestureRecognizer{
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            _point = [gestureRecognizer locationInView:self];
            [_delegate itemDidEnterEditMode:self];
            //放大这个item
            [self setAlpha:1.0];
            NSLog(@"press long began");
            break;
        case UIGestureRecognizerStateEnded:
            _point = [gestureRecognizer locationInView:self];
            //
            [self setAlpha:1];
            NSLog(@"press long ended");
            break;
        case UIGestureRecognizerStateFailed:
            NSLog(@"press long failed");
            break;
        case UIGestureRecognizerStateChanged:
            //移动
            NSLog(@"press long changed");
            break;
        default:
            NSLog(@"press long else");
            break;
    }
}

-(void)removeBtnClicked:(id)sender
{
    [_delegate itemDidDeleted:self atIndex:_index];
}

#pragma mark-自有事件
-(void)enableEditing
{
    
    if (self.isEditing == YES)
        return;
    
    self.isEditing = YES;
    
    [_deleteButton setHidden:NO];
    [_button setEnabled:NO];
    CGFloat rotation = 0.03;
    CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"transform"];
    shake.duration = 0.13;
    shake.autoreverses = YES;
    shake.repeatCount  = MAXFLOAT;
    shake.removedOnCompletion = NO;
    shake.fromValue = [NSValue valueWithCATransform3D:CATransform3DRotate(self.layer.transform,-rotation, 0.0 ,0.0 ,1.0)];
    shake.toValue   = [NSValue valueWithCATransform3D:CATransform3DRotate(self.layer.transform, rotation, 0.0 ,0.0 ,1.0)];
    
    [self.layer addAnimation:shake forKey:@"shakeAnimation"];
}

-(void)disableEditing
{
    [self.layer removeAnimationForKey:@"shakeAnimation"];
    _deleteButton.hidden=YES;
    _button.enabled=YES;
    self.isEditing=NO;
}

-(void)removeFromSuperview
{
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha=0;
        self.frame=CGRectMake(self.frame.origin.x+50, self.frame.origin.y+50, 0, 0);
        _deleteButton.frame=CGRectMake(0, 0, 0, 0);
    }completion:^(BOOL finished) {
        [super removeFromSuperview];
    }];
}


@end
