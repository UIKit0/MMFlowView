//
//  MMCoverFLowLayoutSpec.m
//  MMFlowViewDemo
//
//  Created by Markus Müller on 18.10.13.
//  Copyright 2013 www.isnotnil.com. All rights reserved.
//

#import "Kiwi.h"
#import "MMCoverFLowLayout.h"

SPEC_BEGIN(MMCoverFLowLayoutSpec)

context(@"MMCoverFlowLayout", ^{
	context(@"a new instance", ^{
		__block MMCoverFlowLayout *sut = nil;
		CGSize defaultItemSize = CGSizeMake(50, 50);

		beforeEach(^{
			sut = [[MMCoverFlowLayout alloc] init];
		});
		afterEach(^{
			sut = nil;
		});
		it(@"should exist", ^{
			[[sut shouldNot] beNil];
		});
		it(@"should have the default inter item spacing of 10", ^{
			[[theValue(sut.interItemSpacing) should] equal:theValue(10)];
		});
		it(@"should have the default item size", ^{
			NSValue *itemSize = [NSValue valueWithSize:sut.itemSize];
			NSValue *expectedSize = [NSValue valueWithSize:defaultItemSize];
			[[itemSize should] equal:expectedSize];
		});
		it(@"should have a default stacked angle of 70", ^{
			[[theValue(sut.stackedAngle) should] equal:theValue(70)];
		});
		it(@"should have a default selected index of NSNotFound", ^{
			[[theValue(sut.selectedItemIndex) should] equal:theValue(NSNotFound)];
		});
		it(@"should have an item count of 0", ^{
			[[theValue(sut.numberOfItems) should] equal:theValue(0)];
		});
		it(@"should have a default vertical margin of 50", ^{
			[[theValue(sut.verticalMargin) should] equal:theValue(50)];
		});
		it(@"should have a zero contentSize", ^{
			[[theValue((BOOL)CGSizeEqualToSize(sut.contentSize, CGSizeZero)) should] beTrue];
		});
		context(@"itemSize", ^{
			__block NSValue *expectedSize = nil;

			beforeEach(^{
				expectedSize = [NSValue valueWithSize:defaultItemSize];
			});
			afterEach(^{
				expectedSize = nil;
			});
			context(@"setting a zero size", ^{
				beforeEach(^{
					sut.itemSize = CGSizeZero;
				});
				it(@"should not set zero size", ^{
					[[[NSValue valueWithSize:NSSizeFromCGSize(sut.itemSize)] should] equal:expectedSize];
				});
			});
			context(@"setting negative values", ^{
				it(@"should not set negative width", ^{
					sut.itemSize = CGSizeMake(-100, 100);

					[[[NSValue valueWithSize:NSSizeFromCGSize(sut.itemSize)] should] equal:expectedSize];
				});
				it(@"should not set negative height", ^{
					sut.itemSize = CGSizeMake(100, -100);

					[[[NSValue valueWithSize:NSSizeFromCGSize(sut.itemSize)] should] equal:expectedSize];
				});
				it(@"should not set both negative width and height", ^{
					sut.itemSize = CGSizeMake(-100, -100);

					[[[NSValue valueWithSize:NSSizeFromCGSize(sut.itemSize)] should] equal:expectedSize];
				});
			});
			context(@"setting minimum size", ^{
				__block NSValue *minimumSize = nil;

				beforeEach(^{
					minimumSize = [NSValue valueWithSize:CGSizeMake(1, 1)];
					sut.itemSize = [minimumSize sizeValue];
				});
				afterEach(^{
					minimumSize = nil;
				});
				it(@"should have the minimum size", ^{
					[[[NSValue valueWithSize:NSSizeFromCGSize(sut.itemSize)] should] equal:minimumSize];
				});
			});
		});
		context(@"interItemSpacing", ^{
			it(@"should not set negative values", ^{
				sut.interItemSpacing = -10;
				[[theValue(sut.interItemSpacing) should] beGreaterThan:theValue(0)];
			});
			it(@"should set the minimum value of 1", ^{
				sut.interItemSpacing = 1.f;
				[[theValue(sut.interItemSpacing) should] equal:theValue(1)];
			});
		});
		context(@"stackedAngle", ^{
			it(@"it should set the minimum of 0 for a negative angle", ^{
				sut.stackedAngle = -10;
				[[theValue(sut.stackedAngle) should] equal:theValue(0)];
			});
			it(@"should set the minimum allowed value of 0", ^{
				sut.stackedAngle = 0;
				[[theValue(sut.stackedAngle) should] equal:theValue(0)];
			});
			it(@"should set the maximum value of 90", ^{
				sut.stackedAngle = 90;
				[[theValue(sut.stackedAngle) should] equal:theValue(90)];
			});
			it(@"it should set the maximum of 90 for an angle greater than 90", ^{
				sut.stackedAngle = 100;
				[[theValue(sut.stackedAngle) should] equal:theValue(90)];
			});
		});
	});
});

SPEC_END
