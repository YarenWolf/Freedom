//
//  JFVideosModel.h
//  JFTudou
//
//  Created by 保修一站通 on 15/10/15.
//  Copyright © 2015年 JF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JFVideosModel : NSObject
@property(nonatomic, strong) NSString *yaofeng;
@property(nonatomic, strong) NSNumber *is_albumcover;
@property(nonatomic, strong) NSString *pv;
@property(nonatomic, strong) NSString *corner_image;
@property(nonatomic, strong) NSString *title;

@property(nonatomic, strong) NSString *url;
@property(nonatomic, strong) NSNumber *url_include_ids_count;
@property(nonatomic, strong) NSString *owner_nick;
@property(nonatomic, strong) NSString *short_desc;
@property(nonatomic, strong) NSObject *game_information;

@property(nonatomic, strong) NSString *iid;
@property(nonatomic, strong) NSString *small_img;
@property(nonatomic, strong) NSString *stripe_b_r;
@property(nonatomic, strong) NSString *plid;
@property(nonatomic, strong) NSString *aid;

@property(nonatomic, strong) NSString *owner_id;
@property(nonatomic, strong) NSString *type;
@property(nonatomic, strong) NSString *image_800x450;
@property(nonatomic, strong) NSString *big_img;

@end
