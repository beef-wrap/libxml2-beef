/*
 * Summary: set of routines to process strings
 * Description: type and interfaces needed for the internal string handling
 *              of the library, especially UTF8 processing.
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
	typealias va_list = void*;

	/**
	* xmlChar:
	*
	* This is a basic byte in an UTF-8 encoded string.
	* It's unsigned allowing to pinpoint case where char * are assigned
	* to xmlChar* (possibly making serialization back impossible).
	*/
	public typealias xmlChar = c_uchar;

	/**
	* BAD_CAST:
	*
	* Macro to cast a string to an xmlChar* when one know its safe.
	*/
	// #define BAD_CAST (xmlChar*)

	/*
	* xmlChar handling
	*/
	[CLink] public static extern xmlChar* xmlStrdup(xmlChar* cur);
	[CLink] public static extern xmlChar* xmlStrndup(xmlChar* cur, c_int len);
	[CLink] public static extern xmlChar* xmlCharStrndup(char* cur, c_int len);
	[CLink] public static extern xmlChar* xmlCharStrdup(char* cur);
	[CLink] public static extern xmlChar* xmlStrsub(xmlChar* str, c_int start, c_int len);
	[CLink] public static extern xmlChar* xmlStrchr(xmlChar* str, xmlChar val);
	[CLink] public static extern xmlChar* xmlStrstr(xmlChar* str, xmlChar* val);
	[CLink] public static extern xmlChar* xmlStrcasestr(xmlChar* str, xmlChar* val);
	[CLink] public static extern int xmlStrcmp(xmlChar* str1, xmlChar* str2);
	[CLink] public static extern int xmlStrncmp(xmlChar* str1, xmlChar* str2, c_int len);
	[CLink] public static extern int xmlStrcasecmp(xmlChar* str1, xmlChar* str2);
	[CLink] public static extern int xmlStrncasecmp(xmlChar* str1, xmlChar* str2, c_int len);
	[CLink] public static extern int xmlStrEqual(xmlChar* str1, xmlChar* str2);
	[CLink] public static extern int xmlStrQEqual(xmlChar* pref, xmlChar* name, xmlChar* str);
	[CLink] public static extern int xmlStrlen(xmlChar* str);
	[CLink] public static extern xmlChar* xmlStrcat(xmlChar* cur, xmlChar* add);
	[CLink] public static extern xmlChar* xmlStrncat(xmlChar* cur, xmlChar* add, c_int len);
	[CLink] public static extern xmlChar* xmlStrncatNew(xmlChar* str1, xmlChar* str2, c_int len);
	[CLink] public static extern int xmlStrPrintf(xmlChar* buf, c_int len, char* msg, ...);
	[CLink] public static extern int xmlStrVPrintf(xmlChar* buf, c_int len, char* msg, va_list ap);

	[CLink] public static extern int xmlGetUTF8Char(c_uchar* utf, c_int* len);
	[CLink] public static extern int xmlCheckUTF8(c_uchar* utf);
	[CLink] public static extern int xmlUTF8Strsize(xmlChar* utf, c_int len);
	[CLink] public static extern xmlChar* xmlUTF8Strndup(xmlChar* utf, c_int len);
	[CLink] public static extern xmlChar* xmlUTF8Strpos(xmlChar* utf, c_int pos);
	[CLink] public static extern int xmlUTF8Strloc(xmlChar* utf, xmlChar* utfchar);
	[CLink] public static extern xmlChar* xmlUTF8Strsub(xmlChar* utf, c_int start, c_int len);
	[CLink] public static extern int xmlUTF8Strlen(xmlChar* utf);
	[CLink] public static extern int xmlUTF8Size(xmlChar* utf);
	[CLink] public static extern int xmlUTF8Charcmp(xmlChar* utf1, xmlChar* utf2);
}