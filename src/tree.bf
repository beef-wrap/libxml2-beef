/*
 * Summary: interfaces for tree manipulation
 * Description: this module describes the structures found in an tree resulting
 *              from an XML or HTML parsing, as well as the API provided for
 *              various processing on that tree
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
	/*
	 * Some of the basic types pointer to structures:
	 */
	/* xmlIO.h */
	public typealias xmlParserInputBufferPtr = xmlParserInputBuffer*;

	public typealias xmlOutputBufferPtr = xmlOutputBuffer*;

	/* parser.h */
	public typealias xmlParserInputPtr = xmlParserInput*;

	public typealias xmlParserCtxtPtr = xmlParserCtxt*;

	public typealias xmlSAXLocatorPtr = xmlSAXLocator*;

	public typealias xmlSAXHandlerPtr = xmlSAXHandler*;

	/* entities.h */
	public typealias xmlEntityPtr = xmlEntity*;

	/**
	 * BASE_BUFFER_SIZE:
	 *
	 * default buffer size 4000.
	 */
	public const c_int BASE_BUFFER_SIZE = 4096;

	/**
	 * LIBXML_NAMESPACE_DICT:
	 *
	 * Defines experimental behaviour:
	 * 1) xmlNs gets an additional field @context (a xmlDoc)
	 * 2) when creating a tree, xmlNs->href is stored in the dict of xmlDoc.
	 */
	/* #define LIBXML_NAMESPACE_DICT */

	/**
	 * xmlBufferAllocationScheme:
	 *
	 * A buffer allocation scheme can be defined to either match exactly the
	 * need or double it's allocated size each time it is found too small.
	 */
	public enum xmlBufferAllocationScheme : c_int
	{
		XML_BUFFER_ALLOC_DOUBLEIT, /* double each time one need to grow */
		XML_BUFFER_ALLOC_EXACT, /* grow only to the minimal size */
		XML_BUFFER_ALLOC_IMMUTABLE, /* immutable buffer, deprecated */
		XML_BUFFER_ALLOC_IO, /* special allocation scheme used for I/O */
		XML_BUFFER_ALLOC_HYBRID, /* exact up to a threshold, and doubleit thereafter */
		XML_BUFFER_ALLOC_BOUNDED /* limit the upper size of the buffer */
	}

	/**
	 * xmlBuffer:
	 *
	 * A buffer structure, this old construct is limited to 2GB and
	 * is being deprecated, use API with xmlBuf instead
	 */
	public typealias xmlBufferPtr = xmlBuffer*;

	[CRepr]
	public struct xmlBuffer
	{
		/* The buffer content UTF8 */
		xmlChar* content; /* XML_DEPRECATED_MEMBER */
		/* The buffer size used */
		c_uint use; /* XML_DEPRECATED_MEMBER */
		/* The buffer size */
		c_uint size; /* XML_DEPRECATED_MEMBER */
		/* The realloc method */
		xmlBufferAllocationScheme alloc; /* XML_DEPRECATED_MEMBER */
		/* in IO mode we may have a different base */
		xmlChar* contentIO; /* XML_DEPRECATED_MEMBER */
	}

	/**
	 * xmlBuf:
	 *
	 * A buffer structure, new one, the actual structure internals are not public
	 */
	public struct xmlBuf;

	/**
	 * xmlBufPtr:
	 *
	 * A pointer to a buffer structure, the actual structure internals are not
	 * public
	 */
	public typealias xmlBufPtr = xmlBuf*;

	/*
	 * A few public routines for xmlBuf. As those are expected to be used
	 * mostly internally the bulk of the routines are internal in buf.h
	 */
	[CLink] public static extern xmlChar* xmlBufContent(xmlBuf* buf);
	[CLink] public static extern xmlChar* xmlBufEnd(xmlBufPtr buf);
	[CLink] public static extern size_t xmlBufUse(xmlBufPtr buf);
	[CLink] public static extern size_t xmlBufShrink(xmlBufPtr buf, size_t len);

	/*
	 * LIBXML2_NEW_BUFFER:
	 *
	 * Macro used to express that the API use the new buffers for
	 * xmlParserInputBuffer and xmlOutputBuffer. The change was
	 * introduced in 2.9.0.
	 */
	// #define LIBXML2_NEW_BUFFER

	/**
	 * XML_XML_NAMESPACE:
	 *
	 * This is the namespace for the special xml: prefix predefined in the
	 * XML Namespace specification.
	 */
	// #define XML_XML_NAMESPACE \
	//     (xmlChar* ) "http://www.w3.org/XML/1998/namespace"

	/**
	 * XML_XML_ID:
	 *
	 * This is the name for the special xml:id attribute
	 */
	// #define XML_XML_ID (xmlChar* ) "xml:id"

	/*
	 * The different element types carried by an XML tree.
	 *
	 * NOTE: This is synchronized with DOM Level1 values
	 *       See http://www.w3.org/TR/REC-DOM-Level-1/
	 *
	 * Actually this had diverged a bit, and now XML_DOCUMENT_TYPE_NODE should
	 * be deprecated to use an XML_DTD_NODE.
	 */
	public enum xmlElementType : c_int
	{
		XML_ELEMENT_NODE = 1,
		XML_ATTRIBUTE_NODE = 2,
		XML_TEXT_NODE = 3,
		XML_CDATA_SECTION_NODE = 4,
		XML_ENTITY_REF_NODE = 5,
		XML_ENTITY_NODE = 6, /* unused */
		XML_PI_NODE = 7,
		XML_COMMENT_NODE = 8,
		XML_DOCUMENT_NODE = 9,
		XML_DOCUMENT_TYPE_NODE = 10, /* unused */
		XML_DOCUMENT_FRAG_NODE = 11,
		XML_NOTATION_NODE = 12, /* unused */
		XML_HTML_DOCUMENT_NODE = 13,
		XML_DTD_NODE = 14,
		XML_ELEMENT_DECL = 15,
		XML_ATTRIBUTE_DECL = 16,
		XML_ENTITY_DECL = 17,
		XML_NAMESPACE_DECL = 18,
		XML_XINCLUDE_START = 19,
		XML_XINCLUDE_END = 20
		/* XML_DOCB_DOCUMENT_NODE=	21 */ /* removed */
	}

	/** DOC_DISABLE */
	/* For backward compatibility */
	public const c_int XML_DOCB_DOCUMENT_NODE = 21;
	/** DOC_ENABLE */

	/**
	 * xmlNotation:
	 *
	 * A DTD Notation definition.
	 */
	public typealias xmlNotationPtr = xmlNotation*;

	[CRepr]
	public struct xmlNotation
	{
		xmlChar* name; /* Notation name */
		xmlChar* PublicID; /* Public identifier, if any */
		xmlChar* SystemID; /* System identifier, if any */
	}

	/**
	 * xmlAttributeType:
	 *
	 * A DTD Attribute type definition.
	 */
	public enum xmlAttributeType : c_int
	{
		XML_ATTRIBUTE_CDATA = 1,
		XML_ATTRIBUTE_ID,
		XML_ATTRIBUTE_IDREF	,
		XML_ATTRIBUTE_IDREFS,
		XML_ATTRIBUTE_ENTITY,
		XML_ATTRIBUTE_ENTITIES,
		XML_ATTRIBUTE_NMTOKEN,
		XML_ATTRIBUTE_NMTOKENS,
		XML_ATTRIBUTE_ENUMERATION,
		XML_ATTRIBUTE_NOTATION
	}

	/**
	 * xmlAttributeDefault:
	 *
	 * A DTD Attribute default definition.
	 */
	public enum xmlAttributeDefault : c_int
	{
		XML_ATTRIBUTE_NONE = 1,
		XML_ATTRIBUTE_REQUIRED,
		XML_ATTRIBUTE_IMPLIED,
		XML_ATTRIBUTE_FIXED
	}

	/**
	 * xmlEnumeration:
	 *
	 * List structure used when there is an enumeration in DTDs.
	 */
	public typealias xmlEnumerationPtr = xmlEnumeration*;

	[CRepr]
	public struct xmlEnumeration
	{
		xmlEnumeration* next; /* next one */
		xmlChar* name; /* Enumeration name */
	}

	/**
	 * xmlAttribute:
	 *
	 * An Attribute declaration in a DTD.
	 */
	public typealias xmlAttributePtr = xmlAttribute*;

	[CRepr]
	public struct xmlAttribute
	{
		void* _private; /* application data */
		xmlElementType type; /* XML_ATTRIBUTE_DECL, must be second ! */
		xmlChar* name; /* Attribute name */
		xmlNode* children; /* NULL */
		xmlNode* last; /* NULL */
		xmlDtd* parent; /* -> DTD */
		xmlNode* next; /* next sibling link  */
		xmlNode* prev; /* previous sibling link  */
		xmlDoc* doc; /* the containing document */

		xmlAttribute* nexth; /* next in hash table */
		xmlAttributeType atype; /* The attribute type */
		xmlAttributeDefault def; /* the default */
		xmlChar* defaultValue; /* or the default value */
		xmlEnumerationPtr tree; /* or the enumeration tree if any */
		xmlChar* prefix; /* the namespace prefix if any */
		xmlChar* elem; /* Element holding the attribute */
	}

	/**
	 * xmlElementContentType:
	 *
	 * Possible definitions of element content types.
	 */
	public enum xmlElementContentType : c_int
	{
		XML_ELEMENT_CONTENT_PCDATA = 1,
		XML_ELEMENT_CONTENT_ELEMENT,
		XML_ELEMENT_CONTENT_SEQ,
		XML_ELEMENT_CONTENT_OR
	}

	/**
	 * xmlElementContentOccur:
	 *
	 * Possible definitions of element content occurrences.
	 */
	public enum xmlElementContentOccur : c_int
	{
		XML_ELEMENT_CONTENT_ONCE = 1,
		XML_ELEMENT_CONTENT_OPT,
		XML_ELEMENT_CONTENT_MULT,
		XML_ELEMENT_CONTENT_PLUS
	}

	/**
	 * xmlElementContent:
	 *
	 * An XML Element content as stored after parsing an element definition
	 * in a DTD.
	 */

	public typealias xmlElementContentPtr = xmlElementContent*;

	[CRepr]
	public struct xmlElementContent
	{
		xmlElementContentType type; /* PCDATA, ELEMENT, SEQ or OR */
		xmlElementContentOccur ocur; /* ONCE, OPT, MULT or PLUS */
		xmlChar* name; /* Element name */
		xmlElementContent* c1; /* first child */
		xmlElementContent* c2; /* second child */
		xmlElementContent* parent; /* parent */
		xmlChar* prefix; /* Namespace prefix */
	}

	/**
	 * xmlElementTypeVal:
	 *
	 * The different possibilities for an element content type.
	 */

	public enum xmlElementTypeVal : c_int
	{
		XML_ELEMENT_TYPE_UNDEFINED = 0,
		XML_ELEMENT_TYPE_EMPTY = 1,
		XML_ELEMENT_TYPE_ANY,
		XML_ELEMENT_TYPE_MIXED,
		XML_ELEMENT_TYPE_ELEMENT
	}

	/**
	 * xmlElement:
	 *
	 * An XML Element declaration from a DTD.
	 */

	public typealias xmlElementPtr = xmlElement*;

	[CRepr]
	public struct xmlElement
	{
		void* _private; /* application data */
		xmlElementType type; /* XML_ELEMENT_DECL, must be second ! */
		xmlChar* name; /* Element name */
		xmlNode* children; /* NULL */
		xmlNode* last; /* NULL */
		xmlDtd* parent; /* -> DTD */
		xmlNode* next; /* next sibling link  */
		xmlNode* prev; /* previous sibling link  */
		xmlDoc* doc; /* the containing document */

		xmlElementTypeVal etype; /* The type */
		xmlElementContentPtr content; /* the allowed element content */
		xmlAttributePtr attributes; /* List of the declared attributes */
		xmlChar* prefix; /* the namespace prefix if any */
	#if LIBXML_REGEXP_ENABLED
		xmlRegexpPtr       contModel; /* the validating regexp */
	#else
		void* contModel;
	#endif
	}


	/**
	 * XML_LOCAL_NAMESPACE:
	 *
	 * A namespace declaration node.
	 */
	// #define XML_LOCAL_NAMESPACE XML_NAMESPACE_DECL

	public typealias xmlNsType = xmlElementType;

	/**
	 * xmlNs:
	 *
	 * An XML namespace.
	 * Note that prefix == NULL is valid, it defines the default namespace
	 * within the subtree (until overridden).
	 *
	 * xmlNsType is unified with xmlElementType.
	 */

	public typealias xmlNsPtr = xmlNs*;

	[CRepr]
	public struct xmlNs
	{
		xmlNs* next; /* next Ns link for this node  */
		xmlNsType type; /* global or local */
		xmlChar* href; /* URL for the namespace */
		xmlChar* prefix; /* prefix for the namespace */
		void* _private; /* application data */
		xmlDoc* context; /* normally an xmlDoc */
	}

	/**
	 * xmlDtd:
	 *
	 * An XML DTD, as defined by <!DOCTYPE ... There is actually one for
	 * the internal subset and for the external subset.
	 */
	public typealias xmlDtdPtr = xmlDtd*;

	[CRepr]
	public struct xmlDtd
	{
		void* _private; /* application data */
		xmlElementType  type; /* XML_DTD_NODE, must be second ! */
		xmlChar* name; /* Name of the DTD */
		xmlNode* children; /* the value of the property link */
		xmlNode* last; /* last child link */
		xmlDoc* parent; /* child->parent link */
		xmlNode* next; /* next sibling link  */
		xmlNode* prev; /* previous sibling link  */
		xmlDoc* doc; /* the containing document */

		/* End of common part */
		void* notations; /* Hash table for notations if any */
		void* elements; /* Hash table for elements if any */
		void* attributes; /* Hash table for attributes if any */
		void* entities; /* Hash table for entities if any */
		xmlChar* ExternalID; /* External identifier for PUBLIC DTD */
		xmlChar* SystemID; /* URI for a SYSTEM or PUBLIC DTD */
		void* pentities; /* Hash table for param entities if any */
	}

	/**
	 * xmlAttr:
	 *
	 * An attribute on an XML node.
	 */
	public typealias xmlAttrPtr = xmlAttr*;

	[CRepr]
	public struct xmlAttr
	{
		void* _private; /* application data */
		xmlElementType type; /* XML_ATTRIBUTE_NODE, must be second ! */
		xmlChar* name; /* the name of the property */
		xmlNode* children; /* the value of the property */
		xmlNode* last; /* NULL */
		xmlNode* parent; /* child->parent link */
		xmlAttr* next; /* next sibling link  */
		xmlAttr* prev; /* previous sibling link  */
		xmlDoc* doc; /* the containing document */
		xmlNs* ns; /* pointer to the associated namespace */
		xmlAttributeType atype; /* the attribute type if validating */
		void* psvi; /* for type/PSVI information */
		xmlID* id; /* the ID struct */
	}

	/**
	 * xmlID:
	 *
	 * An XML ID instance.
	 */

	typealias xmlIDPtr = xmlID*;

	[CRepr]
	public struct xmlID
	{
		xmlID* next; /* next ID */
		xmlChar* value; /* The ID name */
		xmlAttrPtr attr; /* The attribute holding it */
		xmlChar* name; /* The attribute if attr is not available */
		c_int lineno; /* The line number if attr is not available */
		xmlDoc* doc; /* The document holding the ID */
	}

	/**
	 * xmlRef:
	 *
	 * An XML IDREF instance.
	 */

	public typealias xmlRefPtr = xmlRef*;

	[CRepr]
	public struct xmlRef
	{
		xmlRef* next; /* next Ref */
		xmlChar* value; /* The Ref name */
		xmlAttrPtr attr; /* The attribute holding it */
		xmlChar* name; /* The attribute if attr is not available */
		c_int lineno; /* The line number if attr is not available */
	}

	/**
	 * xmlNode:
	 *
	 * A node in an XML tree.
	 */
	public typealias xmlNodePtr = xmlNode*;

	[CRepr]
	public struct xmlNode
	{
		void* _private; /* application data */
		xmlElementType type; /* type number, must be second ! */
		xmlChar* name; /* the name of the node, or the entity */
		xmlNode* children; /* parent->childs link */
		xmlNode* last; /* last child link */
		xmlNode* parent; /* child->parent link */
		xmlNode* next; /* next sibling link  */
		xmlNode* prev; /* previous sibling link  */
		xmlDoc* doc; /* the containing document */

		/* End of common part */
		xmlNs* ns; /* pointer to the associated namespace */
		xmlChar* content; /* the content */
		xmlAttr* properties; /* properties list */
		xmlNs* nsDef; /* namespace definitions on this node */
		void* psvi; /* for type/PSVI information */
		c_ushort line; /* line number */
		c_ushort extra; /* extra data for XPath/XSLT */
	}

	/**
	 * XML_GET_CONTENT:
	 *
	 * Macro to extract the content pointer of a node.
	 */
	// #define XML_GET_CONTENT(n)					\
	//     ((n)->type == XML_ELEMENT_NODE ? NULL : (n)->content)

	/**
	 * XML_GET_LINE:
	 *
	 * Macro to extract the line number of an element node.
	 */
	// #define XML_GET_LINE(n)						\
	//     (xmlGetLineNo(n))

	/**
	 * xmlDocProperty
	 *
	 * Set of properties of the document as found by the parser
	 * Some of them are linked to similarly named xmlParserOption
	 */
	public enum xmlDocProperties : c_int
	{
		XML_DOC_WELLFORMED = 1 << 0, /* document is XML well formed */
		XML_DOC_NSVALID = 1 << 1, /* document is Namespace valid */
		XML_DOC_OLD10 = 1 << 2, /* parsed with old XML-1.0 parser */
		XML_DOC_DTDVALID = 1 << 3, /* DTD validation was successful */
		XML_DOC_XINCLUDE = 1 << 4, /* XInclude substitution was done */
		XML_DOC_USERBUILT = 1 << 5, /* Document was built using the API
											   and not by parsing an instance */
		XML_DOC_INTERNAL = 1 << 6, /* built for internal processing */
		XML_DOC_HTML = 1 << 7 /* parsed or built HTML document */
	}

	/**
	 * xmlDoc:
	 *
	 * An XML document.
	 */
	public typealias xmlDocPtr = xmlDoc*;

	[CRepr]
	public struct xmlDoc
	{
		void* _private; /* application data */
		xmlElementType type; /* XML_DOCUMENT_NODE, must be second ! */
		char* name; /* name/filename/URI of the document */
		xmlNode* children; /* the document tree */
		xmlNode* last; /* last child link */
		xmlNode* parent; /* child->parent link */
		xmlNode* next; /* next sibling link  */
		xmlNode* prev; /* previous sibling link  */
		xmlDoc* doc; /* autoreference to itself */

		/* End of common part */
		c_int compression; /* level of zlib compression */
		c_int standalone; /* standalone document (no external refs)
						 1 if standalone="yes"
						 0 if standalone="no"
						-1 if there is no XML declaration
						-2 if there is an XML declaration, but no
						standalone attribute was specified */
		xmlDtd* intSubset; /* the document internal subset */
		xmlDtd* extSubset; /* the document external subset */
		xmlNs* oldNs; /* Global namespace, the old way */
		xmlChar* version; /* the XML version string */
		xmlChar* encoding; /* actual encoding, if any */
		void* ids; /* Hash table for ID attributes if any */
		void* refs; /* Hash table for IDREFs attributes if any */
		xmlChar* URL; /* The URI for that document */
		c_int charset; /* unused */
		xmlDict* dict; /* dict used to allocate names or NULL */
		void* psvi; /* for type/PSVI information */
		c_int parseFlags; /* set of xmlParserOption used to parse the document */
		c_int properties; /* set of xmlDocProperties for this document set at the end of parsing */
	}


	public typealias xmlDOMWrapCtxtPtr = xmlDOMWrapCtxt*;

	public struct xmlDOMWrapCtxt;

	/**
	 * xmlDOMWrapAcquireNsFunction:
	 * @ctxt:  a DOM wrapper context
	 * @node:  the context node (element or attribute)
	 * @nsName:  the requested namespace name
	 * @nsPrefix:  the requested namespace prefix
	 *
	 * A function called to acquire namespaces (xmlNs) from the wrapper.
	 *
	 * Returns an xmlNsPtr or NULL in case of an error.
	 */
	public function xmlNsPtr xmlDOMWrapAcquireNsFunction(xmlDOMWrapCtxtPtr ctxt, xmlNodePtr node, xmlChar* nsName, xmlChar* nsPrefix);

	/**
	 * xmlDOMWrapCtxt:
	 *
	 * Context for DOM wrapper-operations.
	 */
	struct _xmlDOMWrapCtxt
	{
		void* _private;
		/*
		* The type of this context, just in case we need specialized
		* contexts in the future.
		*/
		c_int type;
		/*
		* Internal namespace map used for various operations.
		*/
		void* namespaceMap;
		/*
		* Use this one to acquire an xmlNsPtr intended for node->ns.
		* (Note that this is not intended for elem->nsDef).
		*/
		xmlDOMWrapAcquireNsFunction getNsForNodeFunc;
	}

	/**
	 * xmlRegisterNodeFunc:
	 * @node: the current node
	 *
	 * Signature for the registration callback of a created node
	 */
	public function void xmlRegisterNodeFunc(xmlNodePtr node);

	/**
	 * xmlDeregisterNodeFunc:
	 * @node: the current node
	 *
	 * Signature for the deregistration callback of a discarded node
	 */
	public function void xmlDeregisterNodeFunc(xmlNodePtr node);

	/**
	 * xmlChildrenNode:
	 *
	 * Macro for compatibility naming layer with libxml1. Maps
	 * to "children."
	 */
	// #if !xmlChildrenNode
	// #define xmlChildrenNode children
	// #endif

	/**
	 * xmlRootNode:
	 *
	 * Macro for compatibility naming layer with libxml1. Maps
	 * to "children".
	 */
	// #if !xmlRootNode
	// #define xmlRootNode children
	// #endif

	/*
	 * Variables.
	 */

	// XML_DEPRECATED
	// XMLPUBVAR xmlBufferAllocationScheme xmlBufferAllocScheme;
	// XML_DEPRECATED
	// XMLPUBVAR c_int xmlDefaultBufferSize;

