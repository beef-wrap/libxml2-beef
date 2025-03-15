/*
 * Summary: internal interfaces for XML Path Language implementation
 * Description: internal interfaces for XML Path Language implementation
 *              used to build new modules on top of XPath like XPointer and
 *              XSLT
 *
 * Copy: See Copyright for the status of this software.
 *
 * Author: Daniel Veillard
 */

using System;
using System.Interop;

namespace libxml2;

#if LIBXML_XPATH_ENABLED

extension libxml2
{
	/************************************************************************
	 *									*
	 *			Helpers						*
	 *									*
	 ************************************************************************/

	/*
	 * Many of these macros may later turn into functions. They
	 * shouldn't be used in #if's preprocessor instructions.
	 */
	/**
	 * xmlXPathSetError:
	 * @ctxt:  an XPath parser context
	 * @err:  an xmlXPathError code
	 *
	 * Raises an error.
	 */
	// #define xmlXPathSetError(ctxt, err)					\
	//     { xmlXPatherror((ctxt), __FILE__, __LINE__, (err));			\
	//       if ((ctxt) != NULL) (ctxt)->error = (err); }

	/**
	 * xmlXPathSetArityError:
	 * @ctxt:  an XPath parser context
	 *
	 * Raises an XPATH_INVALID_ARITY error.
	 */
	// #define xmlXPathSetArityError(ctxt)					\
	//     xmlXPathSetError((ctxt), XPATH_INVALID_ARITY)

	/**
	 * xmlXPathSetTypeError:
	 * @ctxt:  an XPath parser context
	 *
	 * Raises an XPATH_INVALID_TYPE error.
	 */
	// #define xmlXPathSetTypeError(ctxt)					\
	//     xmlXPathSetError((ctxt), XPATH_INVALID_TYPE)

	/**
	 * xmlXPathGetError:
	 * @ctxt:  an XPath parser context
	 *
	 * Get the error code of an XPath context.
	 *
	 * Returns the context error.
	 */
	// #define xmlXPathGetError(ctxt)	  ((ctxt)->error)

	/**
	 * xmlXPathCheckError:
	 * @ctxt:  an XPath parser context
	 *
	 * Check if an XPath error was raised.
	 *
	 * Returns true if an error has been raised, false otherwise.
	 */
	// #define xmlXPathCheckError(ctxt)  ((ctxt)->error != XPATH_EXPRESSION_OK)

	/**
	 * xmlXPathGetDocument:
	 * @ctxt:  an XPath parser context
	 *
	 * Get the document of an XPath context.
	 *
	 * Returns the context document.
	 */
	// #define xmlXPathGetDocument(ctxt	((ctxt)->context->doc)

	/**
	 * xmlXPathGetContextNode:
	 * @ctxt: an XPath parser context
	 *
	 * Get the context node of an XPath context.
	 *
	 * Returns the context node.
	 */
	// #define xmlXPathGetContextNode(ctxt	((ctxt)->context->node)

	[CLink] public static extern int xmlXPathPopBoolean(xmlXPathParserContextPtr ctxt);
	[CLink] public static extern double xmlXPathPopNumber(xmlXPathParserContextPtr ctxt);
	[CLink] public static extern xmlChar* xmlXPathPopString(xmlXPathParserContextPtr ctxt);
	[CLink] public static extern xmlNodeSetPtr xmlXPathPopNodeSet(xmlXPathParserContextPtr ctxt);
	[CLink] public static extern void* xmlXPathPopExternal(xmlXPathParserContextPtr ctxt);

	/**
	 * xmlXPathReturnBoolean:
	 * @ctxt:  an XPath parser context
	 * @val:  a boolean
	 *
	 * Pushes the boolean @val on the context stack.
	 */
	// #define xmlXPathReturnBoolean(ctxt, val)				\
	//     valuePush((ctxt), xmlXPathNewBoolean(val))

	/**
	 * xmlXPathReturnTrue:
	 * @ctxt:  an XPath parser context
	 *
	 * Pushes true on the context stack.
	 */
	// #define xmlXPathReturnTrue(ctxt)   xmlXPathReturnBoolean((ctxt), 1)

	/**
	 * xmlXPathReturnFalse:
	 * @ctxt:  an XPath parser context
	 *
	 * Pushes false on the context stack.
	 */
	// #define xmlXPathReturnFalse(ctxt)  xmlXPathReturnBoolean((ctxt), 0)

