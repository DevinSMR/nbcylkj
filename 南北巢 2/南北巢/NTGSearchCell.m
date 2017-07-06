//
//  NTGSearchCell.m
//  南北巢
//
//  Created by nbc on 17/6/28.
//  Copyright © 2017年 NBCYL. All rights reserved.
//

#import "NTGSearchCell.h"
@interface NTGSearchCell ()
@property (weak, nonatomic) IBOutlet UILabel *searchLb;

@end
@implementation NTGSearchCell
+ (CGSize) getSizeWithText:(NSString*)text;
{
    NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc] init];
    style.lineBreakMode = NSLineBreakByCharWrapping;
    CGSize size = [text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 24) options: NSStringDrawingUsesLineFragmentOrigin   attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0f],NSParagraphStyleAttributeName:style} context:nil].size;
    return CGSizeMake(size.width+20, 36);
}
-(void)setSearchStr:(NSString *)searchStr{
    _searchStr = searchStr;
    _searchLb.text = searchStr;
    _searchLb.layer.masksToBounds = YES;

}
@end
