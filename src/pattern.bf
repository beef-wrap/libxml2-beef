/*
 * Summary: pattern expression handling
 * Description: allows to compile and test pattern expressions for nodes
 *              either in a tree or based on a parser state.
 *
 * Copy: See Copyright for the status of this software.
 *
 * Author: Daniel Veillard
 */

using System;
using System.Interop;

namespace libxml2;

#if LIBXML_PATTERN_ENABLED

extension libxml2
{
	/**
	* xmlPattern:
	*
	* A compiled(XPath based) pattern to select nodes
	*/
	public struct xmlPattern;
	typealias xmlPatternPtr = xmlPattern*;

	/**
	* xmlPatternFlags:
	*
	* This is the set of options affecting the behaviour of pattern
	* matching with this module
	*
	*/
	public enum xmlPatternFlags
	{
		XML_PATTERN_DEFAULT		= 0, /* simple pattern match */
		XML_PATTERN_XPATH		= 1 << 0, /* standard XPath pattern */
		XML_PATTERN_XSSEL		= 1 << 1, /* XPath subset for schema selector */
		XML_PATTERN_XSFIELD		= 1 << 2 /* XPath subset for schema field */
	};

	[CLink] public static extern void xmlFreePattern(xmlPatternPtr comp);

	[CLink] public static extern void xmlFreePatternList(xmlPatternPtr comp);

	[CLink] public static extern xmlPatternPtr xmlPatterncompile(xmlChar* pattern, xmlDict* dict, c_int flags, xmlChar** namespaces);
	[CLink] public static extern int xmlPatternCompileSafe(xmlChar* pattern, xmlDict* dict, c_int flags, xmlChar** namespaces, xmlPatternPtr* patternOut);
	[CLink] public static extern int xmlPatternMatch(xmlPatternPtr comp, xmlNodePtr node);

	/* streaming interfaces */
	public struct xmlStreamCtxt;
	typealias xmlStreamCtxtPtr = xmlStreamCtxt*;

	[CLink] public static extern int xmlPatternStreamable(xmlPatternPtr comp);
	[CLink] public static extern int xmlPatternMaxDepth(xmlPatternPtr comp);
	[CLink] public static extern int xmlPatternMinDepth(xmlPatternPtr comp);
	[CLink] public static extern int xmlPatternFromRoot(xmlPatternPtr comp);
	[CLink] public static extern xmlStreamCtxtPtr xmlPatternGetStreamCtxt(xmlPatternPtr comp);
	[CLink] public static extern void xmlFreeStreamCtxt(xmlStreamCtxtPtr stream);
	[CLink] public static extern int xmlStreamPushNode(xmlStreamCtxtPtr stream, xmlChar* name, xmlChar* ns, c_int nodeType);
	[CLink] public static extern int xmlStreamPush(xmlStreamCtxtPtr stream, xmlChar* name, xmlChar* ns);
	[CLink] public static extern int xmlStreamPushAttr(xmlStreamCtxtPtr stream, xmlChar* name, xmlChar* ns);
	[CLink] public static extern int xmlStreamPop(xmlStreamCtxtPtr stream);
	[CLink] public static extern int xmlStreamWantsAnyNode(xmlStreamCtxtPtr stream);

}

#endif /* LIBXML_PATTERN_ENABLED */ 
