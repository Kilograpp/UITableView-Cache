//
//  UITableView+CacheProperties.h
//  UITableView+Cache
//
//  Created by Maxim Gubin on 03/09/16.
//  Copyright © 2016 Kilograpp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (CacheProperties)

@property (nonatomic, strong) NSMutableDictionary* cachedCells;
@property (nonatomic, strong) NSMutableDictionary* registeredNibs;
@property (nonatomic, strong) NSMutableDictionary* registeredClasses;

@end
