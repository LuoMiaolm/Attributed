# Attributed
# iOS，OC，文字适应UILabel，UILabel适应文字

##  * 文字适应UILabel
文字大小根据`UILabel`的尺寸缩放
``` Objective-C
  // 设置文字自适应
  _label.adjustsFontSizeToFitWidth = YES;
  // UIBaselineAdjustmentAlignBaselines 居下
  // UIBaselineAdjustmentAlignCenters 居中
  // UIBaselineAdjustmentNone 居上
  _label.baselineAdjustment = UIBaselineAdjustmentAlignCenters; 
```

##  * UILabel适应文字

1.此方法适合一行的文字计算，如果行数越多，由于换行时可能会有一个文字显示不下的空隙，导致计算值不准确
``` Objective-C
CGSize size = [text boundingRectWithSize:CGSizeMake(_textLab.frame.size.width, CGFLOAT_MAX)
                                    options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                 attributes:@{NSFontAttributeName:_textLab.font}
                                    context:nil].size;
```

2.当有文字分段的时候，因为换行产生的占位符，上面的方法就不能准确计算出文字高度了，这就需要下面的方法
``` Objective-C
textLab.text = text;
_tHeight = [_textLab sizeThatFits:CGSizeMake(_textLab.frame.size.width, MAXFLOAT)].height;
```
3.当有文字分段的时候，并且还需要对段落的文字样式做不同定制的时候，这就需要下面的方法
``` Objective-C
// 第一种样式
NSMutableParagraphStyle *paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
paragraphStyle1.lineSpacing = 2; //增加行高
//paragraphStyle1.paragraphSpacing = 10;  //段落后面的间距
NSMutableAttributedString *showStr = [[NSMutableAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName:_textLab.font,NSParagraphStyleAttributeName:paragraphStyle1.copy,NSBackgroundColorAttributeName:_textLab.backgroundColor}];
// 第二种样式    
NSMutableParagraphStyle *paragraphStyle2 = [[NSMutableParagraphStyle alloc] init];
paragraphStyle2.lineSpacing = 2;
[showStr appendAttributedString:[[NSAttributedString alloc] initWithString:dText attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10.0],NSParagraphStyleAttributeName:paragraphStyle2.copy,NSBackgroundColorAttributeName:_textLab.backgroundColor,NSForegroundColorAttributeName:[UIColor redColor]}]];
_textLab.attributedText = showStr;
_tHeight = [_textLab sizeThatFits:CGSizeMake(_textLab.frame.size.width, MAXFLOAT)].height;
```
