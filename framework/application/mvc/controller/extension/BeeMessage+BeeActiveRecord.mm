//
//	 ______    ______    ______
//	/\  __ \  /\  ___\  /\  ___\
//	\ \  __<  \ \  __\_ \ \  __\_
//	 \ \_____\ \ \_____\ \ \_____\
//	  \/_____/  \/_____/  \/_____/
//
//
//	Copyright (c) 2013-2014, {Bee} open source community
//	http://www.bee-framework.com
//
//
//	Permission is hereby granted, free of charge, to any person obtaining a
//	copy of this software and associated documentation files (the "Software"),
//	to deal in the Software without restriction, including without limitation
//	the rights to use, copy, modify, merge, publish, distribute, sublicense,
//	and/or sell copies of the Software, and to permit persons to whom the
//	Software is furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in
//	all copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//	FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
//	IN THE SOFTWARE.
//

#import "BeeMessage+BeeActiveRecord.h"
#import "BeeMessage+BeeNetwork.h"

// ----------------------------------
// Source code
// ----------------------------------

#pragma mark -

@implementation BeeMessage(BeeActiveRecord)

@dynamic responseRecord;
@dynamic responseRecords;
@dynamic responseRecordAtPath;
@dynamic responseRecordsAtPath;

- (BeeMessageActiveRecordBlockC)responseRecord
{
	BeeMessageActiveRecordBlockC block = ^ BeeActiveRecord * ( Class clazz )
	{
		NSObject * obj = self.responseString;
		if ( nil == obj )
			return nil;
		
		BeeActiveRecord * record = [(BeeActiveRecord *)[[clazz alloc] initWithObject:obj] autorelease];
		if ( nil == record )
			return nil;
		
		return record;
	};
	
	return [[block copy] autorelease];
}

- (BeeMessageArrayBlockC)responseRecords
{
	BeeMessageArrayBlockC block = ^ NSArray * ( Class clazz )
	{
		NSObject * obj = self.responseString;
		if ( nil == obj || NO == [obj isKindOfClass:[NSArray class]] )
			return nil;
		
		NSMutableArray * array = [[[NSMutableArray alloc] init] autorelease];
		if ( nil == array )
			return nil;
		
		for ( NSObject * elem in (NSArray *)obj )
		{
			BeeActiveRecord * record = [(BeeActiveRecord *)[[clazz alloc] initWithObject:obj] autorelease];
			if ( nil == record )
				return nil;
			
			[array addObject:record];
		}

		return array.count ? array : nil;
	};
	
	return [[block copy] autorelease];
}

- (BeeMessageActiveRecordBlockCS)responseRecordAtPath
{
	BeeMessageActiveRecordBlockCS block = ^ BeeActiveRecord * ( Class clazz, NSString * path )
	{
		NSObject * obj = self.responseString;
		if ( nil == obj || NO == [obj isKindOfClass:[NSDictionary class]] )
			return nil;
		
		obj = [(NSDictionary *)obj objectAtPath:path];
		if ( nil == obj )
			return nil;

		BeeActiveRecord * record = [(BeeActiveRecord *)[[clazz alloc] initWithObject:obj] autorelease];
		if ( nil == record )
			return nil;

		return record;
	};
	
	return [[block copy] autorelease];
}

- (BeeMessageArrayBlockCS)responseRecordsAtPath
{
	BeeMessageArrayBlockCS block = ^ NSArray * ( Class clazz, NSString * path )
	{
		NSObject * obj = self.responseString;
		if ( nil == obj || NO == [obj isKindOfClass:[NSDictionary class]] )
			return nil;
		
		obj = [(NSDictionary *)obj objectAtPath:path];
		if ( nil == obj || NO == [obj isKindOfClass:[NSArray class]] )
			return nil;

		NSMutableArray * array = [[[NSMutableArray alloc] init] autorelease];
		if ( nil == array )
			return nil;

		for ( NSObject * elem in (NSArray *)obj )
		{
			BeeActiveRecord * record = [(BeeActiveRecord *)[[clazz alloc] initWithObject:obj] autorelease];
			if ( nil == record )
				return nil;

			[array addObject:record];
		}
		
		return array.count ? array : nil;
	};
	
	return [[block copy] autorelease];
}

@end

// ----------------------------------
// Unit test
// ----------------------------------

#if defined(__BEE_UNITTEST__) && __BEE_UNITTEST__

#pragma mark -

TEST_CASE( BeeMessage_BeeActiveRecord )
{
}
TEST_CASE_END

#endif	// #if defined(__BEE_UNITTEST__) && __BEE_UNITTEST__
