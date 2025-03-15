/*
 * Summary: interface for the memory allocator
 * Description: provides interfaces for the memory allocator,
 *              including debugging capabilities.
 *
 * Copy: See Copyright for the status of this software.
 *
 * Author: Daniel Veillard
 */

using System;
using System.Interop;

namespace libxml2;

extension libxml2
{
	/*
	* The XML memory wrapper support 4 basic overloadable functions.
	*/
	/**
	* xmlFreeFunc:
	* @mem: an already allocated block of memory
	*
	* Signature for a free() implementation.
	*/
	public function void xmlFreeFunc(void* mem);
	/**
	* xmlMallocFunc:
	* @size:  the size requested in bytes
	*
	* Signature for a malloc() implementation.
	*
	* Returns a pointer to the newly allocated block or NULL in case of error.
	*/
	public function void* xmlMallocFunc(size_t size);

	/**
	* xmlReallocFunc:
	* @mem: an already allocated block of memory
	* @size:  the new size requested in bytes
	*
	* Signature for a realloc() implementation.
	*
	* Returns a pointer to the newly reallocated block or NULL in case of error.
	*/
	public function void* xmlReallocFunc(void* mem, size_t size);

	/**
	* xmlStrdupFunc:
	* @str: a zero terminated string
	*
	* Signature for an strdup() implementation.
	*
	* Returns the copy of the string or NULL in case of error.
	*/
	public function char* xmlStrdupFunc(char* str);

	/*
	* In general the memory allocation entry points are not kept
	* thread specific but this can be overridden by LIBXML_THREAD_ALLOC_ENABLED
	*    - xmlMalloc
	*    - xmlMallocAtomic
	*    - xmlRealloc
	*    - xmlMemStrdup
	*    - xmlFree
	*/
	/** DOC_DISABLE */
	// #if LIBXML_THREAD_ALLOC_ENABLED
	//   #define XML_GLOBALS_ALLOC \
	//     XML_OP(xmlMalloc, xmlMallocFunc, XML_NO_ATTR) \
	//     XML_OP(xmlMallocAtomic, xmlMallocFunc, XML_NO_ATTR) \
	//     XML_OP(xmlRealloc, xmlReallocFunc, XML_NO_ATTR) \
	//     XML_OP(xmlFree, xmlFreeFunc, XML_NO_ATTR) \
	//     XML_OP(xmlMemStrdup, xmlStrdupFunc, XML_NO_ATTR)
	//   #define XML_OP XML_DECLARE_GLOBAL
	//     XML_GLOBALS_ALLOC
	//   #undef XML_OP
	//   #if defined(LIBXML_THREAD_ENABLED) && !defined(XML_GLOBALS_NO_REDEFINITION)
	//     #define xmlMalloc XML_GLOBAL_MACRO(xmlMalloc)
	//     #define xmlMallocAtomic XML_GLOBAL_MACRO(xmlMallocAtomic)
	//     #define xmlRealloc XML_GLOBAL_MACRO(xmlRealloc)
	//     #define xmlFree XML_GLOBAL_MACRO(xmlFree)
	//     #define xmlMemStrdup XML_GLOBAL_MACRO(xmlMemStrdup)
	//   #endif
	// #else
	//   #define XML_GLOBALS_ALLOC
	// /** DOC_ENABLE */
	//   XMLPUBVAR xmlMallocFunc xmlMalloc;
	//   XMLPUBVAR xmlMallocFunc xmlMallocAtomic;
	//   XMLPUBVAR xmlReallocFunc xmlRealloc;
	//   XMLPUBVAR xmlFreeFunc xmlFree;
	//   XMLPUBVAR xmlStrdupFunc xmlMemStrdup;
	// #endif

	/*
	* The way to overload the existing functions.
	* The xmlGc function have an extra entry for atomic block
	* allocations useful for garbage collected memory allocators
	*/
	[CLink] public static extern int xmlMemSetup(xmlFreeFunc freeFunc, xmlMallocFunc mallocFunc, xmlReallocFunc reallocFunc, xmlStrdupFunc strdupFunc);
	[CLink] public static extern int xmlMemGet(xmlFreeFunc* freeFunc, xmlMallocFunc* mallocFunc, xmlReallocFunc* reallocFunc, xmlStrdupFunc* strdupFunc);
	[CLink, Obsolete("")] public static extern int xmlGcMemSetup(xmlFreeFunc freeFunc, xmlMallocFunc mallocFunc, xmlMallocFunc mallocAtomicFunc, xmlReallocFunc reallocFunc, xmlStrdupFunc strdupFunc);
	[CLink, Obsolete("")] public static extern int xmlGcMemGet(xmlFreeFunc* freeFunc, xmlMallocFunc* mallocFunc, xmlMallocFunc* mallocAtomicFunc, xmlReallocFunc* reallocFunc, xmlStrdupFunc* strdupFunc);

	/*
	* Initialization of the memory layer.
	*/

	[CLink, Obsolete("")] public static extern int xmlInitMemory();

	/*
	* Cleanup of the memory layer.
	*/

	[CLink, Obsolete("")] public static extern void xmlCleanupMemory();
	/*
	* These are specific to the XML debug memory wrapper.
	*/
	[CLink] public static extern size_t xmlMemSize	(void* ptr);
	[CLink] public static extern int xmlMemUsed	();
	[CLink] public static extern int xmlMemBlocks();
	[CLink, Obsolete("")] public static extern void xmlMemDisplay(FILE* fp);
	[CLink, Obsolete("")] public static extern void xmlMemDisplayLast(FILE* fp, c_long nbBytes);
	[CLink, Obsolete("")] public static extern void xmlMemShow(FILE* fp, c_int nr);
	[CLink, Obsolete("")] public static extern void xmlMemoryDump();
	[CLink] public static extern void* xmlMemMalloc(size_t size);
	[CLink] public static extern void* xmlMemRealloc(void* ptr, size_t size);
	[CLink] public static extern void xmlMemFree(void* ptr);
	[CLink] public static extern char* xmlMemoryStrdup(char* str);
	[CLink, Obsolete("")] public static extern void* xmlMallocLoc(size_t size, char* file, c_int line);
	[CLink, Obsolete("")] public static extern void* xmlReallocLoc(void* ptr, size_t size, char* file, c_int line);
	[CLink, Obsolete("")] public static extern void* xmlMallocAtomicLoc(size_t size, char* file, c_int line);
	[CLink, Obsolete("")] public static extern char* xmlMemStrdupLoc(char* str, char* file, c_int line);
}