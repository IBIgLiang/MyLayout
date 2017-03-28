//
//  MyLayoutPos.m
//  MyLayout
//
//  Created by oybq on 15/6/14.
//  Copyright (c) 2015年 YoungSoft. All rights reserved.
//

#import "MyLayoutPos.h"
#import "MyLayoutPosInner.h"
#import "MyBaseLayout.h"



@implementation MyLayoutPos
{
    id _posVal;
    CGFloat _offsetVal;
    MyLayoutPos *_lBoundVal;
    MyLayoutPos *_uBoundVal;
}

-(id)init
{
    self = [super init];
    if (self != nil)
    {
        _active = YES;
        _view = nil;
        _pos = MyMarginGravity_None;
        _posVal = nil;
        _posValType = MyLayoutValueType_Nil;
        _offsetVal = 0;
        _lBoundVal = [[MyLayoutPos alloc] initWithNoBound];
        [_lBoundVal __equalTo:@(-CGFLOAT_MAX)];
        _uBoundVal = [[MyLayoutPos alloc] initWithNoBound];
        [_uBoundVal __equalTo:@(CGFLOAT_MAX)];
    }
    
    return self;
}

-(id)initWithNoBound
{
    self = [super init];
    if (self !=nil)
    {
        _active = YES;
        _view = nil;
        _pos = MyMarginGravity_None;
        _posVal = nil;
        _posValType = MyLayoutValueType_Nil;
        _offsetVal = 0;
    }
    
    return self;
}


-(MyLayoutPos*)__equalTo:(id)val
{
    
    
    if (![_posVal isEqual:val])
    {
        _posVal = val;
        if ([val isKindOfClass:[NSNumber class]])
            _posValType = MyLayoutValueType_NSNumber;
        else if ([val isKindOfClass:[MyLayoutPos class]])
            _posValType = MyLayoutValueType_LayoutPos;
        else if ([val isKindOfClass:[NSArray class]])
            _posValType = MyLayoutValueType_Array;
        else
            _posValType = MyLayoutValueType_Nil;
        
        [self setNeedLayout];
    }
    
    return self;
}

-(MyLayoutPos*)__offset:(CGFloat)val
{
    
    if (_offsetVal != val)
    {
        _offsetVal = val;
        [self setNeedLayout];
    }
    
    return self;
}

-(MyLayoutPos*)__min:(CGFloat)val
{
    
    if (_lBoundVal.posNumVal.doubleValue != val)
    {
        [_lBoundVal __equalTo:@(val)];
        
        [self setNeedLayout];
    }
    
    return self;
}

-(MyLayoutPos*)__lBound:(id)posVal offsetVal:(CGFloat)offsetVal
{
    
    [[_lBoundVal __equalTo:posVal] __offset:offsetVal];
    
    [self setNeedLayout];
    
    return self;
}


-(MyLayoutPos*)__max:(CGFloat)val
{
    
    if (_uBoundVal.posNumVal.doubleValue != val)
    {
        [_uBoundVal __equalTo:@(val)];
        [self setNeedLayout];
    }
    
    return self;
}

-(MyLayoutPos*)__uBound:(id)posVal offsetVal:(CGFloat)offsetVal
{
    
    [[_uBoundVal __equalTo:posVal] __offset:offsetVal];
    
    [self setNeedLayout];
    
    return self;
}



-(void)__clear
{
    _active = YES;
    _posVal = nil;
    _posValType = MyLayoutValueType_Nil;
    _offsetVal = 0;
    [[_lBoundVal __equalTo:@(-CGFLOAT_MAX)] __offset:0];
    [[_uBoundVal __equalTo:@(CGFLOAT_MAX)] __offset:0];
    _lBoundVal.active = YES;
    _uBoundVal.active = YES;
    [self setNeedLayout];
}


-(MyLayoutPos* (^)(id val))myEqualTo
{
    return ^id(id val){
        
        return [self __equalTo:val];
    };
}


-(MyLayoutPos* (^)(CGFloat val))myOffset
{
    return ^id(CGFloat val){
        
        return [self __offset:val];
    };
}


