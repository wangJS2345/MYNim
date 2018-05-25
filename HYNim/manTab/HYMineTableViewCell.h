//
//  HYMineTableViewCell.h
//  HYNim
//
//  Created by wangJS on 2018/5/24.
//  Copyright © 2018年 SXHY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NIMCommonTableViewCell.h"

typedef NS_ENUM(NSInteger, ColorButtonCellStyle){
    ColorButtonCellStyleRed,
    ColorButtonCellStyleBlue,
};
@class NTESColorButton;

@interface HYMineTableViewCell : UITableViewCell<NIMCommonTableViewCell>

@property (nonatomic,strong) NTESColorButton *button;

@end
@interface NTESColorButton : UIButton

@property (nonatomic,assign) ColorButtonCellStyle style;

@end