	/**
	 * xmlXPathReturnNumber:
	 * @ctxt:  an XPath parser context
	 * @val:  a double
	 *
	 * Pushes the double @val on the context stack.
	 */
	// #define xmlXPathReturnNumber(ctxt, val)					\
	//     valuePush((ctxt), xmlXPathNewFloat(val))

	/**
	 * xmlXPathReturnString:
	 * @ctxt:  an XPath parser context
	 * @str:  a string
	 *
	 * Pushes the string @str on the context stack.
	 */
	// #define xmlXPathReturnString(ctxt, str)					\
	//     valuePush((ctxt), xmlXPathWrapString(str))

	/**
	 * xmlXPathReturnEmptyString:
	 * @ctxt:  an XPath parser context
	 *
	 * Pushes an empty string on the stack.
	 */
	// #define xmlXPathReturnEmptyString(ctxt)					\
	//     valuePush((ctxt), xmlXPathNewCString(""))

	/**
	 * xmlXPathReturnNodeSet:
	 * @ctxt:  an XPath parser context
	 * @ns:  a node-set
	 *
	 * Pushes the node-set @ns on the context stack.
	 */
	// #define xmlXPathReturnNodeSet(ctxt, ns)					\
	//     valuePush((ctxt), xmlXPathWrapNodeSet(ns))

	/**
	 * xmlXPathReturnEmptyNodeSet:
	 * @ctxt:  an XPath parser context
	 *
	 * Pushes an empty node-set on the context stack.
	 */
	// #define xmlXPathReturnEmptyNodeSet(ctxt)				\
	//     valuePush((ctxt), xmlXPathNewNodeSet(NULL))

	/**
	 * xmlXPathReturnExternal:
	 * @ctxt:  an XPath parser context
	 * @val:  user data
	 *
	 * Pushes user data on the context stack.
	 */
	// #define xmlXPathReturnExternal(ctxt, val)				\
	//     valuePush((ctxt), xmlXPathWrapExternal(val))

	/**
	 * xmlXPathStackIsNodeSet:
	 * @ctxt: an XPath parser context
	 *
	 * Check if the current value on the XPath stack is a node set or
	 * an XSLT value tree.
	 *
	 * Returns true if the current object on the stack is a node-set.
	 */
	// #define xmlXPathStackIsNodeSet(ctxt)					\
	//     (((ctxt)->value != NULL)						\
	//      && (((ctxt)->value->type == XPATH_NODESET)				\
	//          || ((ctxt)->value->type == XPATH_XSLT_TREE)))

	/**
	 * xmlXPathStackIsExternal:
	 * @ctxt: an XPath parser context
	 *
	 * Checks if the current value on the XPath stack is an external
	 * object.
	 *
	 * Returns true if the current object on the stack is an external
	 * object.
	 */
	// #define xmlXPathStackIsExternal(ctxt)					\	((ctxt->value != NULL) && (ctxt->value->type == XPATH_USERS))

	/**
	 * xmlXPathEmptyNodeSet:
	 * @ns:  a node-set
	 *
	 * Empties a node-set.
	 */
	// #define xmlXPathEmptyNodeSet(ns)					\
	//     { while ((ns)->nodeNr > 0) (ns)->nodeTab[--(ns)->nodeNr] = NULL; }

	/**
	 * CHECK_ERROR:
	 *
	 * Macro to return from the function if an XPath error was detected.
	 */
	// #define CHECK_ERROR							\
	//     if (ctxt->error != XPATH_EXPRESSION_OK) return

	/**
	 * CHECK_ERROR0:
	 *
	 * Macro to return 0 from the function if an XPath error was detected.
	 */
	// #define CHECK_ERROR0							\
	//     if (ctxt->error != XPATH_EXPRESSION_OK) return(0)

	/**
	 * XP_ERROR:
	 * @X:  the error code
	 *
	 * Macro to raise an XPath error and return.
	 */
	// #define XP_ERROR(X)							\
	//     { xmlXPathErr(ctxt, X); return; }

	/**
	 * XP_ERROR0:
	 * @X:  the error code
	 *
	 * Macro to raise an XPath error and return 0.
	 */
	// #define XP_ERROR0(X)							\
	//     { xmlXPathErr(ctxt, X); return(0); }

	/**
	 * CHECK_TYPE:
	 * @typeval:  the XPath type
	 *
	 * Macro to check that the value on top of the XPath stack is of a given
	 * type.
	 */
	// #define CHECK_TYPE(typeval)						\
	//     if ((ctxt->value == NULL) || (ctxt->value->type != typeval))	\
	//         XP_ERROR(XPATH_INVALID_TYPE)

