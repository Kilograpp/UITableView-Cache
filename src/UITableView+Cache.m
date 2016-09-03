//
// Created by Maxim Gubin on 18/06/16.
// Copyright (c) 2016 Kilograpp. All rights reserved.
//

#import "UITableView+Cache.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface UITableView ()

@property (nonatomic, strong) NSMutableDictionary* cachedCells;
@property (nonatomic, strong) NSMutableDictionary* registeredNibs;
@property (nonatomic, strong) NSMutableDictionary* registeredClasses;

@end


@implementation UITableView (Cache)

#pragma mark - Public

- (void)registerClass:(Class)cellClass forCellReuseIdentifier:(NSString*)identifier cacheSize:(NSUInteger)size {
    [self kg_prepareCache];
    self.registeredClasses[identifier] = cellClass;
    [self kg_cacheCellsForIdentifier:identifier cacheSize:size];
}

- (void)registerNib:(UINib*)nib forCellReuseIdentifier:(NSString*)identifier cacheSize:(NSUInteger)size {
    [self kg_prepareCache];
    self.registeredNibs[identifier] = nib;
    [self kg_cacheCellsForIdentifier:identifier cacheSize:size];
}

#pragma mark - Load

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];

        SEL originalSelector = @selector(dequeueReusableCellWithIdentifier:);
        SEL swizzledSelector = @selector(privateDequeueReusableCellWithIdentifier:);

        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);


        BOOL didAddMethod =
                class_addMethod(class,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));

        if (didAddMethod) {
            class_replaceMethod(class,
                    swizzledSelector,
                    method_getImplementation(originalMethod),
                    method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

#pragma mark - Swizzling

#pragma clang diagnostic push
#pragma ide diagnostic ignored "InfiniteRecursion"
- (UITableViewCell*)privateDequeueReusableCellWithIdentifier:(NSString*)identifier {
    UITableViewCell *cell = [self privateDequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [self.cachedCells[identifier] firstObject];
        if (cell) {
            [self.cachedCells[identifier] removeObject:cell];
        } else {
            NSLog(@"WARNING! %@ cache is empty for identifier %@. Instantiating cell now.", self.class, identifier);
            cell = [self kg_instantiateCellForReuseIdentifier:identifier];
        }
    }
    return cell;

}
#pragma clang diagnostic pop


#pragma mark - Private

- (UITableViewCell*)kg_instantiateCellForReuseIdentifier:(NSString*)identifier {
    if (self.registeredNibs[identifier]) {
        return [[(UINib*) self.registeredNibs[identifier] instantiateWithOwner:self options:nil] firstObject];
    }
    if (self.registeredClasses[identifier]) {
        return [[self.registeredClasses[identifier] alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return nil;
}

- (void)kg_cacheCellsForIdentifier:(NSString*)identifier cacheSize:(NSUInteger)cacheSize {

    NSMutableArray *cells = [NSMutableArray arrayWithCapacity:cacheSize];

    for (unsigned int i = 0; i < cacheSize; i++) {
        [cells addObject:[self kg_instantiateCellForReuseIdentifier:identifier]];
    }

    self.cachedCells[identifier] = cells;

}

- (void)kg_prepareCache {
    if(!self.cachedCells) {
        [self setCachedCells:[NSMutableDictionary dictionary]];
    }
    if (!self.registeredClasses) {
        [self setRegisteredClasses:[NSMutableDictionary dictionary]];
    }
    if (!self.registeredNibs) {
        [self setRegisteredNibs:[NSMutableDictionary dictionary]];
    }
}


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