#if LIBXML_THREAD_ENABLED
	/* backward compatibility */
	[CLink, Obsolete("")] public static extern xmlBufferAllocationScheme* __xmlBufferAllocScheme(void);
	[CLink, Obsolete("")] public static extern c_int* __xmlDefaultBufferSize(void);
#endif

	/** DOC_DISABLE */
	// #define XML_GLOBALS_TREE \
	//   XML_OP(xmlRegisterNodeDefaultValue, xmlRegisterNodeFunc, XML_DEPRECATED) \
	//   XML_OP(xmlDeregisterNodeDefaultValue, xmlDeregisterNodeFunc, \
	//    XML_DEPRECATED)
	
	// #define XML_OP XML_DECLARE_GLOBAL
	// XML_GLOBALS_TREE
	// #undef XML_OP
	
	// #if defined(LIBXML_THREAD_ENABLED) && !defined(XML_GLOBALS_NO_REDEFINITION)
	//   #define xmlRegisterNodeDefaultValue \
	//     XML_GLOBAL_MACRO(xmlRegisterNodeDefaultValue)
	//   #define xmlDeregisterNodeDefaultValue \
	//     XML_GLOBAL_MACRO(xmlDeregisterNodeDefaultValue)
	// #endif
	/** DOC_ENABLE */

	/*
	 * Some helper functions
	 */
	[CLink] public static extern int xmlValidateNCName(xmlChar* value, c_int space);

	[CLink] public static extern int xmlValidateQName(xmlChar* value, c_int space);
	[CLink] public static extern int xmlValidateName(xmlChar* value, c_int space);
	[CLink] public static extern int xmlValidateNMToken(xmlChar* value, c_int space);

	[CLink] public static extern xmlChar*  xmlBuildQName(xmlChar* ncname, xmlChar* prefix, xmlChar* memory, c_int len);
	[CLink] public static extern xmlChar*  xmlSplitQName2(xmlChar* name, xmlChar** prefix);
	[CLink] public static extern xmlChar*  xmlSplitQName3(xmlChar* name, c_int* len);

	/*
	 * Handling Buffers, the old ones see @xmlBuf for the new ones.
	 */

	[CLink, Obsolete("")] public static extern void xmlSetBufferAllocationSchem(xmlBufferAllocationScheme scheme);
	[CLink, Obsolete("")] public static extern xmlBufferAllocationScheme xmlGetBufferAllocationSchem(void);

	[CLink] public static extern xmlBufferPtr xmlBufferCreate(void);
	[CLink] public static extern xmlBufferPtr xmlBufferCreateSize(size_t size);
	[CLink] public static extern xmlBufferPtr xmlBufferCreateStatic(void* mem, size_t size);
	[CLink, Obsolete("")] public static extern int xmlBufferResize(xmlBufferPtr buf, c_uint size);
	[CLink] public static extern void xmlBufferFree(xmlBufferPtr buf);
	[CLink] public static extern int xmlBufferDump(FILE* file, xmlBufferPtr buf);
	[CLink] public static extern int xmlBufferAdd(xmlBufferPtr buf, xmlChar* str, c_int len);
	[CLink] public static extern int xmlBufferAddHead(xmlBufferPtr buf, xmlChar* str, c_int len);
	[CLink] public static extern int xmlBufferCat(xmlBufferPtr buf, xmlChar* str);
	[CLink] public static extern int xmlBufferCCat(xmlBufferPtr buf, char* str);
	[CLink, Obsolete("")] public static extern int xmlBufferShrink(xmlBufferPtr buf, c_uint len);
	[CLink, Obsolete("")] public static extern int xmlBufferGrow(xmlBufferPtr buf, c_uint len);
	[CLink] public static extern void xmlBufferEmpty(xmlBufferPtr buf);
	[CLink] public static extern xmlChar* xmlBufferContent(xmlBuffer* buf);
	[CLink] public static extern xmlChar* xmlBufferDetach(xmlBufferPtr buf);
	[CLink] public static extern void xmlBufferSetAllocationSchem(xmlBufferPtr buf, xmlBufferAllocationScheme scheme);
	[CLink] public static extern int xmlBufferLength(xmlBuffer* buf);

	/*
	 * Creating/freeing new structures.
	 */
	[CLink] public static extern xmlDtdPtr xmlCreateIntSubset(xmlDocPtr doc, xmlChar* name, xmlChar* ExternalID, xmlChar* SystemID);
	[CLink] public static extern xmlDtdPtr xmlNewDtd(xmlDocPtr doc, xmlChar* name, xmlChar* ExternalID, xmlChar* SystemID);
	[CLink] public static extern xmlDtdPtr xmlGetIntSubset(xmlDoc* doc);
	[CLink] public static extern void xmlFreeDtd(xmlDtdPtr cur);
	[CLink] public static extern xmlNsPtr xmlNewNs(xmlNodePtr node, xmlChar* href, xmlChar* prefix);
	[CLink] public static extern void xmlFreeNs(xmlNsPtr cur);
	[CLink] public static extern void xmlFreeNsList(xmlNsPtr cur);
	[CLink] public static extern xmlDocPtr xmlNewDoc(xmlChar* version);
	[CLink] public static extern void xmlFreeDoc(xmlDocPtr cur);
	[CLink] public static extern xmlAttrPtr xmlNewDocProp(xmlDocPtr doc, xmlChar* name, xmlChar* value);
	[CLink] public static extern xmlAttrPtr xmlNewProp(xmlNodePtr node, xmlChar* name, xmlChar* value);
	[CLink] public static extern xmlAttrPtr xmlNewNsProp(xmlNodePtr node, xmlNsPtr ns, xmlChar* name, xmlChar* value);
	[CLink] public static extern xmlAttrPtr xmlNewNsPropEatName(xmlNodePtr node, xmlNsPtr ns, xmlChar* name, xmlChar* value);
	[CLink] public static extern void xmlFreePropList(xmlAttrPtr cur);
	[CLink] public static extern void xmlFreeProp(xmlAttrPtr cur);
	[CLink] public static extern xmlAttrPtr xmlCopyProp(xmlNodePtr target, xmlAttrPtr cur);
	[CLink] public static extern xmlAttrPtr xmlCopyPropList(xmlNodePtr target, xmlAttrPtr cur);
	[CLink] public static extern xmlDtdPtr xmlCopyDtd(xmlDtdPtr dtd);
	[CLink] public static extern xmlDocPtr xmlCopyDoc(xmlDocPtr doc, c_int recursive);
	/*
	 * Creating new nodes.
	 */
	[CLink] public static extern xmlNodePtr xmlNewDocNode(xmlDocPtr doc, xmlNsPtr ns, xmlChar* name, xmlChar* content);
	[CLink] public static extern xmlNodePtr xmlNewDocNodeEatName(xmlDocPtr doc, xmlNsPtr ns, xmlChar* name, xmlChar* content);
	[CLink] public static extern xmlNodePtr xmlNewNode(xmlNsPtr ns, xmlChar* name);
	[CLink] public static extern xmlNodePtr xmlNewNodeEatName(xmlNsPtr ns, xmlChar* name);
	[CLink] public static extern xmlNodePtr xmlNewChild(xmlNodePtr parent, xmlNsPtr ns, xmlChar* name, xmlChar* content);
	[CLink] public static extern xmlNodePtr xmlNewDocText(xmlDoc* doc, xmlChar* content);
	[CLink] public static extern xmlNodePtr xmlNewText(xmlChar* content);
	[CLink] public static extern xmlNodePtr xmlNewDocPI(xmlDocPtr doc, xmlChar* name, xmlChar* content);
	[CLink] public static extern xmlNodePtr xmlNewPI(xmlChar* name, xmlChar* content);
	[CLink] public static extern xmlNodePtr xmlNewDocTextLen(xmlDocPtr doc, xmlChar* content, c_int len);
	[CLink] public static extern xmlNodePtr xmlNewTextLen(xmlChar* content, c_int len);
	[CLink] public static extern xmlNodePtr xmlNewDocComment(xmlDocPtr doc, xmlChar* content);
	[CLink] public static extern xmlNodePtr xmlNewComment(xmlChar* content);
	[CLink] public static extern xmlNodePtr xmlNewCDataBlock(xmlDocPtr doc, xmlChar* content, c_int len);
	[CLink] public static extern xmlNodePtr xmlNewCharRef(xmlDocPtr doc, xmlChar* name);
	[CLink] public static extern xmlNodePtr xmlNewReference(xmlDoc* doc, xmlChar* name);
	[CLink] public static extern xmlNodePtr xmlCopyNode(xmlNodePtr node, c_int recursive);
	[CLink] public static extern xmlNodePtr xmlDocCopyNode(xmlNodePtr node, xmlDocPtr doc, c_int recursive);
	[CLink] public static extern xmlNodePtr xmlDocCopyNodeList(xmlDocPtr doc, xmlNodePtr node);
	[CLink] public static extern xmlNodePtr xmlCopyNodeList(xmlNodePtr node);
	[CLink] public static extern xmlNodePtr xmlNewTextChild(xmlNodePtr parent, xmlNsPtr ns, xmlChar* name, xmlChar* content);
	[CLink] public static extern xmlNodePtr xmlNewDocRawNode(xmlDocPtr doc, xmlNsPtr ns, xmlChar* name, xmlChar* content);
	[CLink] public static extern xmlNodePtr xmlNewDocFragment(xmlDocPtr doc);

	/*
	 * Navigating.
	 */
	[CLink] public static extern c_long xmlGetLineNo(xmlNode* node);
	[CLink] public static extern xmlChar*  xmlGetNodePath(xmlNode* node);
	[CLink] public static extern xmlNodePtr xmlDocGetRootElement(xmlDoc* doc);
	[CLink] public static extern xmlNodePtr xmlGetLastChild(xmlNode* parent);
	[CLink] public static extern int xmlNodeIsText(xmlNode* node);
	[CLink] public static extern int xmlIsBlankNode(xmlNode* node);

	/*
	 * Changing the structure.
	 */
	[CLink] public static extern xmlNodePtr xmlDocSetRootElement(xmlDocPtr doc, xmlNodePtr root);
	[CLink] public static extern void xmlNodeSetName(xmlNodePtr cur, xmlChar* name);
	[CLink] public static extern xmlNodePtr xmlAddChild(xmlNodePtr parent, xmlNodePtr cur);
	[CLink] public static extern xmlNodePtr xmlAddChildList(xmlNodePtr parent, xmlNodePtr cur);
	[CLink] public static extern xmlNodePtr xmlReplaceNode(xmlNodePtr old, xmlNodePtr cur);
	[CLink] public static extern xmlNodePtr xmlAddPrevSibling(xmlNodePtr cur, xmlNodePtr elem);
	[CLink] public static extern xmlNodePtr xmlAddSibling(xmlNodePtr cur, xmlNodePtr elem);
	[CLink] public static extern xmlNodePtr xmlAddNextSibling(xmlNodePtr cur, xmlNodePtr elem);
	[CLink] public static extern void xmlUnlinkNode(xmlNodePtr cur);
	[CLink] public static extern xmlNodePtr xmlTextMerge(xmlNodePtr first, xmlNodePtr second);
	[CLink] public static extern int xmlTextConcat(xmlNodePtr node, xmlChar* content, c_int len);
	[CLink] public static extern void xmlFreeNodeList(xmlNodePtr cur);
	[CLink] public static extern void xmlFreeNode(xmlNodePtr cur);
	[CLink] public static extern int xmlSetTreeDoc(xmlNodePtr tree, xmlDocPtr doc);
	[CLink] public static extern int xmlSetListDoc(xmlNodePtr list, xmlDocPtr doc);
	/*
	 * Namespaces.
	 */
	[CLink] public static extern xmlNsPtr xmlSearchNs(xmlDocPtr doc, xmlNodePtr node, xmlChar* nameSpace);
	[CLink] public static extern xmlNsPtr xmlSearchNsByHref(xmlDocPtr doc, xmlNodePtr node, xmlChar* href);
	[CLink] public static extern int xmlGetNsListSafe(xmlDoc* doc, xmlNode* node, xmlNsPtr** out_);
	[CLink] public static extern xmlNsPtr* xmlGetNsList(xmlDoc* doc, xmlNode* node);

	[CLink] public static extern void xmlSetNs(xmlNodePtr node, xmlNsPtr ns);
	[CLink] public static extern xmlNsPtr xmlCopyNamespace(xmlNsPtr cur);
	[CLink] public static extern xmlNsPtr xmlCopyNamespaceList(xmlNsPtr cur);

	/*
	 * Changing the content.
	 */
	[CLink] public static extern xmlAttrPtr xmlSetProp(xmlNodePtr node, xmlChar* name, xmlChar* value);
	[CLink] public static extern xmlAttrPtr xmlSetNsProp(xmlNodePtr node, xmlNsPtr ns, xmlChar* name, xmlChar* value);
	[CLink] public static extern int xmlNodeGetAttrValue(xmlNode* node, xmlChar* name, xmlChar* nsUri, xmlChar** out_);
	[CLink] public static extern xmlChar*  xmlGetNoNsProp(xmlNode* node, xmlChar* name);
	[CLink] public static extern xmlChar*  xmlGetProp(xmlNode* node, xmlChar* name);
	[CLink] public static extern xmlAttrPtr xmlHasProp(xmlNode* node, xmlChar* name);
	[CLink] public static extern xmlAttrPtr xmlHasNsProp(xmlNode* node, xmlChar* name, xmlChar* nameSpace);
	[CLink] public static extern xmlChar*  xmlGetNsProp(xmlNode* node, xmlChar* name, xmlChar* nameSpace);
	[CLink] public static extern xmlNodePtr xmlStringGetNodeList(xmlDoc* doc, xmlChar* value);
	[CLink] public static extern xmlNodePtr xmlStringLenGetNodeList(xmlDoc* doc, xmlChar* value, c_int len);
	[CLink] public static extern xmlChar*  xmlNodeListGetString(xmlDocPtr doc, xmlNode* list, c_int inLine);
	[CLink] public static extern xmlChar*  xmlNodeListGetRawString(xmlDoc* doc, xmlNode* list, c_int inLine);
	[CLink] public static extern int xmlNodeSetContent(xmlNodePtr cur, xmlChar* content);
	[CLink] public static extern int xmlNodeSetContentLen(xmlNodePtr cur, xmlChar* content, c_int len);
	[CLink] public static extern int xmlNodeAddContent(xmlNodePtr cur, xmlChar* content);
	[CLink] public static extern int xmlNodeAddContentLen(xmlNodePtr cur, xmlChar* content, c_int len);
	[CLink] public static extern xmlChar*  xmlNodeGetContent(xmlNode* cur);

	[CLink] public static extern int xmlNodeBufGetContent(xmlBufferPtr buffer, xmlNode* cur);
	[CLink] public static extern int xmlBufGetNodeContent(xmlBufPtr buf, xmlNode* cur);

	[CLink] public static extern xmlChar*  xmlNodeGetLang(xmlNode* cur);
	[CLink] public static extern int xmlNodeGetSpacePreserve(xmlNode* cur);
	[CLink] public static extern int xmlNodeSetLang(xmlNodePtr cur, xmlChar* lang);
	[CLink] public static extern int xmlNodeSetSpacePreserve(xmlNodePtr cur, c_int val);
	[CLink] public static extern int xmlNodeGetBaseSafe(xmlDoc* doc, xmlNode* cur, xmlChar** baseOut);
	[CLink] public static extern xmlChar*  xmlNodeGetBase(xmlDoc* doc, xmlNode* cur);
	[CLink] public static extern int xmlNodeSetBase(xmlNodePtr cur, xmlChar* uri);

	/*
	 * Removing content.
	 */
	[CLink] public static extern int xmlRemoveProp(xmlAttrPtr cur);
	[CLink] public static extern int xmlUnsetNsProp(xmlNodePtr node, xmlNsPtr ns, xmlChar* name);
	[CLink] public static extern int xmlUnsetProp(xmlNodePtr node, xmlChar* name);

	/*
	 * Internal, don't use.
	 */
	[CLink] public static extern void xmlBufferWriteCHAR(xmlBufferPtr buf, xmlChar* string);
	[CLink] public static extern void xmlBufferWriteChar(xmlBufferPtr buf, char* string);
	[CLink] public static extern void xmlBufferWriteQuotedStrin(xmlBufferPtr buf, xmlChar* string);

