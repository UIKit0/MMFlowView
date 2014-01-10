//
//  CALayer+MMAdditions.m
//  MMFlowViewDemo
//
//  Created by Markus Müller on 10.01.14.
//  Copyright (c) 2014 www.isnotnil.com. All rights reserved.
//

#import "CALayer+MMAdditions.h"

@implementation CALayer (MMAdditions)

- (void)disableImplicitPositionAndBoundsAnimations
{
	NSMutableDictionary *customActions = [NSMutableDictionary dictionaryWithDictionary:self.actions];
	customActions[@"position"] = [NSNull null];
	customActions[@"bounds"] = [NSNull null];
	self.actions = customActions;
}

- (void)enableImplicitPositionAndBoundsAnimations
{
	NSMutableDictionary *customActions = [NSMutableDictionary dictionaryWithDictionary:self.actions];
	[customActions removeObjectForKey:@"position"];
	[customActions removeObjectForKey:@"bounds"];
	self.actions = customActions;
}

@end
