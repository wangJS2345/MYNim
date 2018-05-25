//
//  HYMineTableViewCell.m
//  HYNim
//
//  Created by wangJS on 2018/5/24.
//  Copyright © 2018年 SXHY. All rights reserved.
//

#import "HYMineTableViewCell.h"
#import "NIMCommonTableData.h"


@interface HYMineTableViewCell()

@property (nonatomic,strong) NIMCommonTableRow *rowData;

@end
@implementation HYMineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _button = [[NTESColorButton alloc] initWithFrame:CGRectZero];
        _button.size = [_button sizeThatFits:CGSizeMake(self.width, CGFLOAT_MAX)];
        _button.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addSubview:_button];
    }
    return self;
}

- (void)refreshData:(NIMCommonTableRow *)rowData tableView:(UITableView *)tableView{
    self.rowData = rowData;
    [self.button setTitle:rowData.title forState:UIControlStateNormal];
    ColorButtonCellStyle style = [rowData.extraInfo integerValue];
    self.button.style = style;
    [self.button removeTarget:tableView.viewController action:NULL forControlEvents:UIControlEventTouchUpInside];
    if (rowData.cellActionName.length) {
        SEL action = NSSelectorFromString(rowData.cellActionName);
        [_button addTarget:tableView.viewController action:action forControlEvents:UIControlEventTouchUpInside];
    }
}
- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if (self.rowData.cellActionName.length) {
        return [super hitTest:point withEvent:event];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _button.centerX = self.width * .5f;
    _button.centerY = self.height * .5f;
}


- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    [_button setHighlighted:highlighted];
}

@end

@implementation NTESColorButton : UIButton

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self reset];
    }
    return self;
}

- (void)setStyle:(ColorButtonCellStyle)style{
    _style = style;
    [self reset];
}

- (void)reset{
    NSString *imageNormalName = @"";
    NSString *imageHighLightName  = @"";
    switch (self.style) {
        case ColorButtonCellStyleRed:
            imageNormalName = @"icon_cell_red_normal";
            imageHighLightName  = @"icon_cell_red_pressed";
            break;
        case ColorButtonCellStyleBlue:
            imageNormalName = @"icon_cell_blue_normal";
            imageHighLightName  = @"icon_cell_blue_pressed";
            break;
        default:
            break;
    }
    UIImage *imageNormal = [[UIImage imageNamed:imageNormalName] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch];
    UIImage *imageHighLight = [[UIImage imageNamed:imageHighLightName] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch];
    [self setBackgroundImage:imageNormal forState:UIControlStateNormal];
    [self setBackgroundImage:imageHighLight forState:UIControlStateHighlighted];
}

- (CGSize)sizeThatFits:(CGSize)size{
    return CGSizeMake(size.width - 20, 45);
}

@end

