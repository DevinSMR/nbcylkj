//
//  NTGStandardCell.m
//  南北巢
//
//  Created by nbc on 17/7/13.
//  Copyright © 2017年 NBCYL. All rights reserved.
//

#import "NTGStandardCell.h"

@implementation NTGStandardCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+ (CGSize) getSizeWithText:(NSString*)text
{
    NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc] init];
    style.lineBreakMode = NSLineBreakByCharWrapping;
    CGSize size = [text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 24) options: NSStringDrawingUsesLineFragmentOrigin   attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0f],NSParagraphStyleAttributeName:style} context:nil].size;
    return CGSizeMake(size.width+20, 36);
}
@end
