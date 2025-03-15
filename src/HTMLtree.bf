/*
 * Summary: specific APIs to process HTML tree, especially serialization
 * Description: this module implements a few function needed to process
 *              tree in an HTML specific way.
 *
 * Copy: See Copyright for the status of this software.
 *
 * Author: Daniel Veillard
 */

using System;
using System.Interop;

namespace libxml2;

#if LIBXML_HTML_ENABLED

extension libxml2
{
	/**
	* HTML_TEXT_NODE:
	*
	* Macro. A text node in a HTML document is really implemented
	* the same way as a text node in an XML document.
	*/
	// #define HTML_TEXT_NODE		XML_TEXT_NODE
	/**
	* HTML_ENTITY_REF_NODE:
	*
	* Macro. An entity reference in a HTML document is really implemented
	* the same way as an entity reference in an XML document.
	*/
	// #define HTML_ENTITY_REF_NODE	XML_ENTITY_REF_NODE
	/**
	* HTML_COMMENT_NODE:
	*
	* Macro. A comment in a HTML document is really implemented
	* the same way as a comment in an XML document.
	*/
	// #define HTML_COMMENT_NODE	XML_COMMENT_NODE
	/**
	* HTML_PRESERVE_NODE:
	*
	* Macro. A preserved node in a HTML document is really implemented
	* the same way as a CDATA section in an XML document.
	*/
	// #define HTML_PRESERVE_NODE	XML_CDATA_SECTION_NODE
	/**
	* HTML_PI_NODE:
	*
	* Macro. A processing instruction in a HTML document is really implemented
	* the same way as a processing instruction in an XML document.
	*/
	// #define HTML_PI_NODE		XML_PI_NODE

	[CLink] public static extern htmlDocPtr htmlNewDoc(xmlChar* URI, xmlChar* ExternalID);
	[CLink] public static extern htmlDocPtr htmlNewDocNoDtD(xmlChar* URI, xmlChar* ExternalID);
	[CLink] public static extern xmlChar*  htmlGetMetaEncoding(htmlDocPtr doc);
	[CLink] public static extern int htmlSetMetaEncoding(htmlDocPtr doc, xmlChar* encoding);

#if LIBXML_OUTPUT_ENABLED
	[CLink] public static extern void htmlDocDumpMemory(xmlDocPtr cur, xmlChar** mem, c_int* size);
	[CLink] public static extern void htmlDocDumpMemoryFormat(xmlDocPtr cur, xmlChar** mem, c_int* size, c_int format);
	[CLink] public static extern int htmlDocDump(FILE* f, xmlDocPtr cur);
	[CLink] public static extern int htmlSaveFile(char* filename, xmlDocPtr cur);
	[CLink] public static extern int htmlNodeDump(xmlBufferPtr buf, xmlDocPtr doc, xmlNodePtr cur);
	[CLink] public static extern void htmlNodeDumpFile(FILE* out_, xmlDocPtr doc, xmlNodePtr cur);
	[CLink] public static extern int htmlNodeDumpFileFormat(FILE* out_, xmlDocPtr doc, xmlNodePtr cur, char* encoding, c_int format);
	[CLink] public static extern int htmlSaveFileEnc(char* filename, xmlDocPtr cur, char* encoding);
	[CLink] public static extern int htmlSaveFileFormat(char* filename, xmlDocPtr cur, char* encoding, c_int format);

	[CLink] public static extern void htmlNodeDumpFormatOutpu(xmlOutputBufferPtr buf, xmlDocPtr doc, xmlNodePtr cur, char* encoding, c_int format);
	[CLink] public static extern void htmlDocContentDumpOutpu(xmlOutputBufferPtr buf, xmlDocPtr cur, char* encoding);
	[CLink] public static extern void htmlDocContentDumpFormatOutpu(xmlOutputBufferPtr buf, xmlDocPtr cur, char* encoding, c_int format);
	[CLink] public static extern void htmlNodeDumpOutput(xmlOutputBufferPtr buf, xmlDocPtr doc, xmlNodePtr cur, char* encoding);
#endif /* LIBXML_OUTPUT_ENABLED */ 

	[CLink, Obsolete("")] public static extern int htmlIsBooleanAttr(xmlChar* name);
}

#endif /* LIBXML_HTML_ENABLED */