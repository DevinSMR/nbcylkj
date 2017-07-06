/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGJunto.h"
#import <UIImageView+WebCache.h>
#import "NTGInspirationController.h"
#import "NTGBavBaseController.h"

/**
 * view - 巢友帮单元格
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGJunto ()

/** 用户头像 */
@property (weak, nonatomic) IBOutlet UIImageView *userphoto;
/** 用户名称 */
@property (weak, nonatomic) IBOutlet UILabel *username;
/** 文章标题 */
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
/** 文章摘要 */
@property (weak, nonatomic) IBOutlet UILabel *lblAbstracts;
/** 评论数 */
@property (weak, nonatomic) IBOutlet UILabel *commentNum;
/** 点赞数 */
@property (weak, nonatomic) IBOutlet UILabel *menberPraiseNum;


@end

@implementation NTGJunto

- (void)setMemberArticle:(NTGMemberArticle *)memberArticle {
    _memberArticle = memberArticle;
    
    if (memberArticle.member.petName == nil) {
        self.username.text = @"匿名";
    }else {
        if (_memberArticle.member.petName.length>2) {
            NSString *s = [_memberArticle.member.petName substringToIndex:2];
            self.username.text = s;
        }else {
            self.username.text = @"匿名";
        }
    }
    self.userphoto.clipsToBounds = YES;
    self.userphoto.layer.masksToBounds = YES;
    self.userphoto.layer.cornerRadius = 20;
    [self.userphoto sd_setImageWithURL:[NSURL URLWithString:_memberArticle.member.picture] placeholderImage:[UIImage imageNamed:@"w_user"]];
    
    self.lblTitle.text = memberArticle.title;
    self.lblAbstracts.text = memberArticle.abstracts;
    self.commentNum.text = [NSString stringWithFormat:@"%ld",memberArticle.commentNum];
    self.menberPraiseNum.text = [NSString stringWithFormat:@"%d",memberArticle.memberPraiseNum];
}

/**  */
- (void)awakeFromNib {
    [self addTarget:self action:@selector(customButton)];
}

/* 按钮点击事件 */
- (void)addTarget:(id)target action:(SEL)action {
    [self.btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

/** 点击跳转控制器 */
- (void)customButton {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"NTGInspiration" bundle:nil];
    NTGInspirationController *inspirationController = [storyboard instantiateInitialViewController];
    UITabBarController *tabbarController = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    inspirationController.memberArticle = self.memberArticle;
    inspirationController.priseNum = ^(NSString *num){
        self.menberPraiseNum.text = num;
    };
    inspirationController.commentsNum = ^(NSString *num){
        self.commentNum.text = num;
    };
    NSArray *childControllers = [tabbarController childViewControllers];
    NTGBavBaseController *hm = childControllers[0];
    [hm pushViewController:inspirationController animated:YES];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self == [super initWithCoder:aDecoder]) {
        UIView *view1 = [[[UINib nibWithNibName:@"NTGJunto" bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
        view1.frame = self.frame;
        [self addSubview:view1];
        view1.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:view1];
        
        UIView *superview = self;
        
        UIEdgeInsets padding = UIEdgeInsetsMake(3,3,3,3);
        
        [self addConstraints:@[
                                    //view1 constraints
                                    [NSLayoutConstraint constraintWithItem:view1
                                                                 attribute:NSLayoutAttributeTop
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:superview
                                                                 attribute:NSLayoutAttributeTop
                                                                multiplier:1.0
                                                                  constant:padding.top],
                                    
                                    [NSLayoutConstraint constraintWithItem:view1
                                                                 attribute:NSLayoutAttributeLeft
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:superview
                                                                 attribute:NSLayoutAttributeLeft
                                                                multiplier:1.0
                                                                  constant:padding.left],
                                    
                                    [NSLayoutConstraint constraintWithItem:view1
                                                                 attribute:NSLayoutAttributeBottom
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:superview
                                                                 attribute:NSLayoutAttributeBottom
                                                                multiplier:1.0
                                                                  constant:-padding.bottom],
                                    
                                    [NSLayoutConstraint constraintWithItem:view1
                                                                 attribute:NSLayoutAttributeRight
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:superview
                                                                 attribute:NSLayoutAttributeRight
                                                                multiplier:1
                                                                  constant:-padding.right],
                                    
                                    ]];
        return self;
    }
    return nil;
}

@end