-(MyLayoutPos* (^)(CGFloat val))myMin
{
    return ^id(CGFloat val){
        
        return [self __min:val];
    };
}


-(MyLayoutPos* (^)(CGFloat val))myMax
{
    return ^id(CGFloat val){
        
        return [self __max:val];
    };
}

-(MyLayoutPos* (^)(id posVal, CGFloat offset))myLBound
{
    return ^id(id posVal, CGFloat offset){
        
        return [self __lBound:posVal offsetVal:offset];
    };
}

-(MyLayoutPos* (^)(id posVal, CGFloat offset))myUBound
{
    return ^id(id posVal, CGFloat offset){
        
        return [self __uBound:posVal offsetVal:offset];
    };
}





-(void)myClear
{
    [self __clear];
}


-(MyLayoutPos* (^)(id val))equalTo
{
    return ^id(id val){
        
        return [self __equalTo:val];
    };
}


-(MyLayoutPos* (^)(CGFloat val))offset
{
    return ^id(CGFloat val){

        return [self __offset:val];
    };
}


-(MyLayoutPos* (^)(CGFloat val))min
{
    return ^id(CGFloat val){
    
        return [self __min:val];
    };
}

-(MyLayoutPos* (^)(id posVal, CGFloat offsetVal))lBound
{
    return ^id(id posVal, CGFloat offsetVal){
        
        return [self __lBound:posVal offsetVal:offsetVal];
    };
}


-(MyLayoutPos* (^)(CGFloat val))max
{
    return ^id(CGFloat val){
    
        return [self __max:val];
    };
}

-(MyLayoutPos* (^)(id posVal, CGFloat offsetVal))uBound
{
    return ^id(id posVal, CGFloat offsetVal){
        
        return [self __uBound:posVal offsetVal:offsetVal];
    };
}




-(void)clear
{
    [self __clear];
}


-(void)setActive:(BOOL)active
{
    if (_active != active)
    {
       _active = active;
        _lBoundVal.active = active;
        _uBoundVal.active = active;
      [self setNeedLayout];
    }
}


-(NSNumber*)posNumVal
{
    if (_posVal == nil || !self.isActive)
        return nil;
    
    if (_posValType == MyLayoutValueType_NSNumber)
        return _posVal;
        
    return nil;
    
}



-(MyLayoutPos*)posRelaVal
{
    if (_posVal == nil || !self.isActive)
        return nil;
    
    if (_posValType == MyLayoutValueType_LayoutPos)
        return _posVal;
    
    return nil;
    
}


-(NSArray*)posArrVal
{
    if (_posVal == nil || !self.isActive)
        return nil;
    
    if (_posValType == MyLayoutValueType_Array)
        return _posVal;
    
    return nil;
    
}

-(MyLayoutPos*)lBoundVal
{
    return _lBoundVal;
}

-(MyLayoutPos*)uBoundVal
{
    return _uBoundVal;
}

-(id)posVal
{
    return self.isActive ? _posVal : nil;
}

-(CGFloat)offsetVal
{
    return self.isActive? _offsetVal : 0;
}

-(CGFloat)minVal
{
    return self.isActive ? _lBoundVal.posNumVal.doubleValue : -CGFLOAT_MAX;
}

-(CGFloat)maxVal
{
    return self.isActive ?  _uBoundVal.posNumVal.doubleValue : CGFLOAT_MAX;
}




-(CGFloat)margin
{
    if (self.isActive)
    {
        CGFloat retVal = _offsetVal;
        
        if (self.posNumVal != nil)
            retVal +=self.posNumVal.doubleValue;
        
        retVal = MIN(_uBoundVal.posNumVal.doubleValue, retVal);
        retVal = MAX(_lBoundVal.posNumVal.doubleValue, retVal);
        return retVal;
    }
    else
        return 0;
}

-(BOOL)isRelativeMargin
{
    if (self.isActive)
    {
        CGFloat realMargin = self.posNumVal.doubleValue;
        return realMargin > 0 && realMargin < 1;
        
    }
    else
        return NO;
}

