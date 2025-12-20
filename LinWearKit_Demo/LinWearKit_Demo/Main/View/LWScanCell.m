//
//  LWScanCell.m
//  LinWearKit_Demo
//
//  Created by LINWEAR on 2025-12-17.
//

#import "LWScanCell.h"

@implementation LWScanCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *rssiLabel = [self mainLabel:LWFontMake(14) textColor:UIColor.systemGrayColor];
        rssiLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:rssiLabel];
        [rssiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.mas_equalTo(-20);
            make.width.mas_equalTo(40);
            make.centerY.mas_equalTo(self.contentView);
        }];
        self.rssiLabel = rssiLabel;
        
        UILabel *titLabel = [self mainLabel:LWFontBoldMake(16) textColor:LWColorTheme];
        [self.contentView addSubview:titLabel];
        [titLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.leading.mas_equalTo(20);
            make.trailing.mas_equalTo(rssiLabel.mas_leading);
        }];
        self.titLabel = titLabel;

        UILabel *detLabel = [self mainLabel:LWFontBoldMake(14) textColor:UIColor.systemGrayColor];
        [self.contentView addSubview:detLabel];
        [detLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.mas_equalTo(titLabel.mas_trailing);
            make.leading.mas_equalTo(titLabel.mas_leading);
            make.top.mas_equalTo(titLabel.mas_bottom).offset(5);
            make.bottom.mas_equalTo(-20);
        }];
        self.detLabel = detLabel;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
