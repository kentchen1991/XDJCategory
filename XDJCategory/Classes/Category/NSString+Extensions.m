
#import "NSString+Extensions.h"
//#import "XDJDebug.h"

@implementation NSString (Extensions)
//////////////sjb add 16.3.14
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (CGSize)sizeWithFont:(UIFont *)font maxH:(CGFloat)maxH{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(MAXFLOAT,maxH);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (CGSize)sizeWithFont:(UIFont *)font size:(CGSize)size{
    CGSize resultSize = CGSizeZero;
    if (self.length <= 0) {
        return resultSize;
    }
    resultSize = [self boundingRectWithSize:size
                                    options:(NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin)
                                 attributes:@{NSFontAttributeName: font}
                                    context:nil].size;
    resultSize = CGSizeMake(MIN(size.width, ceilf(resultSize.width)), MIN(size.height, ceilf(resultSize.height)));
    return resultSize;
}

- (CGSize)sizeWithFont:(UIFont *)font
{
    return [self sizeWithFont:font maxW:MAXFLOAT];
}

// ///////////////////////////////////////////////////////////////////////////

/**
 返回当前字符串对应的二维码图像
 
 二维码的实现是将字符串传递给滤镜，滤镜直接转换生成二维码图片
 */
- (UIImage *)createQRCode
{
    // 1. 实例化一个滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    CIImage *outputImage = [filter outputImage];
    return [UIImage imageWithCIImage:outputImage];
}



-(BOOL)isNotEmpty
{
	return [self length] > 0;		
}
-(BOOL)isContain:(NSString*)asubstr
{
	NSRange rg = [self rangeOfString:asubstr];
	return rg.length>0; 
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isWhitespaceAndNewlines {
  NSCharacterSet* whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
  for (NSInteger i = 0; i < self.length; ++i) {
    unichar c = [self characterAtIndex:i];
    if (![whitespace characterIsMember:c]) {
      return NO;
    }
  }
  return YES;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
/**
 * Deprecated - https://github.com/facebook/three20/issues/367
 */
- (BOOL)isEmptyOrWhitespace {
  // A nil or NULL string is not the same as an empty string
  return 0 == self.length ||
         ![self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length;
}

+ (BOOL)isBlank:(NSString *)str{
    return str == nil || [str isEmptyOrWhitespace]; 
}

+ (BOOL)isNotBlank:(NSString *)str{
    return ![NSString isBlank:str];
}

+ (BOOL)isNumeric:(NSString *)str{
    NSScanner *scanner = [NSScanner scannerWithString:str];
    NSInteger hold;
    if ([scanner scanInteger:&hold] && [scanner isAtEnd]) return YES;
    return NO;
}

+ (NSString *)base64StringFromData:(NSData *)data length:(int)length{
    char base64EncodingTable[64] = {
        'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
        'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f',
        'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
        'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '+', '/'
    };
    unsigned long ixtext, lentext;
    long ctremaining;
    unsigned char input[3], output[4];
    short i, charsonline = 0, ctcopy;
    const unsigned char *raw;
    NSMutableString *result;
    
    lentext = [data length]; 
    if (lentext < 1)
        return @"";
    result = [NSMutableString stringWithCapacity: lentext];
    raw = [data bytes];
    ixtext = 0; 
    
    while (true) {
        ctremaining = lentext - ixtext;
        if (ctremaining <= 0) 
            break;        
        for (i = 0; i < 3; i++) { 
            unsigned long ix = ixtext + i;
            if (ix < lentext)
                input[i] = raw[ix];
            else
                input[i] = 0;
        }
        output[0] = (input[0] & 0xFC) >> 2;
        output[1] = ((input[0] & 0x03) << 4) | ((input[1] & 0xF0) >> 4);
        output[2] = ((input[1] & 0x0F) << 2) | ((input[2] & 0xC0) >> 6);
        output[3] = input[2] & 0x3F;
        ctcopy = 4;
        switch (ctremaining) {
            case 1: 
                ctcopy = 2; 
                break;
            case 2: 
                ctcopy = 3; 
                break;
        }
        
        for (i = 0; i < ctcopy; i++)
            [result appendString: [NSString stringWithFormat: @"%c", base64EncodingTable[output[i]]]];
        
        for (i = ctcopy; i < 4; i++)
            [result appendString: @"="];
        
        ixtext += 3;
        charsonline += 4;
        
        if ((length > 0) && (charsonline >= length))
            charsonline = 0;
    }     
    return result;
}

-(BOOL)isPhoneNumber {
    NSString *mobileRegex = @"^(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",mobileRegex];
    return  [predicate evaluateWithObject:self];
}

-(BOOL)isLetterAndNumber {
    NSString *letterAndNumberRegex = @"^[A-Za-z0-9]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",letterAndNumberRegex];
    return  [predicate evaluateWithObject:self];
}

// sjb 16.3.2 add
-(BOOL)isIp {
    NSString *number_reg = @"(\\d|\\d{2}|25[0-5]|2[0-4]\\d|1\\d{2})";
    NSString *reg = [NSString stringWithFormat:@"%@\\.%@\\.%@\\.%@/%@\\.%@\\.%@\\.%@",number_reg,number_reg,number_reg,number_reg,number_reg,number_reg,number_reg,number_reg];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",reg];
    return  [predicate evaluateWithObject:self];
}

-(BOOL)isEmail {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailRegex];
    return  [predicate evaluateWithObject:self];
}

- (BOOL)isPassword {
    NSString *passwordRegex = @"(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).{6,20}";  //@"^[a-zA-Z0-9_]{6,15}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passwordRegex];
    return  [predicate evaluateWithObject:self];
}

- (BOOL)isCardID {
    NSString *limit = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",limit];
    return  [predicate evaluateWithObject:self];
}

- (BOOL)isChineseName {
    NSString *limit = @"[\u4E00-\u9FA5]{2,5}(?:·[\u4E00-\u9FA5]{2,5})*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",limit];
    return  [predicate evaluateWithObject:self];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)stringByRemovingHTMLTags {
//  TTMarkupStripper* stripper = [[[TTMarkupStripper alloc] init] autorelease];
//  return [stripper parse:self];
//    MY_TODO();
//    MY_ASSERT(0);
//    MY_ASSERT(0 && @"TODO" != NULL);
    return nil;
}

