//
//  MMFlowView_Private.h
//  MMFlowViewDemo
//
//  Created by Markus Müller on 07.10.13.
//  Copyright (c) 2013 www.isnotnil.com. All rights reserved.
//

#import <Quartz/Quartz.h>
#import <QTKit/QTKit.h>

#import "MMFlowView.h"
#import "MMButtonLayer.h"
#import "MMVideoOverlayLayer.h"
#import "MMCoverFlowLayout.h"
#import "MMCoverFlowLayer.h"
#import "MMScrollBarLayer.h"
#import "MMFlowViewImageFactory.h"

@protocol MMFlowViewImageCache;

@interface MMFlowView () <MMCoverFlowLayerDataSource>

@property (strong) MMCoverFlowLayout *layout;

@property (strong,readwrite) CALayer *backgroundLayer;
@property (strong,readwrite) CATextLayer *titleLayer;
@property (strong, nonatomic) MMCoverFlowLayer *coverFlowLayer;
@property (strong,readwrite) CALayer *containerLayer;
@property (strong,nonatomic) CALayer *selectedLayer;
@property (strong,nonatomic) CALayer *highlightedLayer;
@property (strong,readwrite) MMScrollBarLayer *scrollBarLayer;
@property (strong) MMFlowViewImageFactory *imageFactory;
@property (strong,nonatomic,readwrite) NSDictionary *contentArrayBindingInfo;
@property (nonatomic,copy) NSArray *observedItems;
@property (assign,nonatomic) BOOL draggingKnob;
@property (assign) CGFloat mouseDownInKnob;
@property (readwrite,nonatomic) NSUInteger numberOfItems;
@property (readwrite,strong) id<MMFlowViewImageCache> imageCache;
@property (nonatomic, readonly) NSRect selectedItemFrame;

+ (NSSet*)pathRepresentationTypes;
+ (NSDictionary*)uniformTypesDictionary;
+ (CGImageRef)defaultImage;
+ (NSArray*)backgroundGradientColors;
+ (NSArray*)backgroundGradientLocations;
- (void)mouseEnteredSelection;
- (void)mouseExitedSelection;
- (void)updateSelectionInRange:(NSRange)invalidatedRange;
- (CALayer*)hitLayerAtPoint:(CGPoint)aPoint;
- (id)imageItemForIndex:(NSUInteger)anIndex;
- (NSString*)imageUIDForItem:(id)anItem;
- (NSString*)imageRepresentationTypeForItem:(id)anItem;
- (NSString*)imageTitleForItem:(id)anItem;
- (id)imageRepresentationForItem:(id)anItem;
- (NSString*)titleAtIndex:(NSUInteger)anIndex;
- (CGImageRef)defaultImageForItem:(id)anItem withSize:(CGSize)imageSize;
- (BOOL)isMovieAtIndex:(NSUInteger)anIndex;
- (NSString*)uniformTypeIdentifierAtIndex:(NSUInteger)anIndex;
- (void)highlightLayer:(CALayer*)aLayer highlighted:(BOOL)isHighlighted cornerRadius:(CGFloat)cornerRadius highlightingColor:(CGColorRef)highlightingColor;

- (void)updateImages;
- (IBAction)togglePreviewPanel:(id)previewPanel;

@end