	/**
	 * CHECK_TYPE0:
	 * @typeval:  the XPath type
	 *
	 * Macro to check that the value on top of the XPath stack is of a given
	 * type. Return(0) in case of failure
	 */
	// #define CHECK_TYPE0(typeval)						\
	//     if ((ctxt->value == NULL) || (ctxt->value->type != typeval))	\
	//         XP_ERROR0(XPATH_INVALID_TYPE)

	/**
	 * CHECK_ARITY:
	 * @x:  the number of expected args
	 *
	 * Macro to check that the number of args passed to an XPath function matches.
	 */
	// #define CHECK_ARITY(x)							\
	//     if (ctxt == NULL) return;						\
	//     if (nargs != (x))							\
	//         XP_ERROR(XPATH_INVALID_ARITY);					\
	//     if (ctxt->valueNr < (x))						\
	//         XP_ERROR(XPATH_STACK_ERROR);

	/**
	 * CAST_TO_STRING:
	 *
	 * Macro to try to cast the value on the top of the XPath stack to a string.
	 */
	// #define CAST_TO_STRING							\
	//     if ((ctxt->value != NULL) && (ctxt->value->type != XPATH_STRING))	\
	//         xmlXPathStringFunction(ctxt, 1);

	/**
	 * CAST_TO_NUMBER:
	 *
	 * Macro to try to cast the value on the top of the XPath stack to a number.
	 */
	// #define CAST_TO_NUMBER							\
	//     if ((ctxt->value != NULL) && (ctxt->value->type != XPATH_NUMBER))	\
	//         xmlXPathNumberFunction(ctxt, 1);

	/**
	 * CAST_TO_BOOLEAN:
	 *
	 * Macro to try to cast the value on the top of the XPath stack to a boolean.
	 */
	// #define CAST_TO_BOOLEAN							\
	//     if ((ctxt->value != NULL) && (ctxt->value->type != XPATH_BOOLEAN))	\
	//         xmlXPathBooleanFunction(ctxt, 1);

	/*
	 * Variable Lookup forwarding.
	 */

	[CLink] public static extern void xmlXPathRegisterVariableLookup(xmlXPathContextPtr ctxt, xmlXPathVariableLookupFunc f, void* data);

	/*
	 * Function Lookup forwarding.
	 */

	[CLink] public static extern void xmlXPathRegisterFuncLookup(xmlXPathContextPtr ctxt, xmlXPathFuncLookupFunc f, void* funcCtxt);

	/*
	 * Error reporting.
	 */
	[CLink] public static extern void xmlXPatherror(xmlXPathParserContextPtr ctxt, char* file, c_int line, c_int no);

	[CLink] public static extern void xmlXPathErr(xmlXPathParserContextPtr ctxt, c_int error);

#if LIBXML_DEBUG_ENABLED
	[CLink] public static extern void xmlXPathDebugDumpObject(FILE* output, xmlXPathObjectPtr cur, c_int depth);
	[CLink] public static extern void xmlXPathDebugDumpCompExpr(FILE* output, xmlXPathCompExprPtr comp, c_int depth);
#endif

	/**
	 * NodeSet handling.
	 */
	[CLink] public static extern int xmlXPathNodeSetContains(xmlNodeSetPtr cur, xmlNodePtr val);
	[CLink] public static extern xmlNodeSetPtr xmlXPathDifference(xmlNodeSetPtr nodes1, xmlNodeSetPtr nodes2);
	[CLink] public static extern xmlNodeSetPtr xmlXPathIntersection(xmlNodeSetPtr nodes1, xmlNodeSetPtr nodes2);

	[CLink] public static extern xmlNodeSetPtr xmlXPathDistinctSorted(xmlNodeSetPtr nodes);
	[CLink] public static extern xmlNodeSetPtr xmlXPathDistinct(xmlNodeSetPtr nodes);

	[CLink] public static extern int xmlXPathHasSameNodes(xmlNodeSetPtr nodes1, xmlNodeSetPtr nodes2);

	[CLink] public static extern xmlNodeSetPtr xmlXPathNodeLeadingSorted(xmlNodeSetPtr nodes, xmlNodePtr node);
	[CLink] public static extern xmlNodeSetPtr xmlXPathLeadingSorted(xmlNodeSetPtr nodes1, xmlNodeSetPtr nodes2);
	[CLink] public static extern xmlNodeSetPtr xmlXPathNodeLeading(xmlNodeSetPtr nodes, xmlNodePtr node);
	[CLink] public static extern xmlNodeSetPtr xmlXPathLeading(xmlNodeSetPtr nodes1, xmlNodeSetPtr nodes2);

