/*
 * Summary: XML Path Language implementation
 * Description: API for the XML Path Language implementation
 *
 * XML Path Language implementation
 * XPath is a language for addressing parts of an XML document,
 * designed to be used by both XSLT and XPointer
 *     http://www.w3.org/TR/xpath
 *
 * Implements
 * W3C Recommendation 16 November 1999
 *     http://www.w3.org/TR/1999/REC-xpath-19991116
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
	public typealias xmlXPathContextPtr = xmlXPathContext*;

	public typealias xmlXPathParserContextPtr = xmlXPathParserContext*;

	/**
	* The set of XPath error codes.
	*/

	public enum xmlXPathError
	{
		XPATH_EXPRESSION_OK = 0,
		XPATH_NUMBER_ERROR,
		XPATH_UNFINISHED_LITERAL_ERROR,
		XPATH_START_LITERAL_ERROR,
		XPATH_VARIABLE_REF_ERROR,
		XPATH_UNDEF_VARIABLE_ERROR,
		XPATH_INVALID_PREDICATE_ERROR,
		XPATH_EXPR_ERROR,
		XPATH_UNCLOSED_ERROR,
		XPATH_UNKNOWN_FUNC_ERROR,
		XPATH_INVALID_OPERAND,
		XPATH_INVALID_TYPE,
		XPATH_INVALID_ARITY,
		XPATH_INVALID_CTXT_SIZE,
		XPATH_INVALID_CTXT_POSITION,
		XPATH_MEMORY_ERROR,
		XPTR_SYNTAX_ERROR,
		XPTR_RESOURCE_ERROR,
		XPTR_SUB_RESOURCE_ERROR,
		XPATH_UNDEF_PREFIX_ERROR,
		XPATH_ENCODING_ERROR,
		XPATH_INVALID_CHAR_ERROR,
		XPATH_INVALID_CTXT,
		XPATH_STACK_ERROR,
		XPATH_FORBID_VARIABLE_ERROR,
		XPATH_OP_LIMIT_EXCEEDED,
		XPATH_RECURSION_LIMIT_EXCEEDED
	};

	/*
	* A node-set (an unordered collection of nodes without duplicates).
	*/
	public typealias xmlNodeSetPtr = xmlNodeSet*;

	[CRepr]
	public struct xmlNodeSet
	{
		c_int nodeNr; /* number of nodes in the set */
		c_int nodeMax; /* size of the array as allocated */
		xmlNodePtr* nodeTab; /* array of nodes in no particular order */
		/* @@ with_ns to check whether namespace nodes should be looked at @@ */
	};

	/*
	* An expression is evaluated to yield an object, which
	* has one of the following four basic types:
	*   - node-set
	*   - boolean
	*   - number
	*   - string
	*
	* @@ XPointer will add more types !
	*/

	public enum xmlXPathObjectType
	{
		XPATH_UNDEFINED = 0,
		XPATH_NODESET = 1,
		XPATH_BOOLEAN = 2,
		XPATH_NUMBER = 3,
		XPATH_STRING = 4,
		XPATH_USERS = 8,
		XPATH_XSLT_TREE = 9 /* An XSLT value tree, non modifiable */
	};

	/** DOC_DISABLE */
	const c_int XPATH_POINT = 5;
	const c_int XPATH_RANGE = 6;
	const c_int XPATH_LOCATIONSET = 7;
	/** DOC_ENABLE */

	public typealias xmlXPathObjectPtr = xmlXPathObject*;

	[CRepr]
	public struct xmlXPathObject
	{
		xmlXPathObjectType type;
		xmlNodeSetPtr nodesetval;
		c_int boolval;
		double floatval;
		xmlChar* stringval;
		void* user;
		c_int index;
		void* user2;
		c_int index2;
	};

	/**
	* xmlXPathConvertFunc:
	* @obj:  an XPath object
	* @type:  the number of the target type
	*
	* A conversion function is associated to a type and used to cast
	* the new type to primitive values.
	*
	* Returns -1 in case of error, 0 otherwise
	*/
	public function c_int xmlXPathConvertFunc(xmlXPathObjectPtr obj, c_int type);

	/*
	* Extra type: a name and a conversion function.
	*/
	public typealias xmlXPathTypePtr = xmlXPathType*;

	[CRepr]
	public struct xmlXPathType
	{
		xmlChar* name; /* the type name */
		xmlXPathConvertFunc func; /* the conversion function */
	};

	/*
	* Extra variable: a name and a value.
	*/
	public typealias xmlXPathVariablePtr = xmlXPathVariable*;

	[CRepr]
	public struct xmlXPathVariable
	{
		xmlChar       * name; /* the variable name */
		xmlXPathObjectPtr value; /* the value */
	};

	/**
	* xmlXPathEvalFunc:
	* @ctxt: an XPath parser context
	* @nargs: the number of arguments passed to the function
	*
	* An XPath evaluation function, the parameters are on the XPath context stack.
	*/

	public function void xmlXPathEvalFunc(xmlXPathParserContextPtr ctxt, c_int nargs);

	/*
	* Extra function: a name and a evaluation function.
	*/
	public typealias xmlXPathFuncPtr = xmlXPathFunct*;

	[CRepr]
	public struct xmlXPathFunct
	{
		xmlChar* name; /* the function name */
		xmlXPathEvalFunc func; /* the evaluation function */
	};

	/**
	* xmlXPathAxisFunc:
	* @ctxt:  the XPath interpreter context
	* @cur:  the previous node being explored on that axis
	*
	* An axis traversal function. To traverse an axis, the engine calls
	* the first time with cur == NULL and repeat until the function returns
	* NULL indicating the end of the axis traversal.
	*
	* Returns the next node in that axis or NULL if at the end of the axis.
	*/

	public function xmlXPathObjectPtr xmlXPathAxisFunc(xmlXPathParserContextPtr ctxt, xmlXPathObjectPtr cur);

	/*
	* Extra axis: a name and an axis function.
	*/
	public typealias xmlXPathAxisPtr = xmlXPathAxis*;

	[CRepr]
	public struct xmlXPathAxis
	{
		xmlChar* name; /* the axis name */
		xmlXPathAxisFunc func; /* the search function */
	};

	/**
	* xmlXPathFunction:
	* @ctxt:  the XPath interprestation context
	* @nargs:  the number of arguments
	*
	* An XPath function.
	* The arguments (if any) are popped out from the context stack
	* and the result is pushed on the stack.
	*/
	public function void xmlXPathFunction(xmlXPathParserContextPtr ctxt, c_int nargs);

	/*
	* Function and Variable Lookup.
	*/

	/**
	* xmlXPathVariableLookupFunc:
	* @ctxt:  an XPath context
	* @name:  name of the variable
	* @ns_uri:  the namespace name hosting this variable
	*
	* Prototype for callbacks used to plug variable lookup in the XPath
	* engine.
	*
	* Returns the XPath object value or NULL if not found.
	*/
	public function xmlXPathObjectPtr xmlXPathVariableLookupFunc(void* ctxt, xmlChar* name, xmlChar* ns_uri);

	/**
	* xmlXPathFuncLookupFunc:
	* @ctxt:  an XPath context
	* @name:  name of the function
	* @ns_uri:  the namespace name hosting this function
	*
	* Prototype for callbacks used to plug function lookup in the XPath
	* engine.
	*
	* Returns the XPath function or NULL if not found.
	*/
	public function xmlXPathFunction xmlXPathFuncLookupFunc(void* ctxt, xmlChar* name, xmlChar* ns_uri);

	/**
	* xmlXPathFlags:
	* Flags for XPath engine compilation and runtime
	*/

	/**
	* XML_XPATH_CHECKNS:
	*
	* check namespaces at compilation
	*/
	const c_int XML_XPATH_CHECKNS = 1 << 0;

	/**
	* XML_XPATH_NOVAR:
	*
	* forbid variables in expression
	*/
	const c_int XML_XPATH_NOVAR	  = 1 << 1;

	/**
	* xmlXPathContext:
	*
	* Expression evaluation occurs with respect to a context.
	* he context consists of:
	*    - a node (the context node)
	*    - a node list (the context node list)
	*    - a set of variable bindings
	*    - a function library
	*    - the set of namespace declarations in scope for the expression
	* Following the switch to hash tables, this need to be trimmed up at
	* the next binary incompatible release.
	* The node may be modified when the context is passed to libxml2
	* for an XPath evaluation so you may need to initialize it again
	* before the next call.
	*/

	[CRepr]
	public struct xmlXPathContext
	{
		xmlDocPtr doc; /* The current document */
		xmlNodePtr node; /* The current node */

		c_int nb_variables_unused; /* unused (hash table) */
		c_int max_variables_unused; /* unused (hash table) */
		xmlHashTablePtr varHash; /* Hash table of defined variables */

		c_int nb_types; /* number of defined types */
		c_int max_types; /* max number of types */
		xmlXPathTypePtr types; /* Array of defined types */

		c_int nb_funcs_unused; /* unused (hash table) */
		c_int max_funcs_unused; /* unused (hash table) */
		xmlHashTablePtr funcHash; /* Hash table of defined funcs */

		c_int nb_axis; /* number of defined axis */
		c_int max_axis; /* max number of axis */
		xmlXPathAxisPtr axis; /* Array of defined axis */

		/* the namespace nodes of the context node */
		xmlNsPtr* namespaces; /* Array of namespaces */
		c_int nsNr; /* number of namespace in scope */
		void* user; /* function to free */

		/* extra variables */
		c_int contextSize; /* the context size */
		c_int proximityPosition; /* the proximity position */

		/* extra stuff for XPointer */
		c_int xptr; /* is this an XPointer context? */
		xmlNodePtr here; /* for here() */
		xmlNodePtr origin; /* for origin() */

		/* the set of namespace declarations in scope for the expression */
		xmlHashTablePtr nsHash; /* The namespaces hash table */
		xmlXPathVariableLookupFunc varLookupFunc; /* variable lookup func */
		void* varLookupData; /* variable lookup data */

		/* Possibility to link in an extra item */
		void* extra; /* needed for XSLT */

		/* The function name and URI when calling a function */
		xmlChar* func;
		xmlChar* funcURI;

		/* function lookup function and data */
		xmlXPathFuncLookupFunc funcLookupFunc; /* function lookup func */
		void* funcLookupData; /* function lookup data */

		/* temporary namespace lists kept for walking the namespace axis */
		xmlNsPtr* tmpNsList; /* Array of namespaces */
		c_int tmpNsNr; /* number of namespaces in scope */

		/* error reporting mechanism */
		void* userData; /* user specific data block */
		xmlStructuredErrorFunc error; /* the callback in case of errors */
		xmlError lastError; /* the last error */
		xmlNodePtr debugNode; /* the source node XSLT */

		/* dictionary */
		xmlDictPtr dict; /* dictionary if any */

		c_int flags; /* flags to control compilation */

		/* Cache for reusal of XPath objects */
		void* cache;

		/* Resource limits */
		c_ulong opLimit;
		c_ulong opCount;
		c_int depth;
	};

	/*
	* The structure of a compiled expression form is not public.
	*/
	public struct xmlXPathCompExpr;
	typealias xmlXPathCompExprPtr = xmlXPathCompExpr*;

	/**
	* xmlXPathParserContext:
	*
	* An XPath parser context. It contains pure parsing information,
	* an xmlXPathContext, and the stack of objects.
	*/
	[CRepr]
	public struct xmlXPathParserContext
	{
		xmlChar* cur; /* the current char being parsed */
		xmlChar* base_; /* the full expression */

		c_int error; /* error code */

		xmlXPathContextPtr  context; /* the evaluation context */
		xmlXPathObjectPtr     value; /* the current value */
		c_int                 valueNr; /* number of values stacked */
		c_int                valueMax; /* max number of values stacked */
		xmlXPathObjectPtr* valueTab; /* stack of values */

		xmlXPathCompExprPtr comp; /* the precompiled expression */
		c_int xptr; /* it this an XPointer expression */
		xmlNodePtr         ancestor; /* used for walking preceding axis */

		c_int              valueFrame; /* always zero for compatibility */
	};

	/************************************************************************
	*									*
	*			Public API					*
	*									*
	************************************************************************/

	/**
	* Objects and Nodesets handling
	*/

	// XML_DEPRECATED
	// XMLPUBVAR double xmlXPathNAN;
	// XML_DEPRECATED
	// XMLPUBVAR double xmlXPathPINF;
	// XML_DEPRECATED
	// XMLPUBVAR double xmlXPathNINF;

	/* These macros may later turn into functions */
	/**
	* xmlXPathNodeSetGetLength:
	* @ns:  a node-set
	*
	* Implement a functionality similar to the DOM NodeList.length.
	*
	* Returns the number of nodes in the node-set.
	*/
	// #define xmlXPathNodeSetGetLength(ns) ((ns) ? (ns)->nodeNr : 0)
	/**
	* xmlXPathNodeSetItem:
	* @ns:  a node-set
	* @index:  index of a node in the set
	*
	* Implements a functionality similar to the DOM NodeList.item().
	*
	* Returns the xmlNodePtr at the given @index in @ns or NULL if
	*         @index is out of range (0 to length-1)
	*/
	// #define xmlXPathNodeSetItem(ns, index)((((ns) != NULL) && ((index) >= 0) && ((index) < (ns)->nodeNr)) ?	(ns)->nodeTab[(index)] : NULL)

	/**
	* xmlXPathNodeSetIsEmpty:
	* @ns: a node-set
	*
	* Checks whether @ns is empty or not.
	*
	* Returns %TRUE if @ns is an empty node-set.
	*/
	// #define xmlXPathNodeSetIsEmpty(ns) (((ns) == NULL) || ((ns)->nodeNr == 0) || ((ns)->nodeTab == NULL))

	[CLink] public static extern void xmlXPathFreeObject(xmlXPathObjectPtr obj);
	[CLink] public static extern xmlNodeSetPtr xmlXPathNodeSetCreate(xmlNodePtr val);
	[CLink] public static extern void xmlXPathFreeNodeSetList(xmlXPathObjectPtr obj);
	[CLink] public static extern void xmlXPathFreeNodeSet(xmlNodeSetPtr obj);
	[CLink] public static extern xmlXPathObjectPtr xmlXPathObjectCopy(xmlXPathObjectPtr val);
	[CLink] public static extern c_int xmlXPathCmpNodes(xmlNodePtr node1, xmlNodePtr node2);

	/**
	* Conversion functions to basic types.
	*/
	[CLink] public static extern c_int xmlXPathCastNumberToBoolean(double val);
	[CLink] public static extern c_int xmlXPathCastStringToBoolean(xmlChar* val);
	[CLink] public static extern c_int xmlXPathCastNodeSetToBoolean(xmlNodeSetPtr ns);
	[CLink] public static extern c_int xmlXPathCastToBoolean(xmlXPathObjectPtr val);

	[CLink] public static extern double xmlXPathCastBooleanToNumber(c_int val);
	[CLink] public static extern double xmlXPathCastStringToNumber(xmlChar* val);
	[CLink] public static extern double xmlXPathCastNodeToNumber(xmlNodePtr node);
	[CLink] public static extern double xmlXPathCastNodeSetToNumber(xmlNodeSetPtr ns);
	[CLink] public static extern double xmlXPathCastToNumber(xmlXPathObjectPtr val);

	[CLink] public static extern xmlChar* xmlXPathCastBooleanToString(c_int val);
	[CLink] public static extern xmlChar* xmlXPathCastNumberToString(double val);
	[CLink] public static extern xmlChar* xmlXPathCastNodeToString(xmlNodePtr node);
	[CLink] public static extern xmlChar* xmlXPathCastNodeSetToString(xmlNodeSetPtr ns);
	[CLink] public static extern xmlChar* xmlXPathCastToString(xmlXPathObjectPtr val);

	[CLink] public static extern xmlXPathObjectPtr xmlXPathConvertBoolean(xmlXPathObjectPtr val);
	[CLink] public static extern xmlXPathObjectPtr xmlXPathConvertNumber(xmlXPathObjectPtr val);
	[CLink] public static extern xmlXPathObjectPtr xmlXPathConvertString(xmlXPathObjectPtr val);

	/**
	* Context handling.
	*/
	[CLink] public static extern xmlXPathContextPtr xmlXPathNewContext(xmlDocPtr doc);
	[CLink] public static extern void xmlXPathFreeContext(xmlXPathContextPtr ctxt);
	[CLink] public static extern void xmlXPathSetErrorHandler(xmlXPathContextPtr ctxt, xmlStructuredErrorFunc handler, void* context);
	[CLink] public static extern c_int xmlXPathContextSetCache(xmlXPathContextPtr ctxt, c_int active, c_int value, c_int options);

	/**
	* Evaluation functions.
	*/
	[CLink] public static extern c_long xmlXPathOrderDocElems(xmlDocPtr doc);
	[CLink] public static extern c_int xmlXPathSetContextNode(xmlNodePtr node, xmlXPathContextPtr ctx);
	[CLink] public static extern xmlXPathObjectPtr xmlXPathNodeEval(xmlNodePtr node, xmlChar* str, xmlXPathContextPtr ctx);
	[CLink] public static extern xmlXPathObjectPtr xmlXPathEval(xmlChar* str, xmlXPathContextPtr ctx);
	[CLink] public static extern xmlXPathObjectPtr xmlXPathEvalExpression(xmlChar* str, xmlXPathContextPtr ctxt);
	[CLink] public static extern c_int xmlXPathEvalPredicate(xmlXPathContextPtr ctxt, xmlXPathObjectPtr res);

	/**
	* Separate compilation/evaluation entry points.
	*/
	[CLink] public static extern xmlXPathCompExprPtr xmlXPathCompile(xmlChar* str);
	[CLink] public static extern xmlXPathCompExprPtr xmlXPathCtxtCompile(xmlXPathContextPtr ctxt, xmlChar* str);
	[CLink] public static extern xmlXPathObjectPtr xmlXPathCompiledEval(xmlXPathCompExprPtr comp, xmlXPathContextPtr ctx);
	[CLink] public static extern c_int xmlXPathCompiledEvalToBoolean(xmlXPathCompExprPtr comp, xmlXPathContextPtr ctxt);
	[CLink] public static extern void xmlXPathFreeCompExpr(xmlXPathCompExprPtr comp);

	[CLink, Obsolete("")] public static extern void xmlXPathInit(void);
	[CLink] public static extern c_int xmlXPathIsNaN(double val);
	[CLink] public static extern c_int xmlXPathIsInf(double val);
}

#endif /* LIBXML_XPATH_ENABLED */ 