-(BOOL) isPhoneNumberOrEmail
{
    return [self isEmail] || [self isPhoneNumber];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
/**
 * Copied and pasted from http://www.mail-archive.com/cocoa-dev@lists.apple.com/msg28175.html
 * Deprecated
 */
//- (NSDictionary*)queryDictionaryUsingEncoding:(NSStringEncoding)encoding {
//  NSCharacterSet* delimiterSet = [NSCharacterSet characterSetWithCharactersInString:@"&;"];
//  NSMutableDictionary* pairs = [NSMutableDictionary dictionary];
//  NSScanner* scanner = [[[NSScanner alloc] initWithString:self] autorelease];
//  while (![scanner isAtEnd]) {
//    NSString* pairString = nil;
//    [scanner scanUpToCharactersFromSet:delimiterSet intoString:&pairString];
//    [scanner scanCharactersFromSet:delimiterSet intoString:NULL];
//    NSArray* kvPair = [pairString componentsSeparatedByString:@"="];
//    if (kvPair.count == 2) {
//      NSString* key = [[kvPair objectAtIndex:0]
//                       stringByReplacingPercentEscapesUsingEncoding:encoding];
//      NSString* value = [[kvPair objectAtIndex:1]
//                         stringByReplacingPercentEscapesUsingEncoding:encoding];
//      [pairs setObject:value forKey:key];
//    }
//  }
//
//  return [NSDictionary dictionaryWithDictionary:pairs];
//}
//
/////////////////////////////////////////////////////////////////////////////////////////////////////
//- (NSDictionary*)queryContentsUsingEncoding:(NSStringEncoding)encoding {
//  NSCharacterSet* delimiterSet = [NSCharacterSet characterSetWithCharactersInString:@"&;"];
//  NSMutableDictionary* pairs = [NSMutableDictionary dictionary];
//  NSScanner* scanner = [[[NSScanner alloc] initWithString:self] autorelease];
//  while (![scanner isAtEnd]) {
//    NSString* pairString = nil;
//    [scanner scanUpToCharactersFromSet:delimiterSet intoString:&pairString];
//    [scanner scanCharactersFromSet:delimiterSet intoString:NULL];
//    NSArray* kvPair = [pairString componentsSeparatedByString:@"="];
//    if (kvPair.count == 1 || kvPair.count == 2) {
//      NSString* key = [[kvPair objectAtIndex:0]
//                       stringByReplacingPercentEscapesUsingEncoding:encoding];
//      NSMutableArray* values = [pairs objectForKey:key];
//      if (nil == values) {
//        values = [NSMutableArray array];
//        [pairs setObject:values forKey:key];
//      }
//      if (kvPair.count == 1) {
//        [values addObject:[NSNull null]];
//
//      } else if (kvPair.count == 2) {
//        NSString* value = [[kvPair objectAtIndex:1]
//                           stringByReplacingPercentEscapesUsingEncoding:encoding];
//        [values addObject:value];
//      }
//    }
//  }
//  return [NSDictionary dictionaryWithDictionary:pairs];
//}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)stringByAddingQueryDictionary:(NSDictionary*)query {
  NSMutableArray* pairs = [NSMutableArray array];
  for (NSString* key in [query keyEnumerator]) {
    NSString* value = [query objectForKey:key];
    value = [value stringByReplacingOccurrencesOfString:@"?" withString:@"%3F"];
    value = [value stringByReplacingOccurrencesOfString:@"=" withString:@"%3D"];
    NSString* pair = [NSString stringWithFormat:@"%@=%@", key, value];
    [pairs addObject:pair];
  }

  NSString* params = [pairs componentsJoinedByString:@"&"];
  if ([self rangeOfString:@"?"].location == NSNotFound) {
    return [self stringByAppendingFormat:@"?%@", params];

  } else {
    return [self stringByAppendingFormat:@"&%@", params];
  }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSComparisonResult)versionStringCompare:(NSString *)other {
  NSArray *oneComponents = [self componentsSeparatedByString:@"a"];
  NSArray *twoComponents = [other componentsSeparatedByString:@"a"];

  // The parts before the "a"
  NSString *oneMain = [oneComponents objectAtIndex:0];
  NSString *twoMain = [twoComponents objectAtIndex:0];

  // If main parts are different, return that result, regardless of alpha part
  NSComparisonResult mainDiff;
  if ((mainDiff = [oneMain compare:twoMain]) != NSOrderedSame) {
    return mainDiff;
  }

  // At this point the main parts are the same; just deal with alpha stuff
  // If one has an alpha part and the other doesn't, the one without is newer
  if ([oneComponents count] < [twoComponents count]) {
    return NSOrderedDescending;

  } else if ([oneComponents count] > [twoComponents count]) {
    return NSOrderedAscending;

  } else if ([oneComponents count] == 1) {
    // Neither has an alpha part, and we know the main parts are the same
    return NSOrderedSame;
  }

  // At this point the main parts are the same and both have alpha parts. Compare the alpha parts
  // numerically. If it's not a valid number (including empty string) it's treated as zero.
  NSNumber *oneAlpha = [NSNumber numberWithInt:[[oneComponents objectAtIndex:1] intValue]];
  NSNumber *twoAlpha = [NSNumber numberWithInt:[[twoComponents objectAtIndex:1] intValue]];
  return [oneAlpha compare:twoAlpha];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
//- (NSString*)md5Hash {
//  return [[self dataUsingEncoding:NSUTF8StringEncoding] md5Hash];
//}


///////////////////////////////////////////////////////////////////////////////////////////////////
//- (NSString*)sha1Hash {
//  return [[self dataUsingEncoding:NSUTF8StringEncoding] sha1Hash];
//}


+(NSString*) stringWithUUID {
//    CFUUIDRef    uuidObj = CFUUIDCreate(nil);//create a new UUID
    //get the string representation of the UUID
    NSString    *uuidString = [[NSUUID UUID] UUIDString];
//    CFRelease(uuidObj);
//    return [uuidString autorelease];
    return uuidString;
}

-(NSString*)trim
{
    return  [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

-(NSString*)trimBegin:(NSString*)strBegin
{
    if ([strBegin length]==0) {
        return self;
    }
    if ([self hasPrefix:strBegin]) {
        return [self substringFromIndex:[strBegin length]];
    }else
        return self;
}

-(NSString*)trimEnd:(NSString*)strEnd
{
    if ([strEnd length]==0) {
        return self;
    }
    if ([self hasSuffix:strEnd]) {
        return [self substringToIndex:[self length]-[strEnd length]];
    }
    return self;
}

-(NSString*)trim:(NSString*)strTrim
{
    return  [self trimEnd:[self trimBegin:strTrim]];
}

-(NSString*)replaceOldString:(NSString*) strOld WithNewString:(NSString*) strNew
{
    NSMutableString* strMutale = [NSMutableString stringWithString:self];
    NSRange r;
    r.location = 0; r.length = [self length];
    [strMutale replaceOccurrencesOfString:strOld withString:strNew options:NSCaseInsensitiveSearch range:r];
    return [NSString stringWithString:strMutale];
}

-(NSString*)replaceCRWithNewLine
{
    return [self replaceOldString:@"{CR}" WithNewString:@"\n"];
}

+(NSString *)telephonestr:(NSString *)telephoneNum
{
    NSString *oldStr = telephoneNum;
    const char *oldCStr = [oldStr UTF8String];
    int iLen = (int)strlen(oldCStr);
    // 4个4个一组
    int iGroup = (int)(iLen / 4);
    char *newCStr = malloc(sizeof(char) * iLen + iGroup + 1);
    char *toBeFree = newCStr;
    int iRemain = iLen % 4;
    if (iRemain != 0) {
        memcpy(newCStr, oldCStr, iRemain);
        newCStr += iRemain;
        oldCStr += iRemain;
        *(newCStr++) = ' ';
    }
    while (iGroup != 0) {
        memcpy(newCStr, oldCStr, 4);
        newCStr += 4;
        oldCStr += 4;
        *(newCStr++) = ' ';
        iGroup --;
    }
    *(--newCStr) = '\0';
    NSString *newStr = [NSString stringWithUTF8String:toBeFree];
    free(toBeFree);
    
    return newStr;
}

-(NSString *)normalNumToBankNum{
    NSString *tmpStr = [self bankNumToNormalNum];

    int size =(int)(tmpStr.length / 4);
    
    NSMutableArray *tmpStrArr = [[NSMutableArray alloc] init];
    for (int n = 0;n < size; n++)
    {
        [tmpStrArr addObject:[tmpStr substringWithRange:NSMakeRange(n*4, 4)]];
    }
    
    [tmpStrArr addObject:[tmpStr substringWithRange:NSMakeRange(size*4, (tmpStr.length % 4))]];
    
    tmpStr = [tmpStrArr componentsJoinedByString:@" "];
    
    return tmpStr;
}

-(NSString *)bankNumToNormalNum
{
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

+(NSString *)telephoneStarstr:(NSString *)telephoneNum{
    NSString *oldStr = telephoneNum;
    NSString *newStr=[oldStr stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    return newStr;
}
+(NSString *)bankIDStarstr:(NSString *)bankId{
    NSString *oldStr = bankId;
    NSInteger count=bankId.length;
    NSString *first =[oldStr substringToIndex:4];
    NSString *tail =[oldStr substringFromIndex:count-3];
    NSString *newStr=[NSString stringWithFormat:@"%@ **** **** %@",first,tail];
    return newStr;
}
@end