	[CLink] public static extern xmlNodeSetPtr xmlXPathNodeTrailingSorted(xmlNodeSetPtr nodes, xmlNodePtr node);
	[CLink] public static extern xmlNodeSetPtr xmlXPathTrailingSorted(xmlNodeSetPtr nodes1, xmlNodeSetPtr nodes2);
	[CLink] public static extern xmlNodeSetPtr xmlXPathNodeTrailing(xmlNodeSetPtr nodes, xmlNodePtr node);
	[CLink] public static extern xmlNodeSetPtr xmlXPathTrailing(xmlNodeSetPtr nodes1, xmlNodeSetPtr nodes2);


	/**
	 * Extending a context.
	 */

	[CLink] public static extern int xmlXPathRegisterNs(xmlXPathContextPtr ctxt, xmlChar* prefix, xmlChar* ns_uri);
	[CLink] public static extern xmlChar* xmlXPathNsLookup(xmlXPathContextPtr ctxt, xmlChar* prefix);
	[CLink] public static extern void xmlXPathRegisteredNsCleanup(xmlXPathContextPtr ctxt);

	[CLink] public static extern int xmlXPathRegisterFunc(xmlXPathContextPtr ctxt, xmlChar* name, xmlXPathFunction f);
	[CLink] public static extern int xmlXPathRegisterFuncNS(xmlXPathContextPtr ctxt, xmlChar* name, xmlChar* ns_uri, xmlXPathFunction f);
	[CLink] public static extern int xmlXPathRegisterVariable(xmlXPathContextPtr ctxt, xmlChar* name, xmlXPathObjectPtr value);
	[CLink] public static extern int xmlXPathRegisterVariableNS(xmlXPathContextPtr ctxt, xmlChar* name, xmlChar* ns_uri, xmlXPathObjectPtr value);
	[CLink] public static extern xmlXPathFunction xmlXPathFunctionLookup(xmlXPathContextPtr ctxt, xmlChar* name);
	[CLink] public static extern xmlXPathFunction xmlXPathFunctionLookupNS(xmlXPathContextPtr ctxt, xmlChar* name, xmlChar* ns_uri);
	[CLink] public static extern void xmlXPathRegisteredFuncsCleanup(xmlXPathContextPtr ctxt);
	[CLink] public static extern xmlXPathObjectPtr xmlXPathVariableLookup(xmlXPathContextPtr ctxt, xmlChar* name);
	[CLink] public static extern xmlXPathObjectPtr xmlXPathVariableLookupNS(xmlXPathContextPtr ctxt, xmlChar* name, xmlChar* ns_uri);
	[CLink] public static extern void xmlXPathRegisteredVariablesCleanup(xmlXPathContextPtr ctxt);

	/**
	 * Utilities to extend XPath.
	 */
	[CLink] public static extern xmlXPathParserContextPtr xmlXPathNewParserContext(xmlChar* str, xmlXPathContextPtr ctxt);
	[CLink] public static extern void xmlXPathFreeParserContext(xmlXPathParserContextPtr ctxt);

	/* TODO: remap to xmlXPathValuePop and Push. */
	[CLink] public static extern xmlXPathObjectPtr valuePop(xmlXPathParserContextPtr ctxt);
	[CLink] public static extern int valuePush(xmlXPathParserContextPtr ctxt, xmlXPathObjectPtr value);

	[CLink] public static extern xmlXPathObjectPtr xmlXPathNewString(xmlChar* val);
	[CLink] public static extern xmlXPathObjectPtr xmlXPathNewCString(char* val);
	[CLink] public static extern xmlXPathObjectPtr xmlXPathWrapString(xmlChar* val);
	[CLink] public static extern xmlXPathObjectPtr xmlXPathWrapCString(char* val);
	[CLink] public static extern xmlXPathObjectPtr xmlXPathNewFloat(double val);
	[CLink] public static extern xmlXPathObjectPtr xmlXPathNewBoolean(c_int val);
	[CLink] public static extern xmlXPathObjectPtr xmlXPathNewNodeSet(xmlNodePtr val);
	[CLink] public static extern xmlXPathObjectPtr xmlXPathNewValueTree(xmlNodePtr val);
	[CLink] public static extern int xmlXPathNodeSetAdd(xmlNodeSetPtr cur, xmlNodePtr val);
	[CLink] public static extern int xmlXPathNodeSetAddUnique(xmlNodeSetPtr cur, xmlNodePtr val);
	[CLink] public static extern int xmlXPathNodeSetAddNs(xmlNodeSetPtr cur, xmlNodePtr node, xmlNsPtr ns);
	[CLink] public static extern void xmlXPathNodeSetSort(xmlNodeSetPtr set);