#if LIBXML_OUTPUT_ENABLED
	[CLink] public static extern void xmlAttrSerializeTxtConten(xmlBufferPtr buf, xmlDocPtr doc, xmlAttrPtr attr, xmlChar* string);
#endif

/*
 * Namespace handling.
 */
	[CLink] public static extern int xmlReconciliateNs(xmlDocPtr doc, xmlNodePtr tree);

#if LIBXML_OUTPUT_ENABLED
	/*
	* Saving.
	*/
	[CLink] public static extern void xmlDocDumpFormatMemory(xmlDocPtr cur, xmlChar** mem, c_int* size, c_int format);
	[CLink] public static extern void xmlDocDumpMemory(xmlDocPtr cur, xmlChar** mem, c_int* size);
	[CLink] public static extern void xmlDocDumpMemoryEnc(xmlDocPtr out_doc, xmlChar** doc_txt_ptr, c_int* doc_txt_len, char* txt_encoding);
	[CLink] public static extern void xmlDocDumpFormatMemoryEn(xmlDocPtr out_doc, xmlChar** doc_txt_ptr, c_int* doc_txt_len, char* txt_encoding, c_int format);
	[CLink] public static extern int xmlDocFormatDump(FILE* f, xmlDocPtr cur, c_int format);
	[CLink] public static extern int xmlDocDump(FILE* f, xmlDocPtr cur);
	[CLink] public static extern void xmlElemDump(FILE* f, xmlDocPtr doc, xmlNodePtr cur);
	[CLink] public static extern int xmlSaveFile(char* filename, xmlDocPtr cur);
	[CLink] public static extern int xmlSaveFormatFile(char* filename, xmlDocPtr cur, c_int format);
	[CLink] public static extern size_t xmlBufNodeDump(xmlBufPtr buf, xmlDocPtr doc, xmlNodePtr cur, c_int level, c_int format);
	[CLink] public static extern int xmlNodeDump(xmlBufferPtr buf, xmlDocPtr doc, xmlNodePtr cur, c_int level, c_int format);

	[CLink] public static extern int xmlSaveFileTo(xmlOutputBufferPtr buf, xmlDocPtr cur, char* encoding);
	[CLink] public static extern int xmlSaveFormatFileTo(xmlOutputBufferPtr buf, xmlDocPtr cur, char* encoding, c_int format);
	[CLink] public static extern void xmlNodeDumpOutput(xmlOutputBufferPtr buf, xmlDocPtr doc, xmlNodePtr cur, c_int level, c_int format, char* encoding);

	[CLink] public static extern int xmlSaveFormatFileEnc(char* filename, xmlDocPtr cur, char* encoding, c_int format);

	[CLink] public static extern int xmlSaveFileEnc(char* filename, xmlDocPtr cur, char* encoding);
