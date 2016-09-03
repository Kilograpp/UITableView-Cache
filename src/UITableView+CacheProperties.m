//
//  UITableView+CacheProperties.m
//  UITableView+Cache
//
//  Created by Maxim Gubin on 03/09/16.
//  Copyright © 2016 Kilograpp. All rights reserved.
//

#import "UITableView+CacheProperties.h"
#import <objc/runtime.h>

@implementation UITableView (CacheProperties)

#pragma mark - Properties

- (NSDictionary *)cachedCells {
    return objc_getAssociatedObject(self, @selector(cachedCells));
}

- (void)setCachedCells:(NSDictionary *)dictionary {
    objc_setAssociatedObject(self, @selector(cachedCells), dictionary, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSDictionary *)registeredNibs {
    return objc_getAssociatedObject(self, @selector(registeredNibs));
}

- (void)setRegisteredNibs:(NSDictionary *)dictionary {
    objc_setAssociatedObject(self, @selector(registeredNibs), dictionary, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSDictionary *)registeredClasses {
    return objc_getAssociatedObject(self, @selector(registeredClasses));
}

- (void)setRegisteredClasses:(NSDictionary *)dictionary {
    objc_setAssociatedObject(self, @selector(registeredClasses), dictionary, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
