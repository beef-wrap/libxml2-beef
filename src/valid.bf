/*
 * Summary: The DTD validation
 * Description: API for the DTD handling and the validity checking
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
	* Validation state added for non-determinist content model.
	*/
	[CRepr]
	public struct xmlValidState;
	typealias xmlValidStatePtr = xmlValidState*;

	/**
	* xmlValidityErrorFunc:
	* @ctx:  usually an xmlValidCtxtPtr to a validity error context,
	*        but comes from ctxt->userData (which normally contains such
	*        a pointer); ctxt->userData can be changed by the user.
	* @msg:  the string to format *printf like vararg
	* @...:  remaining arguments to the format
	*
	* Callback called when a validity error is found. This is a message
	* oriented function similar to an *printf function.
	*/
	public function void xmlValidityErrorFunc(void* ctx, char* msg, ...);

	/**
	* xmlValidityWarningFunc:
	* @ctx:  usually an xmlValidCtxtPtr to a validity error context,
	*        but comes from ctxt->userData (which normally contains such
	*        a pointer); ctxt->userData can be changed by the user.
	* @msg:  the string to format *printf like vararg
	* @...:  remaining arguments to the format
	*
	* Callback called when a validity warning is found. This is a message
	* oriented function similar to an *printf function.
	*/
	public function void xmlValidityWarningFunc(void* ctx, char* msg, ...);

	/*
	* xmlValidCtxt:
	* An xmlValidCtxt is used for error reporting when validating.
	*/
	typealias xmlValidCtxtPtr = xmlValidCtxt*;

	[CRepr]
	public struct xmlValidCtxt
	{
		void* userData; /* user specific data block */
		xmlValidityErrorFunc error; /* the callback in case of errors */
		xmlValidityWarningFunc warning; /* the callback in case of warning */

		/* Node analysis stack used when validating within entities */
		xmlNodePtr         node; /* Current parsed Node */
		c_int                nodeNr; /* Depth of the parsing stack */
		c_int                nodeMax; /* Max depth of the parsing stack */
		xmlNodePtr        * nodeTab; /* array of nodes */

		c_uint         flags; /* internal flags */
		xmlDocPtr              doc; /* the document */
		c_int                  valid; /* temporary validity check result */

		/* state state used for non-determinist content validation */
		xmlValidState     * vstate; /* current state */
		c_int                vstateNr; /* Depth of the validation stack */
		c_int                vstateMax; /* Max depth of the validation stack */
		xmlValidState     * vstateTab; /* array of validation states */

	#if LIBXML_REGEXP_ENABLED
		xmlAutomataPtr            am; /* the automata */
		xmlAutomataStatePtr    state; /* used to build the automata */
	#else
		void                     *am;
		void                  *state;
	#endif
	}

	/*
	* ALL notation declarations are stored in a table.
	* There is one table per DTD.
	*/

	[CRepr]
	public struct xmlNotationTable;
	typealias xmlNotationTablePtr = xmlNotationTable*;

	/*
	* ALL element declarations are stored in a table.
	* There is one table per DTD.
	*/

	[CRepr]
	public struct  xmlElementTable;
	typealias xmlElementTablePtr = xmlElementTable*;

	/*
	* ALL attribute declarations are stored in a table.
	* There is one table per DTD.
	*/

	[CRepr]
	public struct  xmlAttributeTable;
	typealias xmlAttributeTablePtr = xmlAttributeTable*;

	/*
	* ALL IDs attributes are stored in a table.
	* There is one table per document.
	*/

	[CRepr]
	public struct  xmlIDTable;
	typealias xmlIDTablePtr = xmlIDTable*;

	/*
	* ALL Refs attributes are stored in a table.
	* There is one table per document.
	*/

	[CRepr]
	public struct  xmlRefTable;
	typealias xmlRefTablePtr = xmlRefTable*;

	/* Notation */

	[CLink, Obsolete("")] public static extern xmlNotationPtr xmlAddNotationDecl(xmlValidCtxtPtr ctxt, xmlDtdPtr dtd, xmlChar* name, xmlChar* PublicID, xmlChar* SystemID);

	[CLink, Obsolete("")] public static extern xmlNotationTablePtr xmlCopyNotationTable(xmlNotationTablePtr table);

	[CLink, Obsolete("")] public static extern void xmlFreeNotationTable(xmlNotationTablePtr table);
