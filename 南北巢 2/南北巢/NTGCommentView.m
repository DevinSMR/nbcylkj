/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGCommentView.h"
#import "NTGCommentCell.h"
#import "EQPageCycleSize.h"

/**
 * view - 巢友指南详情  评论说说
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGCommentView ()<UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *commentTable;

@end

@implementation NTGCommentView

-(void)setMemberComments:(NSArray *)memberComments {
    _memberComments = memberComments;
    [self.commentTable reloadData];
}
/** 数据源、代理 */
-(void)awakeFromNib {
    self.commentTable.dataSource=self;
    self.commentTable.estimatedRowHeight = 70;
//    self.commentTable.separatorStyle = UITableViewCellSeparatorStyleNone;
}

/** 加载Cell */
+ (instancetype)viewWithView {
    NTGCommentView *commentView = [[[NSBundle mainBundle]loadNibNamed:@"NTGCommentView" owner:nil options:nil]lastObject];
    return commentView;
}

#pragma 数据源方法

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.memberComments.count;
}

-(NTGCommentCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NTGCommentCell *cell =[NTGCommentCell cellWithTableView:tableView];
    if (cell == nil) {
        cell = [[NTGCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NTGCommentCell"];
    }
    cell.memberComment = self.memberComments[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *str = [self.memberComments objectAtIndex:indexPath.row];
    return [self heightForText:str]+40;
}

//单独计算文本的高度
- (CGFloat)heightForText:(NSString *)text {
    //设置计算文本时字体的大小,以什么标准来计算
    NSDictionary *attrbute = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
    return [text boundingRectWithSize:CGSizeMake(UI_SCREEN_WIDTH-70, 1000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrbute context:nil].size.height;
}


@end
