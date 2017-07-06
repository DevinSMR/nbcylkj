/*
 * Copyright 2005-2013 nbcyl.com. All rights reserved.
 * Support: http://www.nbcyl.com
 * License: http://www.nbcyl.com/license
 */

#import <Foundation/Foundation.h>

/**
 * Entity - 机构房间信息
 * 注意 ： 本类信息备注不全，详细描述参见接口（补充完成备注）
 * @author nbcyl Team
 * @version 3.0
 */

@interface NTGGuestRoom : NSObject

@property(nonatomic,copy) NSString *name;

@property(nonatomic,copy) NSString *actualPrice;

@property(nonatomic,copy) NSString *roomEnvironmentImage;

@property(nonatomic,copy) NSString *bedStyle;

@property(nonatomic,assign) BOOL isComputer;

@property(nonatomic,assign) BOOL isFreeWifi;

@property(nonatomic,assign) BOOL isLCTV;

@property(nonatomic,assign) BOOL isBloodPressureTest;

@property(nonatomic,assign) BOOL isBloodSugar;

@property(nonatomic,assign) BOOL isIndependentWashingRoom;

@property(nonatomic,assign) BOOL isIndependentKitchen;

@property(nonatomic,copy) NSString *bathRoomImage;

@property(nonatomic,copy) NSString *roomFacilityImage;

@property(nonatomic,copy) NSString *guestRoomOtherImage1;

@property(nonatomic,copy) NSString *guestRoomOtherImage2;

@property(nonatomic,copy) NSString *guestRoomOtherImage3;

@property(nonatomic,copy) NSString *guestRoomOtherImage4;

@end
