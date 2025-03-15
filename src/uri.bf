/**
 * Summary: library of generic URI related routines
 * Description: library of generic URI related routines
 *              Implements RFC 2396
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
	/**
	 * xmlURI:
	 *
	 * A parsed URI reference. This is a struct containing the various fields
	 * as described in RFC 2396 but separated for further processing.
	 *
	 * Note: query is a deprecated field which is incorrectly unescaped.
	 * query_raw takes precedence over query if the former is set.
	 * See: http://mail.gnome.org/archives/xml/2007-April/thread.html#00127
	 */
	typealias xmlURIPtr = xmlURI*;

	[CRepr]
	public struct xmlURI
	{
		char* scheme; /* the URI scheme */
		char* opaque; /* opaque part */
		char* authority; /* the authority part */
		char* server; /* the server part */
		char* user; /* the user part */
		c_int port; /* the port number */
		char* path; /* the path string */
		char* query; /* the query string (deprecated - use with caution) */
		char* fragment; /* the fragment identifier */
		c_int  cleanup; /* parsing potentially unclean URI */
		char* query_raw; /* the query string (as it appears in the URI) */
	}

	/*
	 * This function is in tree.h:
	 * xmlChar* xmlNodeGetBase	(xmlDocPtr doc, xmlNodePtr cur);
	 */
	[CLink] public static extern xmlURIPtr xmlCreateURI(void);
	[CLink] public static extern int xmlBuildURISafe(xmlChar* URI, xmlChar* base_, xmlChar** out_);
	[CLink] public static extern xmlChar* xmlBuildURI(xmlChar* URI, xmlChar* base_);
	[CLink] public static extern int xmlBuildRelativeURISafe(xmlChar* URI, xmlChar* base_, xmlChar** out_);
	[CLink] public static extern xmlChar* xmlBuildRelativeURI(xmlChar* URI, xmlChar* base_);
	[CLink] public static extern xmlURIPtr xmlParseURI(char* str);
	[CLink] public static extern int xmlParseURISafe(char* str, xmlURIPtr* uri);
	[CLink] public static extern xmlURIPtr xmlParseURIRaw(char* str, c_int raw);
	[CLink] public static extern int xmlParseURIReference(xmlURIPtr uri, char* str);
	[CLink] public static extern xmlChar* xmlSaveUri(xmlURIPtr uri);
	[CLink] public static extern void xmlPrintURI(FILE* stream, xmlURIPtr uri);
	[CLink] public static extern xmlChar* xmlURIEscapeStr(xmlChar* str, xmlChar* list);
	[CLink] public static extern char* xmlURIUnescapeString(char* str, c_int len, char* target);
	[CLink] public static extern int xmlNormalizeURIPath(char* path);
	[CLink] public static extern xmlChar* xmlURIEscape(xmlChar* str);
	[CLink] public static extern void xmlFreeURI(xmlURIPtr uri);
	[CLink] public static extern xmlChar* xmlCanonicPath(xmlChar* path);
	[CLink] public static extern xmlChar* xmlPathToURI(xmlChar* path);
}