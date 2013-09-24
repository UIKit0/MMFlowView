//
//  MMLayerAccessibilityHelper.h
//  MMFlowViewDemo
//
//  Created by Markus Müller on 07.05.13.
//  Copyright (c) 2013 www.isnotnil.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMLayerAccessibilityHelper : NSObject

@property (readonly, copy) NSString *role;
@property (readonly, weak) id parent;
@property (readonly, weak) CALayer *layer;
@property (readonly, weak) NSView *view;
@property (nonatomic, copy) NSSet *writableAttributeNames;
@property (nonatomic, copy) NSSet *attributeNames;
@property (nonatomic, assign) BOOL focused;
@property (nonatomic, assign) BOOL enabled;

+ (id)layerAccesibilityHelperWithRole:(NSString*)aRole parent:(id)aParent layer:(CALayer*)aLayer view:(NSView*)aView;
- (id)initWithRole:(NSString*)aRole parent:(id)aParent layer:(CALayer*)aLayer view:(NSView*)aView;
- (void)addHandlerForAttribute:(NSString*)anAttribute withBlock:(id (^)(MMLayerAccessibilityHelper*))aHandler;
- (void)addHandlerForWritableAttribute:(NSString*)anAttribute withBlock:(void (^)(MMLayerAccessibilityHelper*, id))aHandler;
- (void)addChildrenObject:(MMLayerAccessibilityHelper*)aChild;
- (NSArray*)children;

@end
