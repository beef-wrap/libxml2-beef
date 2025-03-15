/*
 * Summary: implementation of XInclude
 * Description: API to handle XInclude processing,
 * implements the
 * World Wide Web Consortium Last Call Working Draft 10 November 2003
 * http://www.w3.org/TR/2003/WD-xinclude-20031110
 *
 * Copy: See Copyright for the status of this software.
 *
 * Author: Daniel Veillard
 */

using System;
using System.Interop;

namespace libxml2;

#if LIBXML_XINCLUDE_ENABLED

extension libxml2
{
	/**
	* XINCLUDE_NS:
	*
	* Macro defining the Xinclude namespace: http://www.w3.org/2003/XInclude
	*/
	const xmlChar* XINCLUDE_NS = (.)"http://www.w3.org/2003/XInclude";
	 /**
	* XINCLUDE_OLD_NS:
	*
	* Macro defining the draft Xinclude namespace: http://www.w3.org/2001/XInclude
	*/
	const xmlChar* XINCLUDE_OLD_NS = (.)"http://www.w3.org/2001/XInclude";
	 /**
	* XINCLUDE_NODE:
	*
	* Macro defining "include"
	*/
	const xmlChar* XINCLUDE_NODE = (.)"include";
	 /**
	* XINCLUDE_FALLBACK:
	*
	* Macro defining "fallback"
	*/
	const xmlChar* XINCLUDE_FALLBACK = (.)"fallback";
	 /**
	* XINCLUDE_HREF:
	*
	* Macro defining "href"
	*/
	const xmlChar* XINCLUDE_HREF = (.)"href";
	 /**
	* XINCLUDE_PARSE:
	*
	* Macro defining "parse"
	*/
	const xmlChar* XINCLUDE_PARSE = (.)"parse";
	 /**
	* XINCLUDE_PARSE_XML:
	*
	* Macro defining "xml"
	*/
	const xmlChar* XINCLUDE_PARSE_XML = (.)"xml";
	 /**
	* XINCLUDE_PARSE_TEXT:
	*
	* Macro defining "text"
	*/
	const xmlChar* XINCLUDE_PARSE_TEXT = (.)"text";
	 /**
	* XINCLUDE_PARSE_ENCODING:
	*
	* Macro defining "encoding"
	*/
	const xmlChar* XINCLUDE_PARSE_ENCODING = (.)"encoding";
	 /**
	* XINCLUDE_PARSE_XPOINTER:
	*
	* Macro defining "xpointer"
	*/
	const xmlChar* XINCLUDE_PARSE_XPOINTER = (.)"xpointer";

	public struct xmlXIncludeCtxt;
	typealias xmlXIncludeCtxtPtr = xmlXIncludeCtxt*;

	/*
	* standalone processing
	*/
	
	[CLink] public static extern int xmlXIncludeProcess(xmlDocPtr doc);
	[CLink] public static extern int xmlXIncludeProcessFlags(xmlDocPtr doc, c_int flags);
	[CLink] public static extern int xmlXIncludeProcessFlagsData(xmlDocPtr doc, c_int flags, void* data);
	[CLink] public static extern int xmlXIncludeProcessTreeFlagsData(xmlNodePtr tree, c_int flags, void* data);
	[CLink] public static extern int xmlXIncludeProcessTree(xmlNodePtr tree);
	[CLink] public static extern int xmlXIncludeProcessTreeFlags(xmlNodePtr tree, c_int flags);

	/*
	* contextual processing
	*/

	[CLink] public static extern xmlXIncludeCtxtPtr xmlXIncludeNewContext(xmlDocPtr doc);
	[CLink] public static extern int xmlXIncludeSetFlags(xmlXIncludeCtxtPtr ctxt, c_int flags);
	[CLink] public static extern void xmlXIncludeSetErrorHandler(xmlXIncludeCtxtPtr ctxt, xmlStructuredErrorFunc handler, void* data);
	[CLink] public static extern void xmlXIncludeSetResourceLoader(xmlXIncludeCtxtPtr ctxt, xmlResourceLoader loader, void* data);
	[CLink] public static extern int xmlXIncludeGetLastError(xmlXIncludeCtxtPtr ctxt);
	[CLink] public static extern void xmlXIncludeFreeContext(xmlXIncludeCtxtPtr ctxt);
	[CLink] public static extern int xmlXIncludeProcessNode(xmlXIncludeCtxtPtr ctxt, xmlNodePtr tree);
}

#endif /* LIBXML_XINCLUDE_ENABLED */ 