#if LIBXML_OUTPUT_ENABLED

	[CLink, Obsolete("")] public static extern void xmlDumpNotationDecl(xmlBufferPtr buf, xmlNotationPtr nota);
	/* , still used in lxml */
	[CLink, Obsolete("")] public static extern void xmlDumpNotationTable(xmlBufferPtr buf, xmlNotationTablePtr table);
#endif /* LIBXML_OUTPUT_ENABLED */ 

	/* Element Content */
	/* the non Doc version are being deprecated */
	
	[CLink, Obsolete("")] public static extern xmlElementContentPtr xmlNewElementContent(xmlChar *name, xmlElementContentType type);
	
	[CLink, Obsolete("")] public static extern xmlElementContentPtr xmlCopyElementContent(xmlElementContentPtr content);
	
	[CLink, Obsolete("")] public static extern void xmlFreeElementContent(xmlElementContentPtr cur);
	/* the new versions with doc argument */
	
	[CLink, Obsolete("")] public static extern xmlElementContentPtr xmlNewDocElementContent(xmlDocPtr doc, xmlChar *name, xmlElementContentType type);
	
	[CLink, Obsolete("")] public static extern xmlElementContentPtr xmlCopyDocElementContent(xmlDocPtr doc, xmlElementContentPtr content);
	
	[CLink, Obsolete("")] public static extern void xmlFreeDocElementContent(xmlDocPtr doc, xmlElementContentPtr cur);
	
	[CLink, Obsolete("")] public static extern void xmlSnprintfElementContent(char *buf, c_int size, xmlElementContentPtr content, c_int englob);
#if LIBXML_OUTPUT_ENABLED
	
	[CLink, Obsolete("")] public static extern void xmlSprintfElementContent(char *buf, xmlElementContentPtr content, c_int englob);
#endif /* LIBXML_OUTPUT_ENABLED */

	/* Element */
	
	[CLink, Obsolete("")] public static extern xmlElementPtr xmlAddElementDecl(xmlValidCtxtPtr ctxt, xmlDtdPtr dtd, xmlChar *name, xmlElementTypeVal type, xmlElementContentPtr content);
	
	[CLink, Obsolete("")] public static extern xmlElementTablePtr xmlCopyElementTable(xmlElementTablePtr table);
	
	[CLink, Obsolete("")] public static extern void xmlFreeElementTable(xmlElementTablePtr table);
#if LIBXML_OUTPUT_ENABLED
	
	[CLink, Obsolete("")] public static extern void xmlDumpElementTable(xmlBufferPtr buf, xmlElementTablePtr table);
	
	[CLink, Obsolete("")] public static extern void xmlDumpElementDecl(xmlBufferPtr buf, xmlElementPtr elem);
#endif /* LIBXML_OUTPUT_ENABLED */

	/* Enumeration */
	
	[CLink, Obsolete("")] public static extern xmlEnumerationPtr xmlCreateEnumeration(xmlChar *name);
	/* , needed for custom attributeDecl SAX handler */
	[CLink, Obsolete("")] public static extern void xmlFreeEnumeration(xmlEnumerationPtr cur);
	
	[CLink, Obsolete("")] public static extern xmlEnumerationPtr xmlCopyEnumeration(xmlEnumerationPtr cur);

	/* Attribute */
	
	[CLink, Obsolete("")] public static extern xmlAttributePtr xmlAddAttributeDecl(xmlValidCtxtPtr ctxt, xmlDtdPtr dtd, xmlChar *elem, xmlChar *name, xmlChar *ns, xmlAttributeType type, xmlAttributeDefault def, xmlChar *defaultValue, xmlEnumerationPtr tree);
	
	[CLink, Obsolete("")] public static extern xmlAttributeTablePtr xmlCopyAttributeTable(xmlAttributeTablePtr table);
	
	[CLink, Obsolete("")] public static extern void xmlFreeAttributeTable(xmlAttributeTablePtr table);
