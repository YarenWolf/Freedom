//
//  TLEmojiKeyboard.h
//  TLChat
//
//  Created by 李伯坤 on 16/2/17.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLKeyboardDelegate.h"
#import "TLEmojiGroupControl.h"
#import "TLEmojiItemCell.h"
#import "TLEmojiFaceItemCell.h"
#import "TLEmojiImageItemCell.h"
#import "TLEmojiImageTitleItemCell.h"
#define     HEIGHT_TOP_SPACE            10
#define     HEIGHT_EMOJIVIEW            (HEIGHT_CHAT_KEYBOARD * 0.75 - HEIGHT_TOP_SPACE)
#define     HEIGHT_PAGECONTROL          HEIGHT_CHAT_KEYBOARD * 0.1
#define     HEIGHT_GROUPCONTROL         HEIGHT_CHAT_KEYBOARD * 0.17
#import "TLEmoji.h"

@class TLEmojiKeyboard;
@protocol TLEmojiKeyboardDelegate <NSObject>

- (BOOL)chatInputViewHasText;

@optional
- (void)emojiKeyboard:(TLEmojiKeyboard *)emojiKB didTouchEmojiItem:(TLEmoji *)emoji atRect:(CGRect)rect;

- (void)emojiKeyboardCancelTouchEmojiItem:(TLEmojiKeyboard *)emojiKB;

- (void)emojiKeyboard:(TLEmojiKeyboard *)emojiKB didSelectedEmojiItem:(TLEmoji *)emoji;

- (void)emojiKeyboardSendButtonDown;

- (void)emojiKeyboardEmojiEditButtonDown;

- (void)emojiKeyboardMyEmojiEditButtonDown;

- (void)emojiKeyboard:(TLEmojiKeyboard *)emojiKB selectedEmojiGroupType:(TLEmojiType)type;

@end
@interface TLEmojiKeyboard : UIView<UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,TLEmojiGroupControlDelegate>{
    CGSize cellSize;
    CGSize headerReferenceSize;
    CGSize footerReferenceSize;
    CGFloat minimumLineSpacing;
    CGFloat minimumInteritemSpacing;
    UIEdgeInsets sectionInsets;
}
- (void)registerCellClass;

- (NSUInteger)transformCellIndex:(NSInteger)index;

- (NSUInteger)transformModelIndex:(NSInteger)index;

- (void)resetCollectionSize;

- (void)addGusture;
- (void)updateSendButtonStatus;

@property (nonatomic, assign) NSMutableArray *emojiGroupData;

@property (nonatomic, assign) id<TLEmojiKeyboardDelegate>delegate;

@property (nonatomic, assign) id<TLKeyboardDelegate> keyboardDelegate;

@property (nonatomic, strong) TLEmojiGroup *curGroup;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) TLEmojiGroupControl *groupControl;

+ (TLEmojiKeyboard *)keyboard;

- (void)showInView:(UIView *)view withAnimation:(BOOL)animation;

- (void)dismissWithAnimation:(BOOL)animation;

- (void)reset;

@end
