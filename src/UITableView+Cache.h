//
// Created by Maxim Gubin on 18/06/16.
// Copyright (c) 2016 Kilograpp. All rights reserved.
//

#import <UIKit/UITableView.h>
@interface UITableView (Cache)
- (void)registerClass:(nonnull Class)cellClass forCellReuseIdentifier:(nonnull NSString*)identifier cacheSize:(NSUInteger)size;
- (void)registerNib:(nonnull UINib*)nib forCellReuseIdentifier:(nonnull NSString*)identifier cacheSize:(NSUInteger)size;
@end