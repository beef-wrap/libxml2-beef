/*
 * Summary: lists interfaces
 * Description: this module implement the list support used in
 * various place in the library.
 *
 * Copy: See Copyright for the status of this software.
 *
 * Author: Gary Pennington <Gary.Pennington@uk.sun.com>
 */

using System;
using System.Interop;

namespace libxml2;

extension libxml2
{
	public struct xmlLink;
	typealias xmlLinkPtr = xmlLink*;

	public struct xmlList;
	typealias xmlListPtr = xmlList*;

	/**
	* xmlListDeallocator:
	* @lk:  the data to deallocate
	*
	* Callback function used to free data from a list.
	*/
	public function void xmlListDeallocator(xmlLinkPtr lk);
	/**
	* xmlListDataCompare:
	* @data0: the first data
	* @data1: the second data
	*
	* Callback function used to compare 2 data.
	*
	* Returns 0 is equality, -1 or 1 otherwise depending on the ordering.
	*/
	public function c_int* xmlListDataCompare(void* data0, void* data1);
	/**
	* xmlListWalker:
	* @data: the data found in the list
	* @user: extra user provided data to the walker
	*
	* Callback function used when walking a list with xmlListWalk().
	*
	* Returns 0 to stop walking the list, 1 otherwise.
	*/
	public function c_int xmlListWalker(void* data, void* user);

	/* Creation/Deletion */
	[CLink] public static extern xmlListPtr xmlListCreate(xmlListDeallocator deallocator, xmlListDataCompare compare);
	[CLink] public static extern void xmlListDelete(xmlListPtr l);

	/* Basic Operators */
	[CLink] public static extern void* xmlListSearch(xmlListPtr l, void* data);
	[CLink] public static extern void* xmlListReverseSearch(xmlListPtr l, void* data);
	[CLink] public static extern int xmlListInsert(xmlListPtr l, void* data);
	[CLink] public static extern int xmlListAppend(xmlListPtr l, void* data);
	[CLink] public static extern int xmlListRemoveFirst(xmlListPtr l, void* data);
	[CLink] public static extern int xmlListRemoveLast(xmlListPtr l, void* data);
	[CLink] public static extern int xmlListRemoveAll(xmlListPtr l, void* data);
	[CLink] public static extern void xmlListClear(xmlListPtr l);
	[CLink] public static extern int xmlListEmpty(xmlListPtr l);
	[CLink] public static extern xmlLinkPtr xmlListFront(xmlListPtr l);
	[CLink] public static extern xmlLinkPtr xmlListEnd(xmlListPtr l);
	[CLink] public static extern int xmlListSize(xmlListPtr l);

	[CLink] public static extern void xmlListPopFront(xmlListPtr l);
	[CLink] public static extern void xmlListPopBack(xmlListPtr l);
	[CLink] public static extern int xmlListPushFront(xmlListPtr l, void* data);
	[CLink] public static extern int xmlListPushBack(xmlListPtr l, void* data);

	/* Advanced Operators */
	[CLink] public static extern void xmlListReverse(xmlListPtr l);
	[CLink] public static extern void xmlListSort(xmlListPtr l);
	[CLink] public static extern void xmlListWalk(xmlListPtr l, xmlListWalker walker, void* user);
	[CLink] public static extern void xmlListReverseWalk(xmlListPtr l, xmlListWalker walker, void* user);
	[CLink] public static extern void xmlListMerge(xmlListPtr l1, xmlListPtr l2);
	[CLink] public static extern xmlListPtr xmlListDup(xmlListPtr old);
	[CLink] public static extern int xmlListCopy(xmlListPtr cur, xmlListPtr old);

	/* Link operators */
	[CLink] public static extern void* xmlLinkGetData(xmlLinkPtr lk);

	/* xmlListUnique() */
	/* xmlListSwap */
}