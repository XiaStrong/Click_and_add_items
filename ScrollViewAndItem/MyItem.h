//
//  MyItem.h
//  ScrollViewAndItem
//
//  Created by Xia_Q on 15/7/7.
//  Copyright (c) 2015年 XiaQiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Normal.h"
#import <QuartzCore/QuartzCore.h>


typedef enum{
    ItemNormalMode = 0,
    ItemEditMode = 1,
}Mode;

@protocol MyItemDelegate ;

@interface MyItem : UIView
{
    UIImage *_normalImage;
    UIImage *_editImage;
    UIButton *_deleteButton;
    UIButton *_button;
    CGPoint _point;
}

@property(nonatomic)BOOL isEditing;
@property(nonatomic)BOOL isRemovable;
@property(nonatomic,strong)UILabel *titleLable;
@property(nonatomic)NSInteger index;
@property(weak,nonatomic)id<MyItemDelegate>delegate;
-(id)initWithTitle:(NSString *)title withImageName:(NSString *)imageName atIndex:(NSInteger)index editable:(BOOL)removable;
-(void)enableEditing;
-(void)disableEditing;

@end

@protocol MyItemDelegate <NSObject>

-(void)itemDidClick:(MyItem*)item;
-(void)itemDidEnterEditMode:(MyItem *)item;
-(void)itemDidDeleted:(MyItem *)item atIndex:(NSInteger)index;

@end