#if LIBXML_OUTPUT_ENABLED
	
	[CLink, Obsolete("")] public static extern void xmlDumpAttributeTable(xmlBufferPtr buf, xmlAttributeTablePtr table);
	
	[CLink, Obsolete("")] public static extern void xmlDumpAttributeDecl(xmlBufferPtr buf, xmlAttributePtr attr);
#endif /* LIBXML_OUTPUT_ENABLED */

	/* IDs */
	[CLink] public static extern int xmlAddIDSafe(xmlAttrPtr attr, xmlChar *value);
	[CLink] public static extern xmlIDPtr xmlAddID(xmlValidCtxtPtr ctxt, xmlDocPtr doc, xmlChar *value, xmlAttrPtr attr);
	[CLink] public static extern void xmlFreeIDTable(xmlIDTablePtr table);
	[CLink] public static extern xmlAttrPtr xmlGetID(xmlDocPtr doc, xmlChar *ID);
	[CLink] public static extern int xmlIsID(xmlDocPtr doc, xmlNodePtr elem, xmlAttrPtr attr);
	[CLink] public static extern int xmlRemoveID(xmlDocPtr doc, xmlAttrPtr attr);

	/* IDREFs */
	
	[CLink, Obsolete("")] public static extern xmlRefPtr xmlAddRef(xmlValidCtxtPtr ctxt, xmlDocPtr doc, xmlChar *value, xmlAttrPtr attr);
	[CLink, Obsolete("")] public static extern void xmlFreeRefTable(xmlRefTablePtr table);
	[CLink, Obsolete("")] public static extern int xmlIsRef(xmlDocPtr doc, xmlNodePtr elem, xmlAttrPtr attr);
	[CLink, Obsolete("")] public static extern int xmlRemoveRef(xmlDocPtr doc, xmlAttrPtr attr);
	[CLink, Obsolete("")] public static extern xmlListPtr xmlGetRefs(xmlDocPtr doc, xmlChar *ID);

	/**
	* The public function calls related to validity checking.
	*/

#if LIBXML_VALID_ENABLED
	/* Allocate/Release Validation Contexts */
	[CLink] public static extern xmlValidCtxtPtr xmlNewValidCtxt(void);
	[CLink] public static extern void xmlFreeValidCtxt(xmlValidCtxtPtr);
	
	[CLink, Obsolete("")] public static extern int xmlValidateRoot	(xmlValidCtxtPtr ctxt, xmlDocPtr doc);	
	[CLink, Obsolete("")] public static extern int xmlValidateElementDecl(xmlValidCtxtPtr ctxt, xmlDocPtr doc, xmlElementPtr elem);	
	[CLink, Obsolete("")] public static extern xmlChar * xmlValidNormalizeAttributeValue(xmlDocPtr doc, xmlNodePtr elem, xmlChar *name, xmlChar *value);	
	[CLink, Obsolete("")] public static extern xmlChar * xmlValidCtxtNormalizeAttributeValue(xmlValidCtxtPtr ctxt, xmlDocPtr doc, xmlNodePtr elem, xmlChar *name, xmlChar *value);	
	[CLink, Obsolete("")] public static extern int xmlValidateAttributeDecl(xmlValidCtxtPtr ctxt, xmlDocPtr doc, xmlAttributePtr attr);	
	[CLink, Obsolete("")] public static extern int xmlValidateAttributeValue(xmlAttributeType type, xmlChar *value);	
	[CLink, Obsolete("")] public static extern int xmlValidateNotationDecl(xmlValidCtxtPtr ctxt, xmlDocPtr doc, xmlNotationPtr nota);
	[CLink] public static extern int xmlValidateDtd	(xmlValidCtxtPtr ctxt, xmlDocPtr doc, xmlDtdPtr dtd);	
	[CLink, Obsolete("")] public static extern int xmlValidateDtdFinal(xmlValidCtxtPtr ctxt, xmlDocPtr doc);
	[CLink] public static extern int xmlValidateDocument(xmlValidCtxtPtr ctxt, xmlDocPtr doc);
	[CLink] public static extern int xmlValidateElement(xmlValidCtxtPtr ctxt, xmlDocPtr doc, xmlNodePtr elem);	
	[CLink, Obsolete("")] public static extern int xmlValidateOneElement(xmlValidCtxtPtr ctxt, xmlDocPtr doc, xmlNodePtr elem);	
	[CLink, Obsolete("")] public static extern int xmlValidateOneAttribute(xmlValidCtxtPtr ctxt, xmlDocPtr doc, xmlNodePtr	elem, xmlAttrPtr attr, xmlChar *value);	
	[CLink, Obsolete("")] public static extern int xmlValidateOneNamespace(xmlValidCtxtPtr ctxt, xmlDocPtr doc, xmlNodePtr elem, xmlChar *prefix, xmlNsPtr ns, xmlChar *value);	
	[CLink, Obsolete("")] public static extern int xmlValidateDocumentFinal(xmlValidCtxtPtr ctxt, xmlDocPtr doc);	
	[CLink, Obsolete("")] public static extern int xmlValidateNotationUse(xmlValidCtxtPtr ctxt, xmlDocPtr doc, xmlChar *notationName);