	[CLink] public static extern void xmlXPathRoot(xmlXPathParserContextPtr ctxt);

	[CLink, Obsolete("")] public static extern void xmlXPathEvalExpr(xmlXPathParserContextPtr ctxt);
	[CLink] public static extern xmlChar* xmlXPathParseName(xmlXPathParserContextPtr ctxt);
	[CLink] public static extern xmlChar* xmlXPathParseNCName(xmlXPathParserContextPtr ctxt);

	/*
	 * Existing functions.
	 */
	[CLink] public static extern double xmlXPathStringEvalNumber(xmlChar* str);
	[CLink] public static extern int xmlXPathEvaluatePredicateResult(xmlXPathParserContextPtr ctxt, xmlXPathObjectPtr res);
	[CLink] public static extern void xmlXPathRegisterAllFunctions(xmlXPathContextPtr ctxt);
	[CLink] public static extern xmlNodeSetPtr xmlXPathNodeSetMerge(xmlNodeSetPtr val1, xmlNodeSetPtr val2);
	[CLink] public static extern void xmlXPathNodeSetDel(xmlNodeSetPtr cur, xmlNodePtr val);
	[CLink] public static extern void xmlXPathNodeSetRemove(xmlNodeSetPtr cur, c_int val);
	[CLink] public static extern xmlXPathObjectPtr xmlXPathNewNodeSetList(xmlNodeSetPtr val);
	[CLink] public static extern xmlXPathObjectPtr xmlXPathWrapNodeSet(xmlNodeSetPtr val);
	[CLink] public static extern xmlXPathObjectPtr xmlXPathWrapExternal(void* val);

	[CLink] public static extern c_int xmlXPathEqualValues(xmlXPathParserContextPtr ctxt);
	[CLink] public static extern c_int xmlXPathNotEqualValues(xmlXPathParserContextPtr ctxt);
	[CLink] public static extern c_int xmlXPathCompareValues(xmlXPathParserContextPtr ctxt, c_int inf, c_int strict);
	[CLink] public static extern void xmlXPathValueFlipSign(xmlXPathParserContextPtr ctxt);
	[CLink] public static extern void xmlXPathAddValues(xmlXPathParserContextPtr ctxt);
	[CLink] public static extern void xmlXPathSubValues(xmlXPathParserContextPtr ctxt);
	[CLink] public static extern void xmlXPathMultValues(xmlXPathParserContextPtr ctxt);
	[CLink] public static extern void xmlXPathDivValues(xmlXPathParserContextPtr ctxt);
	[CLink] public static extern void xmlXPathModValues(xmlXPathParserContextPtr ctxt);

	[CLink] public static extern c_int xmlXPathIsNodeType(xmlChar* name);

