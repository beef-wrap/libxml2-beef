/*
 * Summary: regular expressions handling
 * Description: basic API for libxml regular expressions handling used
 *              for XML Schemas and validation.
 *
 * Copy: See Copyright for the status of this software.
 *
 * Author: Daniel Veillard
 */

using System;
using System.Interop;

namespace libxml2;

#if LIBXML_REGEXP_ENABLED

extension libxml2
{
	/**
	 * xmlRegexpPtr:
	 *
	 * A libxml regular expression, they can actually be far more complex
	 * thank the POSIX regex expressions.
	 */
	public struct xmlRegexp;
	typealias xmlRegexpPtr = xmlRegexp*;

	/**
	 * xmlRegExecCtxtPtr:
	 *
	 * A libxml progressive regular expression evaluation context
	 */
	public struct xmlRegExecCtxt;
	typealias xmlRegExecCtxtPtr = xmlRegExecCtxt*;

	/*
	 * The POSIX like API
	 */
	[CLink] public static extern xmlRegexpPtr xmlRegexpCompile(xmlChar* regexp);
	[CLink] public static extern void xmlRegFreeRegexp(xmlRegexpPtr regexp);
	[CLink] public static extern int xmlRegexpExec(xmlRegexpPtr comp, xmlChar* value);
	[CLink] public static extern void xmlRegexpPrint(FILE* output, xmlRegexpPtr regexp);
	[CLink] public static extern int xmlRegexpIsDeterminist(xmlRegexpPtr comp);

	/**
	 * xmlRegExecCallbacks:
	 * @exec: the regular expression context
	 * @token: the current token string
	 * @transdata: transition data
	 * @inputdata: input data
	 *
	 * Callback function when doing a transition in the automata
	 */
	public function void xmlRegExecCallbacks(xmlRegExecCtxtPtr exec, xmlChar* token, void* transdata, void* inputdata);

	/*
	 * The progressive API
	 */
	[CLink, Obsolete("")] public static extern xmlRegExecCtxtPtr xmlRegNewExecCtxt	(xmlRegexpPtr comp, xmlRegExecCallbacks callback, void* data);
	[CLink, Obsolete("")] public static extern void xmlRegFreeExecCtxt	(xmlRegExecCtxtPtr exec);
	[CLink, Obsolete("")] public static extern int xmlRegExecPushString(xmlRegExecCtxtPtr exec, xmlChar* value, void* data);
	[CLink, Obsolete("")] public static extern int xmlRegExecPushString2(xmlRegExecCtxtPtr exec, xmlChar* value, xmlChar* value2, void* data);
	[CLink, Obsolete("")] public static extern int xmlRegExecNextValues(xmlRegExecCtxtPtr exec, c_int* nbval, c_int* nbneg, xmlChar** values, c_int* terminal);
	[CLink, Obsolete("")] public static extern int xmlRegExecErrInfo	(xmlRegExecCtxtPtr exec, xmlChar** string, c_int* nbval, c_int* nbneg, xmlChar** values, c_int* terminal);
}

#endif /* LIBXML_REGEXP_ENABLED */ 