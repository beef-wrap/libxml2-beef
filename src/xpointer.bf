/*
 * Summary: API to handle XML Pointers
 * Description: API to handle XML Pointers
 * Base implementation was made accordingly to
 * W3C Candidate Recommendation 7 June 2000
 * http://www.w3.org/TR/2000/CR-xptr-20000607
 *
 * Added support for the element() scheme described in:
 * W3C Proposed Recommendation 13 November 2002
 * http://www.w3.org/TR/2002/PR-xptr-element-20021113/
 *
 * Copy: See Copyright for the status of this software.
 *
 * Author: Daniel Veillard
 */

using System;
using System.Interop;

namespace libxml2;

#if LIBXML_XPTR_ENABLED

extension libxml2
{
	/*
	* Functions.
	*/
	[CLink, Obsolete("")] public static extern xmlXPathContextPtr xmlXPtrNewContext(xmlDocPtr doc, xmlNodePtr here, xmlNodePtr origin);
	[CLink] public static extern xmlXPathObjectPtr xmlXPtrEval(xmlChar* str, xmlXPathContextPtr ctx);
}

#endif /* LIBXML_XPTR_ENABLED */ 