/*
 * Summary: API to build regexp automata
 * Description: the API to build regexp automata
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
	* xmlAutomataPtr:
	*
	* A libxml automata description, It can be compiled into a regexp
	*/
	public struct xmlAutomata;
	typealias xmlAutomataPtr = xmlAutomata*;

	/**
	* xmlAutomataStatePtr:
	*
	* A state c_int the automata description,
	*/
	public struct xmlAutomataState;
	typealias xmlAutomataStatePtr = xmlAutomataState*;

	/*
	* Building API
	*/

	[CLink, Obsolete("")] public static extern xmlAutomataPtr xmlNewAutomata();
	[CLink, Obsolete("")] public static extern void xmlFreeAutomata(xmlAutomataPtr am);

	[CLink, Obsolete("")] public static extern xmlAutomataStatePtr xmlAutomataGetInitState(xmlAutomataPtr am);
	[CLink, Obsolete("")] public static extern int xmlAutomataSetFinalState(xmlAutomataPtr am, xmlAutomataStatePtr state);
	[CLink, Obsolete("")] public static extern xmlAutomataStatePtr xmlAutomataNewState(xmlAutomataPtr am);
	[CLink, Obsolete("")] public static extern xmlAutomataStatePtr xmlAutomataNewTransition(xmlAutomataPtr am, xmlAutomataStatePtr from, xmlAutomataStatePtr to, xmlChar* token, void* data);
	[CLink, Obsolete("")] public static extern xmlAutomataStatePtr xmlAutomataNewTransition2(xmlAutomataPtr am, xmlAutomataStatePtr from, xmlAutomataStatePtr to, xmlChar* token, xmlChar* token2, void* data);
	[CLink, Obsolete("")] public static extern xmlAutomataStatePtr xmlAutomataNewNegTrans(xmlAutomataPtr am, xmlAutomataStatePtr from, xmlAutomataStatePtr to, xmlChar* token, xmlChar* token2, void* data);

	[CLink, Obsolete("")] public static extern xmlAutomataStatePtr xmlAutomataNewCountTrans(xmlAutomataPtr am, xmlAutomataStatePtr from, xmlAutomataStatePtr to, xmlChar* token, c_int min, c_int max, void* data);
	[CLink, Obsolete("")] public static extern xmlAutomataStatePtr xmlAutomataNewCountTrans2(xmlAutomataPtr am, xmlAutomataStatePtr from, xmlAutomataStatePtr to, xmlChar* token, xmlChar* token2, c_int min, c_int max, void* data);
	[CLink, Obsolete("")] public static extern xmlAutomataStatePtr xmlAutomataNewOnceTrans(xmlAutomataPtr am, xmlAutomataStatePtr from, xmlAutomataStatePtr to, xmlChar* token, c_int min, c_int max, void* data);
	[CLink, Obsolete("")] public static extern xmlAutomataStatePtr xmlAutomataNewOnceTrans2(xmlAutomataPtr am, xmlAutomataStatePtr from, xmlAutomataStatePtr to, xmlChar* token, xmlChar* token2, c_int min, c_int max, void* data);
	[CLink, Obsolete("")] public static extern xmlAutomataStatePtr xmlAutomataNewAllTrans(xmlAutomataPtr am, xmlAutomataStatePtr from, xmlAutomataStatePtr to, c_int lax);
	[CLink, Obsolete("")] public static extern xmlAutomataStatePtr xmlAutomataNewEpsilon(xmlAutomataPtr am, xmlAutomataStatePtr from, xmlAutomataStatePtr to);
	[CLink, Obsolete("")] public static extern xmlAutomataStatePtr xmlAutomataNewCountedTrans(xmlAutomataPtr am, xmlAutomataStatePtr from, xmlAutomataStatePtr to, c_int counter);
	[CLink, Obsolete("")] public static extern xmlAutomataStatePtr xmlAutomataNewCounterTrans(xmlAutomataPtr am, xmlAutomataStatePtr from, xmlAutomataStatePtr to, c_int counter);
	[CLink, Obsolete("")] public static extern int xmlAutomataNewCounter(xmlAutomataPtr am, c_int min, c_int max);

	[CLink, Obsolete("")] public static extern xmlRegexp* xmlAutomataCompile(xmlAutomataPtr am);

	[CLink, Obsolete("")] public static extern int xmlAutomataIsDeterminist(xmlAutomataPtr am);
}

#endif /* LIBXML_REGEXP_ENABLED */ 


