/*
 * Summary: SAX2 parser interface used to build the DOM tree
 * Description: those are the default SAX2 interfaces used by
 *              the library when building DOM tree.
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
	[CLink] public static extern xmlChar* xmlSAX2GetPublicId(void* ctx);
	[CLink] public static extern xmlChar* xmlSAX2GetSystemId(void* ctx);
	[CLink] public static extern void xmlSAX2SetDocumentLocator(void* ctx, xmlSAXLocatorPtr loc);

	[CLink] public static extern int xmlSAX2GetLineNumber(void* ctx);
	[CLink] public static extern int xmlSAX2GetColumnNumber(void* ctx);

	[CLink] public static extern int xmlSAX2IsStandalone(void* ctx);
	[CLink] public static extern int xmlSAX2HasInternalSubset(void* ctx);
	[CLink] public static extern int xmlSAX2HasExternalSubset(void* ctx);

	[CLink] public static extern void xmlSAX2InternalSubset(void* ctx, xmlChar* name, xmlChar* ExternalID, xmlChar* SystemID);
	[CLink] public static extern void xmlSAX2ExternalSubset(void* ctx, xmlChar* name, xmlChar* ExternalID, xmlChar* SystemID);
	[CLink] public static extern xmlEntityPtr xmlSAX2GetEntity(void* ctx, xmlChar* name);
	[CLink] public static extern xmlEntityPtr xmlSAX2GetParameterEntity(void* ctx, xmlChar* name);
	[CLink] public static extern xmlParserInputPtr xmlSAX2ResolveEntity(void* ctx, xmlChar* publicId, xmlChar* systemId);

	[CLink] public static extern void xmlSAX2EntityDecl(void* ctx, xmlChar* name, c_int type, xmlChar* publicId, xmlChar* systemId, xmlChar* content);
	[CLink] public static extern void xmlSAX2AttributeDecl(void* ctx, xmlChar* elem, xmlChar* fullname, c_int type, c_int def, xmlChar* defaultValue, xmlEnumerationPtr tree);
	[CLink] public static extern void xmlSAX2ElementDecl(void* ctx, xmlChar* name, c_int type, xmlElementContentPtr content);
	[CLink] public static extern void xmlSAX2NotationDecl(void* ctx, xmlChar* name, xmlChar* publicId, xmlChar* systemId);
	[CLink] public static extern void xmlSAX2UnparsedEntityDecl(void* ctx, xmlChar* name, xmlChar* publicId, xmlChar* systemId, xmlChar* notationName);

	[CLink] public static extern void xmlSAX2StartDocument(void* ctx);
	[CLink] public static extern void xmlSAX2EndDocument(void* ctx);

	[CLink, Obsolete("")] public static extern void xmlSAX2StartElement(void* ctx, xmlChar* fullname, xmlChar** atts);

	[CLink, Obsolete("")] public static extern void xmlSAX2EndElement(void* ctx, xmlChar* name);
	[CLink] public static extern void xmlSAX2StartElementNs(void* ctx, xmlChar* localname, xmlChar* prefix, xmlChar* URI, c_int nb_namespaces, xmlChar** namespaces, c_int nb_attributes, c_int nb_defaulted, xmlChar** attributes);
	[CLink] public static extern void xmlSAX2EndElementNs(void* ctx, xmlChar* localname, xmlChar* prefix, xmlChar* URI);
	[CLink] public static extern void xmlSAX2Reference(void* ctx, xmlChar* name);
	[CLink] public static extern void xmlSAX2Characters(void* ctx, xmlChar* ch, c_int len);
	[CLink] public static extern void xmlSAX2IgnorableWhitespace(void* ctx, xmlChar* ch, c_int len);
	[CLink] public static extern void xmlSAX2ProcessingInstruction(void* ctx, xmlChar* target, xmlChar* data);
	[CLink] public static extern void xmlSAX2Comment(void* ctx, xmlChar* value);
	[CLink] public static extern void xmlSAX2CDataBlock(void* ctx, xmlChar* value, c_int len);

#if LIBXML_SAX1_ENABLED
	[CLink, Obsolete("")] public static extern int xmlSAXDefaultVersion(c_int version);
#endif /* LIBXML_SAX1_ENABLED */

	[CLink] public static extern int xmlSAXVersion(xmlSAXHandler* hdlr, c_int version);
	[CLink] public static extern void xmlSAX2InitDefaultSAXHandler(xmlSAXHandler* hdlr, c_int warning);

#if LIBXML_HTML_ENABLED
	[CLink] public static extern void xmlSAX2InitHtmlDefaultSAXHandle(xmlSAXHandler *hdlr);
	[CLink, Obsolete("")] public static extern void htmlDefaultSAXHandlerInit();
#endif

	[CLink, Obsolete("")] public static extern void xmlDefaultSAXHandlerInit();
}