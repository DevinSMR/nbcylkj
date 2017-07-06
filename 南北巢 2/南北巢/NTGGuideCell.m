/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGGuideCell.h"
#import <UIImageView+WebCache.h>

/**
 * view - 巢友指南模块
 *
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGGuideCell ()
/** 景点图片 */
@property (weak, nonatomic) IBOutlet UIImageView *iconImg;
/** 景点名称 */
@property (weak, nonatomic) IBOutlet UILabel *lblName;
/** 描述 */
@property (weak, nonatomic) IBOutlet UILabel *desc;

@end
@implementation NTGGuideCell

- (void)setScenicRegion:(NTGScenicRegion *)scenicRegion {
    _scenicRegion = scenicRegion;
    
    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:scenicRegion.scenicRegionFocusImage] placeholderImage:[UIImage imageNamed:@"icon72"]];
    self.lblName.text = scenicRegion.name;
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"<h2 id=\"jqjs\" class=\"detail_h2\"><span></span></h2> \r\n<div class=\"detail_infor fordfImg\"> \r\n <p><span style=\"font-size: 16px;/[abcdefghijklmnopqrstuvwxyzzA-EFR\\.Z0123456789 /> \r\n\t</p>\r\n<br />\r\n background-color: rgb(255, 192, 0);\"><br /></span><font color=\"#ff0000\"><b>"];
    NSString *desc = scenicRegion.introduction;
    desc = [[desc componentsSeparatedByCharactersInSet: doNotWant]componentsJoinedByString:@""];
    self.desc.text = desc;
//    NSString *bookStr = [NSString stringWithFormat:@"<html> \n"
//                         "<head> \n"
//                         "<style type=\"text/css\"> \n"
//                         "body {margin:0;font-size: %@;}\n"
//                         "</style> \n"
//                         "</head> \n"
//                         "<body>%@</body> \n"
//                         "</html>",[UIFont systemFontOfSize:8],scenicRegion.introduction];
//    [self.desc loadHTMLString:bookStr baseURL:nil];
//    self.desc.scrollView.scrollEnabled = NO;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