	/*
	 * Some of the axis navigation routines.
	 */
	[CLink] public static extern xmlNodePtr xmlXPathNextSelf(xmlXPathParserContextPtr ctxt, xmlNodePtr cur);
	[CLink] public static extern xmlNodePtr xmlXPathNextChild(xmlXPathParserContextPtr ctxt, xmlNodePtr cur);
	[CLink] public static extern xmlNodePtr xmlXPathNextDescendant(xmlXPathParserContextPtr ctxt, xmlNodePtr cur);
	[CLink] public static extern xmlNodePtr xmlXPathNextDescendantOrSelf(xmlXPathParserContextPtr ctxt, xmlNodePtr cur);
	[CLink] public static extern xmlNodePtr xmlXPathNextParent(xmlXPathParserContextPtr ctxt, xmlNodePtr cur);
	[CLink] public static extern xmlNodePtr xmlXPathNextAncestorOrSelf(xmlXPathParserContextPtr ctxt, xmlNodePtr cur);
	[CLink] public static extern xmlNodePtr xmlXPathNextFollowingSibling(xmlXPathParserContextPtr ctxt, xmlNodePtr cur);
	[CLink] public static extern xmlNodePtr xmlXPathNextFollowing(xmlXPathParserContextPtr ctxt, xmlNodePtr cur);
	[CLink] public static extern xmlNodePtr xmlXPathNextNamespace(xmlXPathParserContextPtr ctxt, xmlNodePtr cur);
	[CLink] public static extern xmlNodePtr xmlXPathNextAttribute(xmlXPathParserContextPtr ctxt, xmlNodePtr cur);
	[CLink] public static extern xmlNodePtr xmlXPathNextPreceding(xmlXPathParserContextPtr ctxt, xmlNodePtr cur);
	[CLink] public static extern xmlNodePtr xmlXPathNextAncestor(xmlXPathParserContextPtr ctxt, xmlNodePtr cur);
	[CLink] public static extern xmlNodePtr xmlXPathNextPrecedingSibling(xmlXPathParserContextPtr ctxt, xmlNodePtr cur);
/*
 * The official core of XPath functions.
 */
	[CLink] public static extern void xmlXPathLastFunction(xmlXPathParserContextPtr ctxt, c_int nargs);
	[CLink] public static extern void xmlXPathPositionFunction(xmlXPathParserContextPtr ctxt, c_int nargs);
	[CLink] public static extern void xmlXPathCountFunction(xmlXPathParserContextPtr ctxt, c_int nargs);
	[CLink] public static extern void xmlXPathIdFunction(xmlXPathParserContextPtr ctxt, c_int nargs);
	[CLink] public static extern void xmlXPathLocalNameFunction(xmlXPathParserContextPtr ctxt, c_int nargs);
	[CLink] public static extern void xmlXPathNamespaceURIFunction(xmlXPathParserContextPtr ctxt, c_int nargs);
	[CLink] public static extern void xmlXPathStringFunction(xmlXPathParserContextPtr ctxt, c_int nargs);
	[CLink] public static extern void xmlXPathStringLengthFunction(xmlXPathParserContextPtr ctxt, c_int nargs);
	[CLink] public static extern void xmlXPathConcatFunction(xmlXPathParserContextPtr ctxt, c_int nargs);
	[CLink] public static extern void xmlXPathContainsFunction(xmlXPathParserContextPtr ctxt, c_int nargs);
	[CLink] public static extern void xmlXPathStartsWithFunction(xmlXPathParserContextPtr ctxt, c_int nargs);
	[CLink] public static extern void xmlXPathSubstringFunction(xmlXPathParserContextPtr ctxt, c_int nargs);
	[CLink] public static extern void xmlXPathSubstringBeforeFunction(xmlXPathParserContextPtr ctxt, c_int nargs);
	[CLink] public static extern void xmlXPathSubstringAfterFunction(xmlXPathParserContextPtr ctxt, c_int nargs);
	[CLink] public static extern void xmlXPathNormalizeFunction(xmlXPathParserContextPtr ctxt, c_int nargs);
	[CLink] public static extern void xmlXPathTranslateFunction(xmlXPathParserContextPtr ctxt, c_int nargs);
	[CLink] public static extern void xmlXPathNotFunction(xmlXPathParserContextPtr ctxt, c_int nargs);
	[CLink] public static extern void xmlXPathTrueFunction(xmlXPathParserContextPtr ctxt, c_int nargs);
	[CLink] public static extern void xmlXPathFalseFunction(xmlXPathParserContextPtr ctxt, c_int nargs);
	[CLink] public static extern void xmlXPathLangFunction(xmlXPathParserContextPtr ctxt, c_int nargs);
	[CLink] public static extern void xmlXPathNumberFunction(xmlXPathParserContextPtr ctxt, c_int nargs);
	[CLink] public static extern void xmlXPathSumFunction(xmlXPathParserContextPtr ctxt, c_int nargs);
	[CLink] public static extern void xmlXPathFloorFunction(xmlXPathParserContextPtr ctxt, c_int nargs);
	[CLink] public static extern void xmlXPathCeilingFunction(xmlXPathParserContextPtr ctxt, c_int nargs);
	[CLink] public static extern void xmlXPathRoundFunction(xmlXPathParserContextPtr ctxt, c_int nargs);
	[CLink] public static extern void xmlXPathBooleanFunction(xmlXPathParserContextPtr ctxt, c_int nargs);

	/**
	 * Really internal functions
	 */
	[CLink] public static extern void xmlXPathNodeSetFreeNs(xmlNsPtr ns);
}

#endif /* LIBXML_XPATH_ENABLED */ 
