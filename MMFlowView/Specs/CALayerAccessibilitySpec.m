//
//  CALayerAccessibilitySpec.m
//  LayerAccessibility
//
//  Created by Markus Müller on 03.10.13.
//  Copyright 2013 Markus Müller. All rights reserved.
//

#import <Kiwi.h>
#import <QuartzCore/QuartzCore.h>
#import "CALayer+NSAccessibility.h"

SPEC_BEGIN(CALayerAccessibilitySpec)

describe(@"CALayer+NSAccessibility", ^{
	__block CALayer *sut = nil;
	beforeEach(^{
		sut = [ CALayer layer ];
	});
	afterEach(^{
		sut = nil;
	});
	context(@"a new instance", ^{
		it(@"should exist", ^{
			[[ sut shouldNot ] beNil ];
		});
		it(@"should respond to setReadableAccessibilityAttribute:withBlock", ^{
			[[sut should] respondToSelector:@selector(setReadableAccessibilityAttribute:withBlock:)];
		});
		it(@"should respond to setWritableAccessibilityAttribute:readBlock:writeBlock:", ^{
			[[sut should] respondToSelector:@selector(setWritableAccessibilityAttribute:readBlock:writeBlock:)];
		});
		it(@"should respond tor removeAccessibilityAttribute:", ^{
			[[sut should] respondToSelector:@selector(removeAccessibilityAttribute:)];
		});
		it(@"should respond tor setAccessibilityAction:withBlock:", ^{
			[[sut should] respondToSelector:@selector(setAccessibilityAction:withBlock:)];
		});
		context(@"default attributes", ^{
			__block NSArray *expectedDefaultAttributes = nil;
			beforeAll(^{
				expectedDefaultAttributes = @[NSAccessibilityParentAttribute, NSAccessibilitySizeAttribute, NSAccessibilityPositionAttribute, NSAccessibilityWindowAttribute, NSAccessibilityTopLevelUIElementAttribute, NSAccessibilityRoleAttribute, NSAccessibilityRoleDescriptionAttribute, NSAccessibilityEnabledAttribute, NSAccessibilityFocusedAttribute];
			});
			afterAll(^{
				expectedDefaultAttributes = nil;
			});
			it(@"should have the correct default attributes count", ^{
				[[[sut should] have:[expectedDefaultAttributes count] ] accessibilityAttributeNames];
			});
			it(@"should handle default attributes", ^{
				[[[sut accessibilityAttributeNames] should] containObjectsInArray:expectedDefaultAttributes];
			});
		});
		context(@"attributes", ^{
			it(@"should respond to accessibilityAttributeValue:", ^{
				[ [ sut should ] respondToSelector:@selector(accessibilityAttributeValue:)];
			});
			it(@"should respond to accessibilitySetValue:forAttribute:", ^{
				[[ sut should ] respondToSelector:@selector(accessibilitySetValue:forAttribute:)];
			});
			it(@"should respond to accessibilityAttributeNames", ^{
				[[sut should] respondToSelector:@selector(accessibilityAttributeNames)];
			});
			it(@"should respond to accessibilityIsAttributeSettable", ^{
				[[sut should] respondToSelector:@selector(accessibilityIsAttributeSettable:)];
			});
			it(@"should return NSAccessibilityUnknownRole for role attribute", ^{
				[[[sut accessibilityAttributeValue:NSAccessibilityRoleAttribute] should] equal:NSAccessibilityUnknownRole];
			});
			it(@"should return nil for accessibilityAttributeValue with nil attribute name", ^{
				[[[sut accessibilityAttributeValue:nil] should] beNil];
			});
			it(@"should return NO for the default NSAccessibilityFocusedAttribute", ^{
				[[[sut accessibilityAttributeValue:NSAccessibilityFocusedAttribute] should] beNo];
			});
			it(@"should return YES for the default NSAccessibilityEnabledAttribute", ^{
				[[[sut accessibilityAttributeValue:NSAccessibilityEnabledAttribute] should] beYes];
			});
		});
		context(@"parameterized attributes", ^{
			it(@"should respond to accessibilityParameterizedAttributeNames", ^{
				[[sut should] respondToSelector:@selector(accessibilityParameterizedAttributeNames)];
			});
			it(@"should have zero paremterized attribute names", ^{
				[[[sut should] have:0] accessibilityParameterizedAttributeNames];
			});
			it(@"should respond to accessibilityAttributeValue:forParameter:", ^{
				[[sut should] respondToSelector:@selector(accessibilityAttributeValue:forParameter:)];
			});
			context(@"layer with parameterized attribute", ^{
				__block NSNumber *handlerInvoked = nil;

				beforeEach(^{
					[sut setParameterizedAccessibilityAttribute:NSAccessibilityLineForIndexParameterizedAttribute withBlock:^id(id param) {
						return handlerInvoked = @YES;
					}];
				});
				afterEach(^{
					handlerInvoked = nil;
				});
				it(@"should return the parameterized attribute in accessibilityParameterizedAttributeNames", ^{
					[[[sut accessibilityParameterizedAttributeNames] should] contain:NSAccessibilityLineForIndexParameterizedAttribute];
				});
				it(@"should invoke the handler", ^{
					[[[sut accessibilityAttributeValue:NSAccessibilityLineForIndexParameterizedAttribute
										  forParameter:@0 ] should] beYes];
				});
			});
		});
		context(@"actions", ^{
			it(@"should respont to accessibilityActionNames", ^{
				[[sut should] respondToSelector:@selector(accessibilityActionNames)];
			});
			it(@"should respond to accessibilityPerformAction:", ^{
				[[sut should] respondToSelector:@selector(accessibilityPerformAction:)];
			});
			it(@"should respond to accessibilityActionDescription:", ^{
				[[sut should] respondToSelector:@selector(accessibilityActionDescription:)];
			});
			it(@"should have zero actions", ^{
				[[[sut should] have:0] accessibilityActionNames];
			});
			it(@"should raise an exception with empty action handler", ^{
				[[theBlock(^{
					[sut setAccessibilityAction:NSAccessibilityPressAction
									  withBlock:nil ];
				}) should] raise];
			});
		});
		it(@"should respond to accessibilityIsIgnored", ^{
			[[ sut should ] respondToSelector:@selector(accessibilityIsIgnored) ];
		});
		it(@"should respond to accessibilityHitTest:", ^{
			[[sut should] respondToSelector:@selector(accessibilityHitTest:)];
		});
		it(@"should return YES to accessibilityIsIgnored",^{
			[[ theValue([ sut accessibilityIsIgnored ]) should ] beYes ];
		});
		it(@"should throw an exception if invoked with empty handler", ^{
			[[theBlock(^{
				[sut setReadableAccessibilityAttribute:NSAccessibilityRoleAttribute withBlock:nil ];
			}) should] raise];
		});
		it(@"should throw if invoked with empty handlers", ^{
			[[theBlock(^{
				[sut setWritableAccessibilityAttribute:NSAccessibilityRoleAttribute
								readBlock:nil
							   writeBlock:nil ];
			}) should] raise];
		});
		
	});
	context(@"layer in view", ^{
		__block NSWindow *window = nil;
		__block NSView *view = nil;
		
		beforeEach(^{
			window = [[ NSWindow alloc ] initWithContentRect:NSMakeRect(0, 0, 400, 400)
												   styleMask:NSTitledWindowMask
													 backing:NSBackingStoreBuffered
													   defer:NO ];
			view = [ [ NSView alloc ] initWithFrame:NSMakeRect(0, 0, 400, 400) ];
			[ view setAccessiblityEnabledLayer:sut ];
			[ window setContentView:view ];
		});
		afterEach(^{
			[ window close ];
			[view removeFromSuperview ];
			view.layer = nil;
			view = nil;
			window = nil;
		});
		context(@"accessibility parent", ^{
			it(@"should not return for its accessibility parent", ^{
				[[ [sut accessibilityAttributeValue:NSAccessibilityParentAttribute] shouldNot] beNil];
			});
		});
		it(@"should return a top level ui attribute value", ^{
			[[[sut accessibilityAttributeValue:NSAccessibilityTopLevelUIElementAttribute] shouldNot] beNil];
		});
		it(@"should return the window for accessibility window attribute", ^{
			id axWindow = [sut accessibilityAttributeValue:NSAccessibilityWindowAttribute ];
			[[ axWindow should] equal:window];
		});
	});
	context(@"unignored layer", ^{
		beforeEach(^{
			[sut setReadableAccessibilityAttribute:NSAccessibilityRoleAttribute withBlock:^id{
				return NSAccessibilityImageRole;
			}];
		});
		afterEach(^{
			[sut removeAccessibilityAttribute:NSAccessibilityRoleAttribute];
		});
		context(@"with children", ^{
			__block NSArray *sublayers = nil;
			__block NSArray *unignoredChildren = nil;
			
			beforeEach(^{
				sublayers = @[ [ CALayer layer ], [ CALayer layer ] ];
				
				for ( CALayer * child in sublayers ) {
					[ sut addSublayer:child ];
				}
				unignoredChildren = NSAccessibilityUnignoredChildren(sut.sublayers);
			});
			afterEach(^{
				sublayers = nil;
				unignoredChildren = nil;
			});
			
			it(@"should return unignored sublayers for NSAccessibilityChildrenAttribute", ^{
				[[[ sut accessibilityAttributeValue:NSAccessibilityChildrenAttribute ] should ] equal:unignoredChildren ];
			});
			it(@"should return its unignored parent for NSAccessibilityParentAttribute", ^{
				[[[ sublayers[0] accessibilityAttributeValue:NSAccessibilityParentAttribute ] should ] equal:NSAccessibilityUnignoredAncestor(sut) ];
			});
			it(@"should throw an exception if layer is not associated with a view and has no superlayer when asked for its parent", ^{
				[[ theBlock(^{
					[ sut accessibilityAttributeValue:NSAccessibilityParentAttribute ];
				}) should ] raiseWithName:NSInternalInconsistencyException reason:@"No accessibility parent available" ];
			});
		});
	});
	context(@"layer with read-only role attribute", ^{
		beforeEach(^{
			[ sut setReadableAccessibilityAttribute:NSAccessibilityRoleAttribute withBlock:^id{
				return NSAccessibilityImageRole;
			}];
		});
		it(@"should also have the NSAccessibilityRoleDescriptionAttribute attribute", ^{
			[[[ sut accessibilityAttributeNames ] should] contain:NSAccessibilityRoleDescriptionAttribute];
		});
		it(@"should have a non-empty attribute value", ^{
			[[[sut accessibilityAttributeValue:NSAccessibilityRoleDescriptionAttribute] shouldNot] beNil];
		});
		it(@"should have a matching role description", ^{
			[[[sut accessibilityAttributeValue:NSAccessibilityRoleDescriptionAttribute] should] equal:NSAccessibilityRoleDescriptionForUIElement(sut)];
		});
		it(@"should return the role returned from getter block", ^{
			[[[ sut accessibilityAttributeValue:NSAccessibilityRoleAttribute ] should ] equal:NSAccessibilityImageRole ];
		});
		it(@"should contain the custom attribue in accessibilityActionNames", ^{
			[[ [ sut accessibilityAttributeNames ] should ] contain:NSAccessibilityRoleAttribute ];
		});
		context(@"remove role attribute", ^{
			beforeEach(^{
				[sut removeAccessibilityAttribute:NSAccessibilityRoleAttribute];
			});
			it(@"should still contain role attribute", ^{
				[[[sut accessibilityAttributeNames] should] contain:NSAccessibilityRoleAttribute];
			});
			it(@"should return unknown role", ^{
				[[[sut accessibilityAttributeValue:NSAccessibilityRoleAttribute] should] equal:NSAccessibilityUnknownRole];
			});
		});
	});
	context(@"writable attributes", ^{
		__block NSNumber *value = nil;
		
		beforeEach(^{
			[sut setWritableAccessibilityAttribute:NSAccessibilityValueAttribute
										 readBlock:^id{
											 return value;
										 }
										writeBlock:^(id aValue){
											value = aValue;
										}];
		});
		afterEach(^{
			value = nil;
			[sut setWritableAccessibilityAttribute:NSAccessibilityValueAttribute
										 readBlock:^id{
											 return value;
										 }
										writeBlock:^(id aValue) {
											value = aValue;
										}];
		});
		it(@"should return YES for provided writable attribute", ^{
			[[theValue([sut accessibilityIsAttributeSettable:NSAccessibilityValueAttribute]) should] beYes];
		});
		it(@"should return NO for unprovided attribute", ^{
			[[theValue([sut accessibilityIsAttributeSettable:NSAccessibilityFilenameAttribute]) should] beNo];
		});
		context(@"setting the attribute", ^{
			beforeEach(^{
				[sut accessibilitySetValue:@YES
							  forAttribute:NSAccessibilityValueAttribute];
			});
			afterEach(^{
				value = nil;
			});
			
			it(@"should invoke the setter block", ^{
				[[value should] beYes];
			});
			it(@"should read the previously written value", ^{
				[[[sut accessibilityAttributeValue:NSAccessibilityValueAttribute] should] beYes];
			});
			/*
			context(@"notifications", ^{
				__block NSDictionary *observers = nil;
				__block NSNumber *notificationTriggered = nil;
				
				beforeEach(^{
					AXObserverRef observer = NULL;
					
					if(AXObserverCreate(getpid(), valueChangeNotification, &observer) == kAXErrorSuccess) {
						if(AXObserverAddNotification(observer, AXUIElementCreateApplication(getpid()), kAXValueChangedNotification, &notificationTriggered) != kAXErrorSuccess) {
							NSLog(@"Failed to create ax-observer for calayer \"%@\".", sut );
						} else {
							observers = @{@"observer": (id)CFBridgingRelease(observer)};
						}
						CFRelease(observer);
					}
				});
				afterEach(^{
					AXObserverRef observer = (__bridge AXObserverRef)(observers[@"observer"]);
					AXObserverRemoveNotification(observer, AXUIElementCreateApplication(getpid()), kAXValueChangedNotification );
					observers = nil;
					notificationTriggered = nil;
				});
				pending(@"should trigger a NSAccessibilityValueChangedNotification", ^{
					[[notificationTriggered should] beYes];
				});
			});*/
		});
		context(@"removing custom handlers", ^{
			beforeEach(^{
				[sut removeAccessibilityAttribute:NSAccessibilityValueAttribute];
			});
			it(@"should not have the removed attribute", ^{
				[[[sut accessibilityAttributeNames] shouldNot] contain:NSAccessibilityValueAttribute];
			});
			it(@"should return NO for accessibilityIsAttributeSettable with the removed attribute", ^{
				[[theValue([sut accessibilityIsAttributeSettable:NSAccessibilityValueAttribute]) should] beNo];
			});
		});
	});
	context(@"accessibility actions", ^{
		__block NSNumber *actionInvoked = nil;

		beforeEach(^{
			[sut setAccessibilityAction:NSAccessibilityPressAction withBlock:^{
				actionInvoked = @YES;
			}];
		});
		afterEach(^{
			actionInvoked = nil;
		});
		it(@"should have one action", ^{
			[[[sut should] have:1] accessibilityActionNames];
		});
		it(@"should have the action", ^{
			[[[sut accessibilityActionNames] should] contain:NSAccessibilityPressAction];
		});
		context(@"performing the action", ^{
			beforeEach(^{
				[sut accessibilityPerformAction:NSAccessibilityPressAction];
			});
			it(@"should have invoked the action", ^{
				[[actionInvoked should] beYes];
			});
		});
	});
});

SPEC_END