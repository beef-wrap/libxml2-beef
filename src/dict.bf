/*
 * Summary: string dictionary
 * Description: dictionary of reusable strings, just used to avoid allocation
 *         and freeing operations.
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
	 * The dictionary.
	 */
	public struct xmlDict;

	typealias xmlDictPtr = xmlDict*;

	/*
	 * Initializer
	 */
	[CLink, Obsolete("")] public static extern c_int  xmlInitializeDic();

	/*
	 * Constructor and destructor.
	 */
	[CLink] public static extern xmlDictPtr xmlDictCreate();
	[CLink] public static extern size_t xmlDictSetLimit(xmlDictPtr dict, size_t limit);
	[CLink] public static extern size_t xmlDictGetUsage(xmlDictPtr dict);
	[CLink] public static extern xmlDictPtr xmlDictCreateSu(xmlDictPtr sub);
	[CLink] public static extern int xmlDictReferenc(xmlDictPtr dict);
	[CLink] public static extern void xmlDictFree(xmlDictPtr dict);

	/*
	 * Lookup of entry in the dictionary.
	 */
	[CLink] public static extern xmlChar* xmlDictLookup(xmlDictPtr dict, xmlChar* name, c_int len);
	[CLink] public static extern xmlChar* xmlDictExists(xmlDictPtr dict, xmlChar* name, c_int len);
	[CLink] public static extern xmlChar* xmlDictQLookup(xmlDictPtr dict, xmlChar* prefix, xmlChar* name);
	[CLink] public static extern int xmlDictOwns(xmlDictPtr dict, xmlChar* str);
	[CLink] public static extern int xmlDictSize(xmlDictPtr dict);

	/*
	 * Cleanup function
	 */
	[CLink, Obsolete("")] public static extern void xmlDictCleanup();
}