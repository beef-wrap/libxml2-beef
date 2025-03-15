/*
 * Summary: Chained hash tables
 * Description: This module implements the hash table support used in
 *		various places in the library.
 *
 * Copy: See Copyright for the status of this software.
 *
 * Author: Bjorn Reese <bjorn.reese@systematic.dk>
 */

using System;
using System.Interop;

namespace libxml2;

extension libxml2
{
	/*
	* The hash table.
	*/
	public struct xmlHashTable;
	typealias xmlHashTablePtr = xmlHashTable*;

	/*
	* Recent version of gcc produce a warning when a function pointer is assigned
	* to an object pointer, or vice versa.  The following macro is a dirty hack
	* to allow suppression of the warning.  If your architecture has function
	* pointers which are a different size than a void pointer, there may be some
	* serious trouble within the library.
	*/
	/**
	* XML_CAST_FPTR:
	* @fptr:  pointer to a function
	*
	* Macro to do a casting from an object pointer to a
	* function pointer without encountering a warning from
	* gcc
	*
	* #define XML_CAST_FPTR(fptr) (*(void **)(&fptr))
	* This macro violated ISO C aliasing rules (gcc4 on s390 broke)
	* so it is disabled now
	*/

	//#define XML_CAST_FPTR(fptr) fptr

	/*
	* function types:
	*/
	/**
	* xmlHashDeallocator:
	* @payload:  the data in the hash
	* @name:  the name associated
	*
	* Callback to free data from a hash.
	*/
	public function void xmlHashDeallocator(void* payload, xmlChar* name);
	/**
	* xmlHashCopier:
	* @payload:  the data in the hash
	* @name:  the name associated
	*
	* Callback to copy data from a hash.
	*
	* Returns a copy of the data or NULL in case of error.
	*/
	public function void* xmlHashCopier(void* payload, xmlChar* name);
	/**
	* xmlHashScanner:
	* @payload:  the data in the hash
	* @data:  extra scanner data
	* @name:  the name associated
	*
	* Callback when scanning data in a hash with the simple scanner.
	*/
	public function void xmlHashScanner(void* payload, void* data, xmlChar* name);
	/**
	* xmlHashScannerFull:
	* @payload:  the data in the hash
	* @data:  extra scanner data
	* @name:  the name associated
	* @name2:  the second name associated
	* @name3:  the third name associated
	*
	* Callback when scanning data in a hash with the full scanner.
	*/
	public function void xmlHashScannerFull(void* payload, void* data, xmlChar* name, xmlChar* name2, xmlChar* name3);

	/*
	* Constructor and destructor.
	*/
	[CLink] public static extern xmlHashTablePtr xmlHashCreate(c_int size);
	[CLink] public static extern xmlHashTablePtr xmlHashCreateDict(c_int size, xmlDictPtr dict);
	[CLink] public static extern void xmlHashFree(xmlHashTablePtr hash, xmlHashDeallocator dealloc);
	[CLink] public static extern void xmlHashDefaultDeallocato(void* entry, xmlChar* name);

	/*
	* Add a new entry to the hash table.
	*/
	[CLink] public static extern int xmlHashAdd(xmlHashTablePtr hash, xmlChar* name, void* userdata);
	[CLink] public static extern int xmlHashAddEntry(xmlHashTablePtr hash, xmlChar* name, void* userdata);
	[CLink] public static extern int xmlHashUpdateEntry(xmlHashTablePtr hash, xmlChar* name, void* userdata, xmlHashDeallocator dealloc);
	[CLink] public static extern int xmlHashAdd2(xmlHashTablePtr hash, xmlChar* name, xmlChar* name2, void* userdata);
	[CLink] public static extern int xmlHashAddEntry2(xmlHashTablePtr hash, xmlChar* name, xmlChar* name2, void* userdata);
	[CLink] public static extern int xmlHashUpdateEntry2(xmlHashTablePtr hash, xmlChar* name, xmlChar* name2, void* userdata, xmlHashDeallocator dealloc);
	[CLink] public static extern int xmlHashAdd3(xmlHashTablePtr hash, xmlChar* name, xmlChar* name2, xmlChar* name3, void* userdata);
	[CLink] public static extern int xmlHashAddEntry3(xmlHashTablePtr hash, xmlChar* name, xmlChar* name2, xmlChar* name3, void* userdata);
	[CLink] public static extern int xmlHashUpdateEntry3(xmlHashTablePtr hash, xmlChar* name, xmlChar* name2, xmlChar* name3, void* userdata, xmlHashDeallocator dealloc);

	/*
	* Remove an entry from the hash table.
	*/
	[CLink] public static extern int xmlHashRemoveEntry(xmlHashTablePtr hash, xmlChar* name, xmlHashDeallocator dealloc);
	[CLink] public static extern int xmlHashRemoveEntry2(xmlHashTablePtr hash, xmlChar* name, xmlChar* name2, xmlHashDeallocator dealloc);
	[CLink] public static extern c_int xmlHashRemoveEntry3(xmlHashTablePtr hash, xmlChar* name, xmlChar* name2, xmlChar* name3, xmlHashDeallocator dealloc);

	/*
	* Retrieve the payload.
	*/
	[CLink] public static extern void* xmlHashLookup(xmlHashTablePtr hash, xmlChar* name);
	[CLink] public static extern void* xmlHashLookup2(xmlHashTablePtr hash, xmlChar* name, xmlChar* name2);
	[CLink] public static extern void* xmlHashLookup3(xmlHashTablePtr hash, xmlChar* name, xmlChar* name2, xmlChar* name3);
	[CLink] public static extern void* xmlHashQLookup(xmlHashTablePtr hash, xmlChar* prefix, xmlChar* name);
	[CLink] public static extern void* xmlHashQLookup2(xmlHashTablePtr hash, xmlChar* prefix, xmlChar* name, xmlChar* prefix2, xmlChar* name2);
	[CLink] public static extern void* xmlHashQLookup3(xmlHashTablePtr hash, xmlChar* prefix, xmlChar* name, xmlChar* prefix2, xmlChar* name2, xmlChar* prefix3, xmlChar* name3);

	/*
	* Helpers.
	*/
	[CLink] public static extern xmlHashTablePtr xmlHashCopySafe(xmlHashTablePtr hash, xmlHashCopier copy, xmlHashDeallocator dealloc);
	[CLink] public static extern xmlHashTablePtr xmlHashCopy(xmlHashTablePtr hash, xmlHashCopier copy);
	[CLink] public static extern int xmlHashSize(xmlHashTablePtr hash);
	[CLink] public static extern void xmlHashScan(xmlHashTablePtr hash, xmlHashScanner scan, void* data);
	[CLink] public static extern void xmlHashScan3(xmlHashTablePtr hash, xmlChar* name, xmlChar* name2, xmlChar* name3, xmlHashScanner scan, void* data);
	[CLink] public static extern void xmlHashScanFull(xmlHashTablePtr hash, xmlHashScannerFull scan, void* data);
	[CLink] public static extern void xmlHashScanFull3(xmlHashTablePtr hash, xmlChar* name, xmlChar* name2, xmlChar* name3, xmlHashScannerFull scan, void* data);
}