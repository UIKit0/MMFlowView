/*
 
 The MIT License (MIT)
 
 Copyright (c) 2014 Markus Müller https://github.com/mmllr All rights reserved.
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this
 software and associated documentation files (the "Software"), to deal in the Software
 without restriction, including without limitation the rights to use, copy, modify, merge,
 publish, distribute, sublicense, and/or sell copies of the Software, and to permit
 persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies
 or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
 INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
 PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
 FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
 OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 DEALINGS IN THE SOFTWARE.
 
 */
//
//  MMCGImageSourceDecoderSpec.m
//  MMFlowViewDemo
//
//  Created by Markus Müller on 18.12.13.
//  Copyright 2013 www.isnotnil.com. All rights reserved.
//

#import "Kiwi.h"
#import "MMCGImageSourceDecoder.h"
#import "MMMacros.h"

SPEC_BEGIN(MMCGImageSourceDecoderSpec)

describe(@"MMCGImageSourceDecoder", ^{
	__block MMCGImageSourceDecoder *sut = nil;
	__block CGImageSourceRef imageSource = NULL;
	__block CGImageRef imageRef = NULL;

	beforeAll(^{
		NSURL *imageURL = [[NSBundle bundleForClass:[self class]] URLForResource:@"TestImage01" withExtension:@"jpg"];
		imageSource = CGImageSourceCreateWithURL((__bridge CFURLRef)(imageURL), NULL);
	});
	afterAll(^{
		if (imageSource) {
			CFRelease(imageSource);
			imageSource = NULL;
		}
	});
	context(@"a new instance", ^{
		beforeEach(^{
			sut = [[MMCGImageSourceDecoder alloc] init];
		});
		afterEach(^{
			sut = nil;
		});
		afterAll(^{
			SAFE_CGIMAGE_RELEASE(imageRef)
		});
		it(@"should exist", ^{
			[[sut shouldNot] beNil];
		});
		it(@"should conform to MMImageDecoderProtocol", ^{
			[[sut should] conformToProtocol:@protocol(MMImageDecoderProtocol)];
		});
		it(@"should respond to newCGImageFromItem:", ^{
			[[sut should] respondToSelector:@selector(newCGImageFromItem:)];
		});
		it(@"should respond to imageFromItem:", ^{
			[[sut should] respondToSelector:@selector(imageFromItem:)];
		});
		context(@"maxPixelSize", ^{
			it(@"should have a maxPixelSize of zero", ^{
				[[theValue(sut.maxPixelSize) should] beZero];
			});
			it(@"should set a positive size", ^{
				sut.maxPixelSize = 100;
				[[theValue(sut.maxPixelSize) should] equal:theValue(100)];
			});
		});
		context(@"newCGImageFromItem:", ^{
			context(@"when created with NSURL and non-zero size", ^{
				beforeAll(^{
					sut.maxPixelSize = 100;
					imageRef = [sut newCGImageFromItem:(__bridge id)imageSource];
				});
				afterAll(^{
					SAFE_CGIMAGE_RELEASE(imageRef)
				});
				it(@"should load an image", ^{
					[[theValue(imageRef != NULL) should] beTrue];
				});
				it(@"should have a width less or equal 100", ^{
					[[theValue(CGImageGetWidth(imageRef)) should] beLessThanOrEqualTo:theValue(100)];
				});
				it(@"should have a height less or equal 100", ^{
					[[theValue(CGImageGetHeight(imageRef)) should] beLessThanOrEqualTo:theValue(100)];
				});
			});
			context(@"when asking for an image with an invalid item", ^{
				it(@"should not return an image for nil", ^{
					[[theValue([sut newCGImageFromItem:nil] == NULL) should] beTrue];
				});
				it(@"should not return an image for an item from wrong type", ^{
					[[theValue([sut newCGImageFromItem:@"Test"] == NULL) should] beTrue];
				});
			});
			context(@"when asking for an image with zero image size", ^{
				beforeAll(^{
					sut.maxPixelSize = 0;
					imageRef = [sut newCGImageFromItem:(__bridge id)imageSource];
				});
				afterAll(^{
					SAFE_CGIMAGE_RELEASE(imageRef)
				});
				it(@"should return an image", ^{
					[[theValue(imageRef != NULL) should] beTrue];
				});
			});
		});
		context(@"imageFromItem:", ^{
			context(@"creating an image from a CGImageSourceRef", ^{
				__block NSImage *image = nil;
				
				beforeAll(^{
					image = [sut imageFromItem:(__bridge id)imageSource];
				});
				afterAll(^{
					image = nil;
				});
				it(@"should return an image", ^{
					[[image shouldNot] beNil];
				});
				it(@"should return an NSImage", ^{
					[[image should] beKindOfClass:[NSImage class]];
				});
			});
			context(@"when asking for an image with an invalid item", ^{
				it(@"should not return an image for nil", ^{
					[[[sut imageFromItem:nil] should] beNil];
				});
				it(@"should not return an image for an item from wrong type", ^{
					[[[sut imageFromItem:@"Test"] should] beNil];
				});
			});
		});
	});
});

SPEC_END