#endif /* LIBXML_OUTPUT_ENABLED */ 

	/*
	* XHTML
	*/
	[CLink] public static extern int xmlIsXHTML(xmlChar* systemID, xmlChar* publicID);

	/*
	* Compression.
	*/
	[CLink] public static extern int xmlGetDocCompressMode(xmlDoc* doc);
	[CLink] public static extern void xmlSetDocCompressMode(xmlDocPtr doc, c_int mode);
	[CLink, Obsolete("")] public static extern int xmlGetCompressMode(void);
	[CLink, Obsolete("")] public static extern void xmlSetCompressMode(c_int mode);

	/*
	* DOM-wrapper helper functions.
	*/
	[CLink] public static extern xmlDOMWrapCtxtPtr xmlDOMWrapNewCtxt(void);
	[CLink] public static extern void xmlDOMWrapFreeCtxt(xmlDOMWrapCtxtPtr ctxt);
	[CLink] public static extern int xmlDOMWrapReconcileNamespace(xmlDOMWrapCtxtPtr ctxt, xmlNodePtr elem, c_int options);
	[CLink] public static extern int xmlDOMWrapAdoptNode(xmlDOMWrapCtxtPtr ctxt, xmlDocPtr sourceDoc, xmlNodePtr node, xmlDocPtr destDoc, xmlNodePtr destParent, c_int options);
	[CLink] public static extern int xmlDOMWrapRemoveNode(xmlDOMWrapCtxtPtr ctxt, xmlDocPtr doc, xmlNodePtr node, c_int options);
	[CLink] public static extern int xmlDOMWrapCloneNode(xmlDOMWrapCtxtPtr ctxt, xmlDocPtr sourceDoc, xmlNodePtr node, xmlNodePtr* clonedNode, xmlDocPtr destDoc, xmlNodePtr destParent, c_int deep, c_int options);

	/*
	* 5 interfaces from DOM ElementTraversal, but different in entities
	* traversal.
	*/
	[CLink] public static extern c_ulong xmlChildElementCount(xmlNodePtr parent);
	[CLink] public static extern xmlNodePtr xmlNextElementSibling(xmlNodePtr node);
	[CLink] public static extern xmlNodePtr xmlFirstElementChild(xmlNodePtr parent);
	[CLink] public static extern xmlNodePtr xmlLastElementChild(xmlNodePtr parent);
	[CLink] public static extern xmlNodePtr xmlPreviousElementSibling(xmlNodePtr node);


	[CLink, Obsolete("")] public static extern xmlRegisterNodeFunc xmlRegisterNodeDefault(xmlRegisterNodeFunc func);
	[CLink, Obsolete("")] public static extern xmlDeregisterNodeFunc xmlDeregisterNodeDefault(xmlDeregisterNodeFunc func);
	[CLink, Obsolete("")] public static extern xmlRegisterNodeFunc xmlThrDefRegisterNodeDefaul(xmlRegisterNodeFunc func);
	[CLink, Obsolete("")] public static extern xmlDeregisterNodeFunc xmlThrDefDeregisterNodeDefaul(xmlDeregisterNodeFunc func);
	[CLink, Obsolete("")] public static extern xmlBufferAllocationScheme xmlThrDefBufferAllocScheme(xmlBufferAllocationScheme v);
	[CLink, Obsolete("")] public static extern int xmlThrDefDefaultBufferSize(c_int v);
}