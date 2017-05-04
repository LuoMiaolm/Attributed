//
//  TextView.m
//  TextModel
//
//  Created by luomiao on 2017/5/4.
//  Copyright © 2017年 LM. All rights reserved.
//

#import "TextView.h"

@interface TextView ()
{
    UILabel *_textLab;
    
    heightBlock _aBlock;
    
    CGFloat _tHeight;
}
@end

@implementation TextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _tHeight = 0;
        _textLab = [[UILabel alloc] init];
        _textLab.numberOfLines = 0;
        _textLab.font = [UIFont boldSystemFontOfSize:15.0];
        _textLab.backgroundColor = [UIColor clearColor];
        [self addSubview:_textLab];
        
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)updateConstraints
{
    [super updateConstraints];
    UIView *superView = self;
    [_textLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(superView);
        make.height.mas_equalTo(_tHeight);
    }];
}

- (void)setHeightBlock:(heightBlock)aBlock
{
    _aBlock = aBlock;
}

// 此方法适合一行的文字计算，如果行数越多，由于换行时会有一个文字显示不下的空隙，导致计算值不准确
- (void)updateText:(NSString *)text
{
    _textLab.text = text;
    CGSize size = [text boundingRectWithSize:CGSizeMake(_textLab.frame.size.width, CGFLOAT_MAX)
                                    options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                 attributes:@{NSFontAttributeName:_textLab.font}
                                    context:nil].size;
    _tHeight = size.height;
    [self updateConstraints];
    
    CGFloat totalHeight = _tHeight;
    _aBlock(totalHeight);
}

- (void)updateParagraph:(NSString *)text
{
    _textLab.text = text;
    _tHeight = [_textLab sizeThatFits:CGSizeMake(_textLab.frame.size.width, MAXFLOAT)].height;
    [self updateConstraints];
    
    CGFloat totalHeight = _tHeight;
    _aBlock(totalHeight);
}

// 可设置文字的行间距，段落间距，以及段落的文字样式
- (void)updateAttText:(NSString *)text dText:(NSString *)dText
{
    NSMutableParagraphStyle *paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle1.lineSpacing = 2; //增加行高
//    paragraphStyle1.paragraphSpacing = 10;  //段落后面的间距
    NSMutableAttributedString *showStr = [[NSMutableAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName:_textLab.font,NSParagraphStyleAttributeName:paragraphStyle1.copy,NSBackgroundColorAttributeName:_textLab.backgroundColor}];
    
    NSMutableParagraphStyle *paragraphStyle2 = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle2.lineSpacing = 2;
    [showStr appendAttributedString:[[NSAttributedString alloc] initWithString:dText attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10.0],NSParagraphStyleAttributeName:paragraphStyle2.copy,NSBackgroundColorAttributeName:_textLab.backgroundColor,NSForegroundColorAttributeName:[UIColor redColor]}]];
    _textLab.attributedText = showStr;
    _tHeight = [_textLab sizeThatFits:CGSizeMake(_textLab.frame.size.width, MAXFLOAT)].height;
    [self updateConstraints];
    
    CGFloat totalHeight = _tHeight;
    _aBlock(totalHeight);
}

@end