-(CGFloat)realMarginInSize:(CGFloat)size
{
    if (self.isActive)
    {
        CGFloat realMargin = self.posNumVal.doubleValue;
        if (realMargin > 0 && realMargin < 1)
            realMargin *= size;
        
        CGFloat retVal =  realMargin + _offsetVal;
        
        retVal = MIN(_uBoundVal.posNumVal.doubleValue, retVal);
        retVal = MAX(_lBoundVal.posNumVal.doubleValue, retVal);
        return retVal;
    }
    else
        return 0;

}


#pragma mark -- NSCopying  

-(id)copyWithZone:(NSZone *)zone
{
    MyLayoutPos *lp = [[[self class] allocWithZone:zone] init];
    lp->_active = self.isActive;
    lp.view = self.view;
    lp.pos = self.pos;
    lp.posValType = self.posValType;
    lp->_offsetVal = self.offsetVal;
    [[lp->_lBoundVal __equalTo:_lBoundVal.posVal] __offset:_lBoundVal.offsetVal];
    [[lp->_uBoundVal __equalTo:_uBoundVal.posVal] __offset:_uBoundVal.offsetVal];
    lp->_lBoundVal->_active = self.isActive;
    lp->_uBoundVal->_active = self.isActive;
    lp->_posVal = self->_posVal;
    
    return lp;

}


#pragma mark -- Private Method
-(void)setNeedLayout
{
    if (_view != nil && _view.superview != nil && [_view.superview isKindOfClass:[MyBaseLayout class]])
    {
        MyBaseLayout* lb = (MyBaseLayout*)_view.superview;
        if (!lb.isMyLayouting)
            [_view.superview setNeedsLayout];
    }
    
}



+(NSString*)posstrFromPos:(MyLayoutPos*)posobj showView:(BOOL)showView
{
    
    NSString *viewstr = @"";
    if (showView)
    {
        viewstr = [NSString stringWithFormat:@"View:%p.", posobj.view];
    }
    
    NSString *posStr = @"";
    
    switch (posobj.pos) {
        case MyMarginGravity_Horz_Left:
            posStr = @"leftPos";
            break;
        case MyMarginGravity_Horz_Center:
            posStr = @"centerXPos";
            break;
        case MyMarginGravity_Horz_Right:
            posStr = @"rightPos";
            break;
        case MyMarginGravity_Vert_Top:
            posStr = @"topPos";
            break;
        case MyMarginGravity_Vert_Center:
            posStr = @"centerYPos";
            break;
        case MyMarginGravity_Vert_Bottom:
            posStr = @"bottomPos";
            break;
        default:
            break;
    }
    
    return [NSString stringWithFormat:@"%@%@",viewstr,posStr];
    
    
}

-(NSString*)description
{
    NSString *posValStr = @"";
    switch (_posValType) {
        case MyLayoutValueType_Nil:
            posValStr = @"nil";
            break;
        case MyLayoutValueType_NSNumber:
            posValStr = [_posVal description];
            break;
        case MyLayoutValueType_LayoutPos:
            posValStr = [MyLayoutPos posstrFromPos:_posVal showView:YES];
            break;
        case MyLayoutValueType_Array:
        {
            posValStr = @"[";
            for (NSObject *obj in _posVal)
            {
                if ([obj isKindOfClass:[MyLayoutPos class]])
                {
                    posValStr = [posValStr stringByAppendingString:[MyLayoutPos posstrFromPos:(MyLayoutPos*)obj showView:YES]];
                }
                else
                {
                    posValStr = [posValStr stringByAppendingString:[obj description]];
                    
                }
                
                if (obj != [_posVal lastObject])
                    posValStr = [posValStr stringByAppendingString:@", "];
                
            }
            
            posValStr = [posValStr stringByAppendingString:@"]"];
            
        }
        default:
            break;
    }
    
    return [NSString stringWithFormat:@"%@=%@, Offset=%g, Max=%g, Min=%g",[MyLayoutPos posstrFromPos:self showView:NO], posValStr, _offsetVal, _uBoundVal.posNumVal.doubleValue == CGFLOAT_MAX ? NAN : _uBoundVal.posNumVal.doubleValue , _uBoundVal.posNumVal.doubleValue == -CGFLOAT_MAX ? NAN : _lBoundVal.posNumVal.doubleValue];
    
}



@end

