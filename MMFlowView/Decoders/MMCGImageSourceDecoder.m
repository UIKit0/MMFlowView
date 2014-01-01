//
//  MMCGImageSourceDecoder.m
//  MMFlowViewDemo
//
//  Created by Markus Müller on 18.12.13.
//  Copyright (c) 2013 www.isnotnil.com. All rights reserved.
//

#import "MMCGImageSourceDecoder.h"

@implementation MMCGImageSourceDecoder

- (CGImageRef)newImageFromItem:(id)anItem withSize:(CGSize)imageSize
{
	if ( anItem && (CGImageSourceGetTypeID() == CFGetTypeID((__bridge CFTypeRef)(anItem))) ) {
		CFStringRef imageSourceType = CGImageSourceGetType((__bridge CGImageSourceRef)(anItem));
		CGImageRef image = NULL;
		if ( imageSourceType ) {
			if (CGSizeEqualToSize(imageSize, CGSizeZero)) {
				imageSize.width = 16000;
				imageSize.height = 16000;
			}
			NSDictionary *options = @{(NSString *)kCGImageSourceCreateThumbnailFromImageIfAbsent: @YES,
									  (NSString *)kCGImageSourceThumbnailMaxPixelSize: [ NSNumber numberWithInteger:MAX(imageSize.width, imageSize.height) ]};
			image = CGImageSourceCreateThumbnailAtIndex((__bridge CGImageSourceRef)(anItem), 0, (__bridge CFDictionaryRef)options );
		}
		return image;
	}
	return NULL;
}

- (NSImage*)imageFromItem:(id)anItem
{
	NSImage *image = nil;
	if ( anItem && (CGImageSourceGetTypeID() == CFGetTypeID((__bridge CFTypeRef)(anItem))) ) {
		CFStringRef imageSourceType = CGImageSourceGetType((__bridge CGImageSourceRef)(anItem));
		if ( imageSourceType != NULL ) {
			CGImageRef imageRef = [self newImageFromItem:anItem withSize:CGSizeZero];
			if (imageRef) {
				image = [[NSImage alloc] initWithCGImage:imageRef size:NSZeroSize];
			}
		}
	}
	return image;
}

@end
