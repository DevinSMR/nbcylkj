/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import "NTGAttribute.h"

/**
 * Entity - 筛选参数
 * @author 谷强
 * @vertion 2015 Apr 16, 2015 4:59:01 PM
 */
@implementation NTGAttribute

+ (NSDictionary *)objectClassInArray{
    return @{@"option":[NTGAttibuteOption class]};
}

- (NTGAttribute *)cloneObject {
    NTGAttribute *copyObject = [[NTGAttribute alloc] init];
    copyObject.name = self.name;
    copyObject.value = self.value;
    copyObject.option = self.option;
    return copyObject;
}

- (void)changeAllOptionsTag:(BOOL)tag {
    NSArray* attrOptions = self.option;
    for (int j=0; j<attrOptions.count; j++) {
        NTGAttibuteOption * aOptions = attrOptions[j];
        aOptions.tag = tag;
    }
}

@end
