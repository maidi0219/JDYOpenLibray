//
//  JDYLocation.h
//  JDYOpenLibray
//
//  Created by Jacy Lee on 2022/3/31.
//  Copyright © 2022 com.jdy.map. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JDYLocation : NSObject

@property(nonatomic, copy) NSString *longitude;
@property(nonatomic, copy) NSString *userLatitude;
@property(nonatomic, copy) NSString *nation;
@property(nonatomic, copy) NSString *province; 
@property(nonatomic, copy) NSString *city; 
@property(nonatomic, copy) NSString *district;
@property(nonatomic, copy) NSString *address;
@property(nonatomic, strong)NSNumber *offset;
@end

NS_ASSUME_NONNULL_END
