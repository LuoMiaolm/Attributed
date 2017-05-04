//
//  TextView.h
//  TextModel
//
//  Created by luomiao on 2017/5/4.
//  Copyright © 2017年 LM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

typedef void(^heightBlock)(CGFloat height);

@interface TextView : UIView

- (void)setHeightBlock:(heightBlock)aBlock;

- (void)updateText:(NSString *)text;

- (void)updateParagraph:(NSString *)text;

- (void)updateAttText:(NSString *)text dText:(NSString *)dText;

@end
