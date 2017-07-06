/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <Foundation/Foundation.h>

/**
 * Entity - 版本信息
 *
 * @author nbcyl Team
 * @version 3.0
 */
@interface NTGAppVersion : NSObject

/** 版本号 */
@property(nonatomic,assign) int versionCode;

/** 版本名称 */
@property(nonatomic,copy) NSString *versionName;

/** 版本说明 */
@property(nonatomic,copy) NSString *versionInstruction;

/** app下载路径 */
@property(nonatomic,copy) NSString *appPath;

@end
