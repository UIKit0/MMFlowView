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
//  MMCoverFlowLayout.h
//  MMFlowViewDemo
//
//  Created by Markus Müller on 18.10.13.
//  Copyright (c) 2013 www.isnotnil.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MMCoverFlowLayoutAttributes;

@interface MMCoverFlowLayout : NSObject<NSCoding>

@property (nonatomic, readonly) CGFloat contentWidth;
@property (nonatomic, readonly) CGSize itemSize;
@property (nonatomic) CGFloat contentHeight;
@property (nonatomic) CGFloat interItemSpacing;
@property (nonatomic) CGFloat stackedAngle;
@property (nonatomic) NSUInteger selectedItemIndex;
@property (nonatomic) NSUInteger numberOfItems;
@property (nonatomic) CGFloat stackedDistance;
@property (nonatomic) CGFloat verticalMargin;

- (id)initWithContentHeight:(CGFloat)contentHeight;
- (MMCoverFlowLayoutAttributes*)layoutAttributesForItemAtIndex:(NSUInteger)itemIndex;

@end