#endif /* LIBXML_VALID_ENABLED */

	[CLink] public static extern int xmlIsMixedElement(xmlDocPtr doc, xmlChar *name);
	[CLink] public static extern xmlAttributePtr xmlGetDtdAttrDesc(xmlDtdPtr dtd, xmlChar *elem, xmlChar *name);
	[CLink] public static extern xmlAttributePtr xmlGetDtdQAttrDesc(xmlDtdPtr dtd, xmlChar *elem, xmlChar *name, xmlChar *prefix);
	[CLink] public static extern xmlNotationPtr xmlGetDtdNotationDesc(xmlDtdPtr dtd, xmlChar *name);
	[CLink] public static extern xmlElementPtr xmlGetDtdQElementDesc(xmlDtdPtr dtd, xmlChar *name, xmlChar *prefix);
	[CLink] public static extern xmlElementPtr xmlGetDtdElementDesc(xmlDtdPtr dtd, xmlChar *name);

#if LIBXML_VALID_ENABLED
	[CLink] public static extern int xmlValidGetPotentialChildren(xmlElementContent *ctree, xmlChar **names, c_int *len, c_int max);

	[CLink] public static extern int xmlValidGetValidElements(xmlNode *prev, xmlNode *next, xmlChar **names, c_int max);
	[CLink] public static extern int xmlValidateNameValue(xmlChar *value);
	[CLink] public static extern int xmlValidateNamesValue(xmlChar *value);
	[CLink] public static extern int xmlValidateNmtokenValue(xmlChar *value);
	[CLink] public static extern int xmlValidateNmtokensValue(xmlChar *value);

#if LIBXML_REGEXP_ENABLED

	/*
	* Validation based on the regexp support
	*/	
	[CLink, Obsolete("")] public static extern int xmlValidBuildContentModel(xmlValidCtxtPtr ctxt, xmlElementPtr elem);
	[CLink, Obsolete("")] public static extern int xmlValidatePushElement(xmlValidCtxtPtr ctxt, xmlDocPtr doc, xmlNodePtr elem, xmlChar *qname);
	[CLink, Obsolete("")] public static extern int xmlValidatePushCData(xmlValidCtxtPtr ctxt, xmlChar *data, c_int len);
	[CLink, Obsolete("")] public static extern int xmlValidatePopElement(xmlValidCtxtPtr ctxt, xmlDocPtr doc, xmlNodePtr elem, xmlChar *qname);
#endif /* LIBXML_REGEXP_ENABLED */

#endif /* LIBXML_VALID_ENABLED */

}