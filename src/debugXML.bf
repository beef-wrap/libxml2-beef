/*
 * Summary: Tree debugging APIs
 * Description: Interfaces to a set of routines used for debugging the tree
 *              produced by the XML parser.
 *
 * Copy: See Copyright for the status of this software.
 *
 * Author: Daniel Veillard
 */

using System;
using System.Interop;

namespace libxml2;

#if LIBXML_DEBUG_ENABLED

extension libxml2
{
	/*
	 * The standard Dump routines.
	 */
	[CLink] public static extern void xmlDebugDumpString(FILE* output, xmlChar* str);
	[CLink] public static extern void xmlDebugDumpAttr(FILE* output, xmlAttrPtr attr, c_int depth);
	[CLink] public static extern void xmlDebugDumpAttrList(FILE* output, xmlAttrPtr attr, c_int depth);
	[CLink] public static extern void xmlDebugDumpOneNode(FILE* output, xmlNodePtr node, c_int depth);
	[CLink] public static extern void xmlDebugDumpNode(FILE* output, xmlNodePtr node, c_int depth);
	[CLink] public static extern void xmlDebugDumpNodeList(FILE* output, xmlNodePtr node, c_int depth);
	[CLink] public static extern void xmlDebugDumpDocumentHead(FILE* output, xmlDocPtr doc);
	[CLink] public static extern void xmlDebugDumpDocument(FILE* output, xmlDocPtr doc);
	[CLink] public static extern void xmlDebugDumpDTD(FILE* output, xmlDtdPtr dtd);
	[CLink] public static extern void xmlDebugDumpEntities(FILE* output, xmlDocPtr doc);

	/****************************************************************
	 *								*
	 *			Checking routines			*
	 *								*
	 ****************************************************************/

	[CLink] public static extern int xmlDebugCheckDocument(FILE* output, xmlDocPtr doc);
}

#endif /* LIBXML_DEBUG_ENABLED */ 