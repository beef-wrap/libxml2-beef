/*
 * Summary: the core parser module
 * Description: Interfaces, constants and types related to the XML parser
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
  /**
  * XML_DEFAULT_VERSION:
  *
  * The default version of XML used: 1.0
  */
	const char* XML_DEFAULT_VERSION =	"1.0";

	const c_int XML_STATUS_NOT_WELL_FORMED          = 1 << 0;
	const c_int XML_STATUS_NOT_NS_WELL_FORMED       = 1 << 1;
	const c_int XML_STATUS_DTD_VALIDATION_FAILED    = 1 << 2;
	const c_int XML_STATUS_CATASTROPHIC_ERROR       = 1 << 3;

	public enum xmlResourceType : c_int
	{
		XML_RESOURCE_UNKNOWN = 0,
		XML_RESOURCE_MAIN_DOCUMENT,
		XML_RESOURCE_DTD,
		XML_RESOURCE_GENERAL_ENTITY,
		XML_RESOURCE_PARAMETER_ENTITY,
		XML_RESOURCE_XINCLUDE,
		XML_RESOURCE_XINCLUDE_TEXT
	}

	  /**
	  * xmlParserInput:
	  *
	  * An xmlParserInput is an input flow for the XML processor.
	  * Each entity parsed is associated an xmlParserInput (except the
	  * few predefined ones). This is the case both for internal entities
	  * - in which case the flow is already completely in memory - or
	  * external entities - in which case we use the buf structure for
	  * progressive reading and I18N conversions to the internal UTF-8 format.
	  */

	  /**
	  * xmlParserInputDeallocate:
	  * @str:  the string to deallocate
	  *
	  * Callback for freeing some parser input allocations.
	  */
	public function void xmlParserInputDeallocate(xmlChar* str);

	[CRepr]
	public struct xmlParserInput
	{
	  /* Input buffer */
		xmlParserInputBufferPtr buf;
	  /* The file analyzed, if any */
		char* filename;
	  /* unused */
		char* directory; /* XML_DEPRECATED_MEMBER */
	  /* Base of the array to parse */
		xmlChar* base_;
	  /* Current char being parsed */
		xmlChar* cur;
	  /* end of the array to parse */
		xmlChar* end;
	  /* unused */
		c_int length; /* XML_DEPRECATED_MEMBER */
	  /* Current line */
		c_int line;
	  /* Current column */
		c_int col;
	  /* How many xmlChars already consumed */
		c_ulong consumed; /* XML_DEPRECATED_MEMBER */
	  /* function to deallocate the base */
		xmlParserInputDeallocate free; /* XML_DEPRECATED_MEMBER */
	  /* unused */
		xmlChar* encoding; /* XML_DEPRECATED_MEMBER */
	  /* the version string for entity */
		xmlChar* version; /* XML_DEPRECATED_MEMBER */
	  /* Flags */
		c_int flags; /* XML_DEPRECATED_MEMBER */
	  /* an unique identifier for the entity */
		c_int id; /* XML_DEPRECATED_MEMBER */
	  /* unused */
		c_ulong parentConsumed; /* XML_DEPRECATED_MEMBER */
	  /* entity, if any */
		xmlEntityPtr entity; /* XML_DEPRECATED_MEMBER */
	}

	/**
	* xmlParserNodeInfo:
	*
	* The parser can be asked to collect Node information, i.e. at what
	* place in the file they were detected.
	* NOTE: This is off by default and not very well tested.
	*/

	typealias xmlParserNodeInfoPtr = xmlParserNodeInfo*;

	[CRepr]
	public struct xmlParserNodeInfo
	{
		xmlNode* node;
		/* Position & line # that text that created the node begins & ends on */
		c_ulong begin_pos;
		c_ulong begin_line;
		c_ulong end_pos;
		c_ulong end_line;
	}

	typealias xmlParserNodeInfoSeqPtr = xmlParserNodeInfoSeq*;

	[CRepr]
	public struct xmlParserNodeInfoSeq
	{
		c_ulong maximum;
		c_ulong length;
		xmlParserNodeInfo* buffer;
	}

	/**
	* xmlParserInputState:
	*
	* The parser is now working also as a state based parser.
	* The recursive one use the state info for entities processing.
	*/
	public enum xmlParserInputState : c_int
	{
		XML_PARSER_EOF = -1, /* nothing is to be parsed */
		XML_PARSER_START = 0, /* nothing has been parsed */
		XML_PARSER_MISC, /* Misc* before c_int subset */
		XML_PARSER_PI, /* Within a processing instruction */
		XML_PARSER_DTD, /* within some DTD content */
		XML_PARSER_PROLOG, /* Misc* after internal subset */
		XML_PARSER_COMMENT, /* within a comment */
		XML_PARSER_START_TAG, /* within a start tag */
		XML_PARSER_CONTENT, /* within the content */
		XML_PARSER_CDATA_SECTION, /* within a CDATA section */
		XML_PARSER_END_TAG, /* within a closing tag */
		XML_PARSER_ENTITY_DECL, /* within an entity declaration */
		XML_PARSER_ENTITY_VALUE, /* within an entity value in a decl */
		XML_PARSER_ATTRIBUTE_VALUE, /* within an attribute value */
		XML_PARSER_SYSTEM_LITERAL, /* within a SYSTEM value */
		XML_PARSER_EPILOG, /* the Misc* after the last end tag */
		XML_PARSER_IGNORE, /* within an IGNORED section */
		XML_PARSER_PUBLIC_LITERAL, /* within a PUBLIC value */
		XML_PARSER_XML_DECL /* before XML decl (but after BOM) */
	}

	/*
	* Internal bits in the 'loadsubset' context member
	*/
	const c_int XML_DETECT_IDS		= 2;
	const c_int XML_COMPLETE_ATTRS	= 4;
	const c_int XML_SKIP_IDS		= 8;

	/**
	* xmlParserMode:
	*
	* A parser can operate in various modes
	*/
	public enum xmlParserMode : c_int
	{
		XML_PARSE_UNKNOWN = 0,
		XML_PARSE_DOM = 1,
		XML_PARSE_SAX = 2,
		XML_PARSE_PUSH_DOM = 3,
		XML_PARSE_PUSH_SAX = 4,
		XML_PARSE_READER = 5
	}

	public struct xmlStartTag;

	public struct xmlParserNsData;

	public struct xmlAttrHashBucket;

	public function c_int xmlResourceLoader(void* ctxt, char* url, char* publicId, xmlResourceType type, c_int flags, xmlParserInputPtr* out_);

	/**
	* xmlParserCtxt:
	*
	* The parser context.
	* NOTE This doesn't completely define the parser state, the (current ?)
	*      design of the parser uses recursive function calls since this allow
	*      and easy mapping from the production rules of the specification
	*      to the actual code. The drawback is that the actual function call
	*      also reflect the parser state. However most of the parsing routines
	*      takes as the only argument the parser context pointer, so migrating
	*      to a state based parser for progressive parsing shouldn't be too hard.
	*/
	[CRepr]
	public struct xmlParserCtxt
	{
		/* The SAX handler */
		xmlSAXHandler* sax;
		/* For SAX interface only, used by DOM build */
		void* userData;
		/* the document being built */
		xmlDocPtr myDoc;
		/* is the document well formed */
		c_int wellFormed;
		/* shall we replace entities ? */
		c_int replaceEntities; /* XML_DEPRECATED_MEMBER */
		/* the XML version string */
		xmlChar* version;
		/* the declared encoding, if any */
		xmlChar* encoding;
		/* standalone document */
		c_int standalone;

		/* an HTML(1) document
		* 3 is HTML after <head>
		* 10 is HTML after <body>
		*/
		c_int html;

		/* Input stream stack */

		/* Current input stream */
		xmlParserInputPtr input;
		/* Number of current input streams */
		c_int inputNr;
		/* Max number of input streams */
		c_int inputMax; /* XML_DEPRECATED_MEMBER */
		/* stack of inputs */
		xmlParserInputPtr* inputTab;

		/* Node analysis stack only used for DOM building */

		/* Current parsed Node */
		xmlNodePtr node; /* XML_DEPRECATED_MEMBER */
		/* Depth of the parsing stack */
		c_int nodeNr; /* XML_DEPRECATED_MEMBER */
		/* Max depth of the parsing stack */
		c_int nodeMax; /* XML_DEPRECATED_MEMBER */
		/* array of nodes */
		xmlNodePtr* nodeTab; /* XML_DEPRECATED_MEMBER */

		/* Whether node info should be kept */
		c_int record_info;
		/* info about each node parsed */
		xmlParserNodeInfoSeq node_seq; /* XML_DEPRECATED_MEMBER */

		/* error code */
		c_int errNo;

		/* reference and external subset */
		c_int hasExternalSubset; /* XML_DEPRECATED_MEMBER */
		/* the internal subset has PE refs */
		c_int hasPErefs; /* XML_DEPRECATED_MEMBER */
		/* unused */
		c_int external; /* XML_DEPRECATED_MEMBER */

		/* is the document valid */
		c_int valid;
		/* shall we try to validate ? */
		c_int validate; /* XML_DEPRECATED_MEMBER */
		/* The validity context */
		xmlValidCtxt vctxt;

		/* push parser state */
		xmlParserInputState instate; /* XML_DEPRECATED_MEMBER */
		/* unused */
		c_int token; /* XML_DEPRECATED_MEMBER */

		/* unused internally, still used downstream */
		char* directory;

		/* Node name stack */

		/* Current parsed Node */
		xmlChar* name; /* XML_DEPRECATED_MEMBER */
		/* Depth of the parsing stack */
		c_int nameNr; /* XML_DEPRECATED_MEMBER */
		/* Max depth of the parsing stack */
		c_int nameMax; /* XML_DEPRECATED_MEMBER */
		/* array of nodes */
		xmlChar** nameTab; /* XML_DEPRECATED_MEMBER */

		/* unused */
		c_long nbChars; /* XML_DEPRECATED_MEMBER */
		/* used by progressive parsing lookup */
		c_long checkIndex; /* XML_DEPRECATED_MEMBER */
		/* ugly but ... */
		c_int keepBlanks; /* XML_DEPRECATED_MEMBER */
		/* SAX callbacks are disabled */
		c_int disableSAX; /* XML_DEPRECATED_MEMBER */
		/* Parsing is in c_int 1/ext 2 subset */
		c_int inSubset;
		/* name of subset */
		xmlChar* intSubName;
		/* URI of external subset */
		xmlChar* extSubURI;
		/* SYSTEM ID of external subset */
		xmlChar* extSubSystem;

		/* xml:space values */

		/* Should the parser preserve spaces */
		c_int* space; /* XML_DEPRECATED_MEMBER */
		/* Depth of the parsing stack */
		c_int spaceNr; /* XML_DEPRECATED_MEMBER */
		/* Max depth of the parsing stack */
		c_int spaceMax; /* XML_DEPRECATED_MEMBER */
		/* array of space infos */
		c_int* spaceTab; /* XML_DEPRECATED_MEMBER */

		/* to prevent entity substitution loops */
		c_int depth; /* XML_DEPRECATED_MEMBER */
		/* unused */
		xmlParserInputPtr entity; /* XML_DEPRECATED_MEMBER */
		/* unused */
		c_int charset; /* XML_DEPRECATED_MEMBER */
		/* Those two fields are there to */
		c_int nodelen; /* XML_DEPRECATED_MEMBER */
		/* Speed up large node parsing */
		c_int nodemem; /* XML_DEPRECATED_MEMBER */
		/* signal pedantic warnings */
		c_int pedantic; /* XML_DEPRECATED_MEMBER */
		/* For user data, libxml won't touch it */
		void* _private;

		/* should the external subset be loaded */
		c_int loadsubset; /* XML_DEPRECATED_MEMBER */
		/* set line number in element content */
		c_int linenumbers; /* XML_DEPRECATED_MEMBER */
		/* document's own catalog */
		void* catalogs; /* XML_DEPRECATED_MEMBER */
		/* run in recovery mode */
		c_int recovery; /* XML_DEPRECATED_MEMBER */
		/* unused */
		c_int progressive; /* XML_DEPRECATED_MEMBER */
		/* dictionary for the parser */
		xmlDictPtr dict;
		/* array for the attributes callbacks */
		xmlChar** atts; /* XML_DEPRECATED_MEMBER */
		/* the size of the array */
		c_int maxatts; /* XML_DEPRECATED_MEMBER */
		/* unused */
		c_int docdict; /* XML_DEPRECATED_MEMBER */

		/*
		* pre-interned strings
		*/
		xmlChar* str_xml; /* XML_DEPRECATED_MEMBER */
		xmlChar* str_xmlns; /* XML_DEPRECATED_MEMBER */
		xmlChar* str_xml_ns; /* XML_DEPRECATED_MEMBER */

		/*
		* Everything below is used only by the new SAX mode
		*/

		/* operating in the new SAX mode */
		c_int sax2; /* XML_DEPRECATED_MEMBER */
		/* the number of inherited namespaces */
		c_int nsNr; /* XML_DEPRECATED_MEMBER */
		/* the size of the arrays */
		c_int nsMax; /* XML_DEPRECATED_MEMBER */
		/* the array of prefix/namespace name */
		xmlChar** nsTab; /* XML_DEPRECATED_MEMBER */
		/* which attribute were allocated */
		c_uint* attallocs; /* XML_DEPRECATED_MEMBER */
		/* array of data for push */
		xmlStartTag* pushTab; /* XML_DEPRECATED_MEMBER */
		/* defaulted attributes if any */
		xmlHashTablePtr attsDefault; /* XML_DEPRECATED_MEMBER */
		/* non-CDATA attributes if any */
		xmlHashTablePtr attsSpecial; /* XML_DEPRECATED_MEMBER */
		/* is the document XML Namespace okay */
		c_int nsWellFormed;
		/* Extra options */
		c_int options;

		/*
		* Those fields are needed only for streaming parsing so far
		*/

		/* Use dictionary names for the tree */
		c_int dictNames; /* XML_DEPRECATED_MEMBER */
		/* number of freed element nodes */
		c_int freeElemsNr; /* XML_DEPRECATED_MEMBER */
		/* List of freed element nodes */
		xmlNodePtr freeElems; /* XML_DEPRECATED_MEMBER */
		/* number of freed attributes nodes */
		c_int freeAttrsNr; /* XML_DEPRECATED_MEMBER */
		/* List of freed attributes nodes */
		xmlAttrPtr freeAttrs; /* XML_DEPRECATED_MEMBER */

		/*
		* the complete error information for the last error.
		*/
		xmlError lastError; /* XML_DEPRECATED_MEMBER */
		/* the parser mode */
		xmlParserMode parseMode; /* XML_DEPRECATED_MEMBER */
		/* unused */
		c_ulong nbentities; /* XML_DEPRECATED_MEMBER */
		/* size of external entities */
		c_ulong sizeentities; /* XML_DEPRECATED_MEMBER */

		/* for use by HTML non-recursive parser */
		/* Current NodeInfo */
		xmlParserNodeInfo* nodeInfo; /* XML_DEPRECATED_MEMBER */
		/* Depth of the parsing stack */
		c_int nodeInfoNr; /* XML_DEPRECATED_MEMBER */
		/* Max depth of the parsing stack */
		c_int nodeInfoMax; /* XML_DEPRECATED_MEMBER */
		/* array of nodeInfos */
		xmlParserNodeInfo* nodeInfoTab; /* XML_DEPRECATED_MEMBER */

		/* we need to label inputs */
		c_int input_id; /* XML_DEPRECATED_MEMBER */
		/* volume of entity copy */
		c_ulong sizeentcopy; /* XML_DEPRECATED_MEMBER */

		/* quote state for push parser */
		c_int endCheckState; /* XML_DEPRECATED_MEMBER */
		/* number of errors */
		c_ushort nbErrors; /* XML_DEPRECATED_MEMBER */
		/* number of warnings */
		c_ushort nbWarnings; /* XML_DEPRECATED_MEMBER */
		/* maximum amplification factor */
		c_uint maxAmpl; /* XML_DEPRECATED_MEMBER */

		/* namespace database */
		xmlParserNsData* nsdb; /* XML_DEPRECATED_MEMBER */
		/* allocated size */
		c_uint attrHashMax; /* XML_DEPRECATED_MEMBER */
		/* atttribute hash table */
		xmlAttrHashBucket* attrHash; /* XML_DEPRECATED_MEMBER */

		xmlStructuredErrorFunc errorHandler; /* XML_DEPRECATED_MEMBER */
		void* errorCtxt; /* XML_DEPRECATED_MEMBER */

		xmlResourceLoader resourceLoader; /* XML_DEPRECATED_MEMBER */
		void* resourceCtxt; /* XML_DEPRECATED_MEMBER */

		xmlCharEncConvImpl convImpl; /* XML_DEPRECATED_MEMBER */
		void* convCtxt; /* XML_DEPRECATED_MEMBER */
	}

	/**
	* xmlSAXLocator:
	*
	* A SAX Locator.
	*/
	[CRepr]
	public struct xmlSAXLocator
	{
		function xmlChar*(void* ctx) getPublicId;
		function xmlChar*(void* ctx) getSystemId;
		function c_int(void* ctx) getLineNumber;
		function c_int(void* ctx) getColumnNumber;
	}

	/**
	* xmlSAXHandler:
	*
	* A SAX handler is bunch of callbacks called by the parser when processing
	* of the input generate data or structure information.
	*/

	/**
	* resolveEntitySAXFunc:
	* @ctx:  the user data (XML parser context)
	* @publicId: The public ID of the entity
	* @systemId: The system ID of the entity
	*
	* Callback:
	* The entity loader, to control the loading of external entities,
	* the application can either:
	*    - override this resolveEntity() callback in the SAX block
	*    - or better use the xmlSetExternalEntityLoader() function to
	*      set up it's own entity resolution routine
	*
	* Returns the xmlParserInputPtr if inlined or NULL for DOM behaviour.
	*/
	public function xmlParserInputPtr resolveEntitySAXFunc(void* ctx, xmlChar* publicId, xmlChar* systemId);
	/**
	* internalSubsetSAXFunc:
	* @ctx:  the user data (XML parser context)
	* @name:  the root element name
	* @ExternalID:  the external ID
	* @SystemID:  the SYSTEM ID (e.g. filename or URL)
	*
	* Callback on internal subset declaration.
	*/
	public function void internalSubsetSAXFunc(void* ctx, xmlChar* name, xmlChar* ExternalID, xmlChar* SystemID);
	/**
	* externalSubsetSAXFunc:
	* @ctx:  the user data (XML parser context)
	* @name:  the root element name
	* @ExternalID:  the external ID
	* @SystemID:  the SYSTEM ID (e.g. filename or URL)
	*
	* Callback on external subset declaration.
	*/
	public function void externalSubsetSAXFunc(void* ctx, xmlChar* name, xmlChar* ExternalID, xmlChar* SystemID);
	/**
	* getEntitySAXFunc:
	* @ctx:  the user data (XML parser context)
	* @name: The entity name
	*
	* Get an entity by name.
	*
	* Returns the xmlEntityPtr if found.
	*/
	public function xmlEntityPtr getEntitySAXFunc(void* ctx, xmlChar* name);
	/**
	* getParameterEntitySAXFunc:
	* @ctx:  the user data (XML parser context)
	* @name: The entity name
	*
	* Get a parameter entity by name.
	*
	* Returns the xmlEntityPtr if found.
	*/
	public function xmlEntityPtr getParameterEntitySAXFunc(void* ctx, xmlChar* name);
	/**
	* entityDeclSAXFunc:
	* @ctx:  the user data (XML parser context)
	* @name:  the entity name
	* @type:  the entity type
	* @publicId: The public ID of the entity
	* @systemId: The system ID of the entity
	* @content: the entity value (without processing).
	*
	* An entity definition has been parsed.
	*/
	public function void entityDeclSAXFunc(void* ctx, xmlChar* name, c_int type, xmlChar* publicId, xmlChar* systemId, xmlChar* content);
	/**
	* notationDeclSAXFunc:
	* @ctx:  the user data (XML parser context)
	* @name: The name of the notation
	* @publicId: The public ID of the entity
	* @systemId: The system ID of the entity
	*
	* What to do when a notation declaration has been parsed.
	*/
	public function void notationDeclSAXFunc(void* ctx, xmlChar* name, xmlChar* publicId, xmlChar* systemId);
	/**
	* attributeDeclSAXFunc:
	* @ctx:  the user data (XML parser context)
	* @elem:  the name of the element
	* @fullname:  the attribute name
	* @type:  the attribute type
	* @def:  the type of default value
	* @defaultValue: the attribute default value
	* @tree:  the tree of enumerated value set
	*
	* An attribute definition has been parsed.
	*/
	public function void attributeDeclSAXFunc(void* ctx, xmlChar* elem, xmlChar* fullname, c_int type, c_int def, xmlChar* defaultValue, xmlEnumerationPtr tree);
	/**
	* elementDeclSAXFunc:
	* @ctx:  the user data (XML parser context)
	* @name:  the element name
	* @type:  the element type
	* @content: the element value tree
	*
	* An element definition has been parsed.
	*/
	public function void elementDeclSAXFunc(void* ctx, xmlChar* name, c_int type, xmlElementContentPtr content);
	/**
	* unparsedEntityDeclSAXFunc:
	* @ctx:  the user data (XML parser context)
	* @name: The name of the entity
	* @publicId: The public ID of the entity
	* @systemId: The system ID of the entity
	* @notationName: the name of the notation
	*
	* What to do when an unparsed entity declaration is parsed.
	*/
	public function void unparsedEntityDeclSAXFunc(void* ctx, xmlChar* name, xmlChar* publicId, xmlChar* systemId, xmlChar* notationName);
	/**
	* setDocumentLocatorSAXFunc:
	* @ctx:  the user data (XML parser context)
	* @loc: A SAX Locator
	*
	* Receive the document locator at startup, actually xmlDefaultSAXLocator.
	* Everything is available on the context, so this is useless in our case.
	*/
	public function void setDocumentLocatorSAXFunc(void* ctx, xmlSAXLocatorPtr loc);
	/**
	* startDocumentSAXFunc:
	* @ctx:  the user data (XML parser context)
	*
	* Called when the document start being processed.
	*/
	public function void startDocumentSAXFunc(void* ctx);
	/**
	* endDocumentSAXFunc:
	* @ctx:  the user data (XML parser context)
	*
	* Called when the document end has been detected.
	*/
	public function void endDocumentSAXFunc(void* ctx);
	/**
	* startElementSAXFunc:
	* @ctx:  the user data (XML parser context)
	* @name:  The element name, including namespace prefix
	* @atts:  An array of name/value attributes pairs, NULL terminated
	*
	* Called when an opening tag has been processed.
	*/
	public function void startElementSAXFunc(void* ctx, xmlChar* name, xmlChar** atts);
	/**
	* endElementSAXFunc:
	* @ctx:  the user data (XML parser context)
	* @name:  The element name
	*
	* Called when the end of an element has been detected.
	*/
	public function void endElementSAXFunc(void* ctx, xmlChar* name);
	/**
	* attributeSAXFunc:
	* @ctx:  the user data (XML parser context)
	* @name:  The attribute name, including namespace prefix
	* @value:  The attribute value
	*
	* Handle an attribute that has been read by the parser.
	* The default handling is to convert the attribute into an
	* DOM subtree and past it in a new xmlAttr element added to
	* the element.
	*/
	public function void attributeSAXFunc(void* ctx, xmlChar* name, xmlChar* value);
	/**
	* referenceSAXFunc:
	* @ctx:  the user data (XML parser context)
	* @name:  The entity name
	*
	* Called when an entity reference is detected.
	*/
	public function void referenceSAXFunc(void* ctx, xmlChar* name);
	/**
	* charactersSAXFunc:
	* @ctx:  the user data (XML parser context)
	* @ch:  a xmlChar string
	* @len: the number of xmlChar
	*
	* Receiving some chars from the parser.
	*/
	public function void charactersSAXFunc(void* ctx, xmlChar* ch, c_int len);
	/**
	* ignorableWhitespaceSAXFunc:
	* @ctx:  the user data (XML parser context)
	* @ch:  a xmlChar string
	* @len: the number of xmlChar
	*
	* Receiving some ignorable whitespaces from the parser.
	* UNUSED: by default the DOM building will use characters.
	*/
	public function void ignorableWhitespaceSAXFunc(void* ctx, xmlChar* ch, c_int len);
	/**
	* processingInstructionSAXFunc:
	* @ctx:  the user data (XML parser context)
	* @target:  the target name
	* @data: the PI data's
	*
	* A processing instruction has been parsed.
	*/
	public function void processingInstructionSAXFunc(void* ctx, xmlChar* target, xmlChar* data);
	/**
	* commentSAXFunc:
	* @ctx:  the user data (XML parser context)
	* @value:  the comment content
	*
	* A comment has been parsed.
	*/
	public function void commentSAXFunc(void* ctx, xmlChar* value);
	/**
	* cdataBlockSAXFunc:
	* @ctx:  the user data (XML parser context)
	* @value:  The pcdata content
	* @len:  the block length
	*
	* Called when a pcdata block has been parsed.
	*/
	public function void cdataBlockSAXFunc(
		void* ctx, xmlChar* value, c_int len);
	/**
	* warningSAXFunc:
	* @ctx:  an XML parser context
	* @msg:  the message to display/transmit
	* @...:  extra parameters for the message display
	*
	* Display and format a warning messages, callback.
	*/
	public function void warningSAXFunc(void* ctx, char* msg, ...);
	/**
	* errorSAXFunc:
	* @ctx:  an XML parser context
	* @msg:  the message to display/transmit
	* @...:  extra parameters for the message display
	*
	* Display and format an error messages, callback.
	*/
	public function void errorSAXFunc(void* ctx, char* msg, ...);
	/**
	* fatalErrorSAXFunc:
	* @ctx:  an XML parser context
	* @msg:  the message to display/transmit
	* @...:  extra parameters for the message display
	*
	* Display and format fatal error messages, callback.
	* Note: so far fatalError() SAX callbacks are not used, error()
	*       get all the callbacks for errors.
	*/
	public function void fatalErrorSAXFunc(void* ctx, char* msg, ...);
	/**
	* isStandaloneSAXFunc:
	* @ctx:  the user data (XML parser context)
	*
	* Is this document tagged standalone?
	*
	* Returns 1 if true
	*/
	public function c_int isStandaloneSAXFunc(void* ctx);
	/**
	* hasInternalSubsetSAXFunc:
	* @ctx:  the user data (XML parser context)
	*
	* Does this document has an internal subset.
	*
	* Returns 1 if true
	*/
	public function c_int hasInternalSubsetSAXFunc(void* ctx);

	/**
	* hasExternalSubsetSAXFunc:
	* @ctx:  the user data (XML parser context)
	*
	* Does this document has an external subset?
	*
	* Returns 1 if true
	*/
	public function c_int hasExternalSubsetSAXFunc(void* ctx);

	/************************************************************************
	*									*
	*			The SAX version 2 API extensions		*
	*									*
	************************************************************************/
	/**
	* XML_SAX2_MAGIC:
	*
	* Special constant found in SAX2 blocks initialized fields
	*/
	const c_int XML_SAX2_MAGIC = (.)0xDEEDBEAF;

	/**
	* startElementNsSAX2Func:
	* @ctx:  the user data (XML parser context)
	* @localname:  the local name of the element
	* @prefix:  the element namespace prefix if available
	* @URI:  the element namespace name if available
	* @nb_namespaces:  number of namespace definitions on that node
	* @namespaces:  pointer to the array of prefix/URI pairs namespace definitions
	* @nb_attributes:  the number of attributes on that node
	* @nb_defaulted:  the number of defaulted attributes. The defaulted
	*                  ones are at the end of the array
	* @attributes:  pointer to the array of (localname/prefix/URI/value/end)
	*               attribute values.
	*
	* SAX2 callback when an element start has been detected by the parser.
	* It provides the namespace information for the element, as well as
	* the new namespace declarations on the element.
	*/

	public function void startElementNsSAX2Func(void* ctx, xmlChar* localname, xmlChar* prefix, xmlChar* URI, c_int nb_namespaces, xmlChar** namespaces, c_int nb_attributes, c_int nb_defaulted, xmlChar** attributes);

	/**
	* endElementNsSAX2Func:
	* @ctx:  the user data (XML parser context)
	* @localname:  the local name of the element
	* @prefix:  the element namespace prefix if available
	* @URI:  the element namespace name if available
	*
	* SAX2 callback when an element end has been detected by the parser.
	* It provides the namespace information for the element.
	*/

	public function void endElementNsSAX2Func(void* ctx, xmlChar* localname, xmlChar* prefix, xmlChar* URI);

	[CRepr]
	public struct xmlSAXHandler
	{
		internalSubsetSAXFunc internalSubset;
		isStandaloneSAXFunc isStandalone;
		hasInternalSubsetSAXFunc hasInternalSubset;
		hasExternalSubsetSAXFunc hasExternalSubset;
		resolveEntitySAXFunc resolveEntity;
		getEntitySAXFunc getEntity;
		entityDeclSAXFunc entityDecl;
		notationDeclSAXFunc notationDecl;
		attributeDeclSAXFunc attributeDecl;
		elementDeclSAXFunc elementDecl;
		unparsedEntityDeclSAXFunc unparsedEntityDecl;
		setDocumentLocatorSAXFunc setDocumentLocator;
		startDocumentSAXFunc startDocument;
		endDocumentSAXFunc endDocument;
		/*
		* `startElement` and `endElement` are only used by the legacy SAX1
		* interface and should not be used in new software. If you really
		* have to enable SAX1, the preferred way is set the `initialized`
		* member to 1 instead of XML_SAX2_MAGIC.
		*
		* For backward compatibility, it's also possible to set the
		* `startElementNs` and `endElementNs` handlers to NULL.
		*
		* You can also set the XML_PARSE_SAX1 parser option, but versions
		* older than 2.12.0 will probably crash if this option is provided
		* together with custom SAX callbacks.
		*/
		startElementSAXFunc startElement;
		endElementSAXFunc endElement;
		referenceSAXFunc reference;
		charactersSAXFunc characters;
		ignorableWhitespaceSAXFunc ignorableWhitespace;
		processingInstructionSAXFunc processingInstruction;
		commentSAXFunc comment;
		warningSAXFunc warning;
		errorSAXFunc error;
		fatalErrorSAXFunc fatalError; /* unused error() get all the errors */
		getParameterEntitySAXFunc getParameterEntity;
		cdataBlockSAXFunc cdataBlock;
		externalSubsetSAXFunc externalSubset;
		/*
		* `initialized` should always be set to XML_SAX2_MAGIC to enable the
		* modern SAX2 interface.
		*/
		c_uint initialized;
		/*
		* The following members are only used by the SAX2 interface.
		*/
		void* _private;
		startElementNsSAX2Func startElementNs;
		endElementNsSAX2Func endElementNs;
		xmlStructuredErrorFunc serror;
	}

	/*
	* SAX Version 1
	*/
	typealias xmlSAXHandlerV1Ptr = xmlSAXHandlerV1*;

	[CRepr]
	public struct xmlSAXHandlerV1
	{
		internalSubsetSAXFunc internalSubset;
		isStandaloneSAXFunc isStandalone;
		hasInternalSubsetSAXFunc hasInternalSubset;
		hasExternalSubsetSAXFunc hasExternalSubset;
		resolveEntitySAXFunc resolveEntity;
		getEntitySAXFunc getEntity;
		entityDeclSAXFunc entityDecl;
		notationDeclSAXFunc notationDecl;
		attributeDeclSAXFunc attributeDecl;
		elementDeclSAXFunc elementDecl;
		unparsedEntityDeclSAXFunc unparsedEntityDecl;
		setDocumentLocatorSAXFunc setDocumentLocator;
		startDocumentSAXFunc startDocument;
		endDocumentSAXFunc endDocument;
		startElementSAXFunc startElement;
		endElementSAXFunc endElement;
		referenceSAXFunc reference;
		charactersSAXFunc characters;
		ignorableWhitespaceSAXFunc ignorableWhitespace;
		processingInstructionSAXFunc processingInstruction;
		commentSAXFunc comment;
		warningSAXFunc warning;
		errorSAXFunc error;
		fatalErrorSAXFunc fatalError; /* unused error() get all the errors */
		getParameterEntitySAXFunc getParameterEntity;
		cdataBlockSAXFunc cdataBlock;
		externalSubsetSAXFunc externalSubset;
		c_uint initialized;
	}


	/**
	* xmlExternalEntityLoader:
	* @URL: The System ID of the resource requested
	* @ID: The Public ID of the resource requested
	* @context: the XML parser context
	*
	* External entity loaders types.
	*
	* Returns the entity input parser.
	*/
	public function xmlParserInputPtr xmlExternalEntityLoader(char* URL, char* ID, xmlParserCtxtPtr context);

	/*
	* Variables
	*/

//	XMLPUBVAR char* xmlParserVersion;
//	XML_DEPRECATED
//		XMLPUBVAR c_int oldXMLWDcompatibility;
//	XML_DEPRECATED
//		XMLPUBVAR c_int xmlParserDebugEntities;
//	XML_DEPRECATED
//		XMLPUBVAR xmlSAXLocator xmlDefaultSAXLocator;
//
//	#if LIBXML_SAX1_ENABLED
//	XML_DEPRECATED
//		XMLPUBVAR xmlSAXHandlerV1 xmlDefaultSAXHandler;
//	#endif

#if LIBXML_THREAD_ENABLED
	/* backward compatibility */
	[CLink] public static extern char** __xmlParserVersion();
	[CLink, Obsolete("")] public static extern c_int* __oldXMLWDcompatibility();
	[CLink, Obsolete("")] public static extern c_int* __xmlParserDebugEntities();
	[CLink, Obsolete("")] public static extern xmlSAXLocator* __xmlDefaultSAXLocator();

#if LIBXML_SAX1_ENABLED
	[CLink, Obsolete("")] public static extern xmlSAXHandlerV1* __xmlDefaultSAXHandler();
#endif

#endif

//	#define XML_GLOBALS_PARSER_CORE \
//	  XML_OP(xmlDoValidityCheckingDefaultValue, c_int, XML_DEPRECATED) \
//	  XML_OP(xmlGetWarningsDefaultValue, c_int, XML_DEPRECATED) \
//	  XML_OP(xmlKeepBlanksDefaultValue, c_int, XML_DEPRECATED) \
//	  XML_OP(xmlLineNumbersDefaultValue, c_int, XML_DEPRECATED) \
//	  XML_OP(xmlLoadExtDtdDefaultValue, c_int, XML_DEPRECATED) \
//	  XML_OP(xmlPedanticParserDefaultValue, c_int, XML_DEPRECATED) \
//	  XML_OP(xmlSubstituteEntitiesDefaultValue, c_int, XML_DEPRECATED)
//
//#if LIBXML_OUTPUT_ENABLED
//	  #define XML_GLOBALS_PARSER_OUTPUT \
//		XML_OP(xmlIndentTreeOutput, c_int, XML_NO_ATTR) \
//		XML_OP(xmlTreeIndentString, char* , XML_NO_ATTR) \
//		XML_OP(xmlSaveNoEmptyTags, c_int, XML_NO_ATTR)
//	#else
//	  #define XML_GLOBALS_PARSER_OUTPUT
//#endif
//
//	#define XML_GLOBALS_PARSER \
//	  XML_GLOBALS_PARSER_CORE \
//	  XML_GLOBALS_PARSER_OUTPUT
//
//	#define XML_OP XML_DECLARE_GLOBAL
//	XML_GLOBALS_PARSER
//	#undef XML_OP
//
//#if defined(LIBXML_THREAD_ENABLED) && !defined(XML_GLOBALS_NO_REDEFINITION)
//	  #define xmlDoValidityCheckingDefaultValue \
//		XML_GLOBAL_MACRO(xmlDoValidityCheckingDefaultValue)
//	  #define xmlGetWarningsDefaultValue \
//		XML_GLOBAL_MACRO(xmlGetWarningsDefaultValue)
//	  #define xmlKeepBlanksDefaultValue XML_GLOBAL_MACRO(xmlKeepBlanksDefaultValue)
//	  #define xmlLineNumbersDefaultValue \
//		XML_GLOBAL_MACRO(xmlLineNumbersDefaultValue)
//	  #define xmlLoadExtDtdDefaultValue XML_GLOBAL_MACRO(xmlLoadExtDtdDefaultValue)
//	  #define xmlPedanticParserDefaultValue \
//		XML_GLOBAL_MACRO(xmlPedanticParserDefaultValue)
//	  #define xmlSubstituteEntitiesDefaultValue \
//		XML_GLOBAL_MACRO(xmlSubstituteEntitiesDefaultValue)
//	#if LIBXML_OUTPUT_ENABLED
//		#define xmlIndentTreeOutput XML_GLOBAL_MACRO(xmlIndentTreeOutput)
//		#define xmlTreeIndentString XML_GLOBAL_MACRO(xmlTreeIndentString)
//		#define xmlSaveNoEmptyTags XML_GLOBAL_MACRO(xmlSaveNoEmptyTags)
//	#endif
//#endif

	/*
	* Init/Cleanup
	*/
	[CLink] public static extern void xmlInitParser();
	[CLink] public static extern void xmlCleanupParser();
	[CLink, Obsolete("")] public static extern void xmlInitGlobals();
	[CLink, Obsolete("")] public static extern void xmlCleanupGlobals();

	/*
	* Input functions
	*/
	[CLink, Obsolete("")] public static extern c_int xmlParserInputRead(xmlParserInputPtr in_, c_int len);
	[CLink] public static extern c_int xmlParserInputGrow(xmlParserInputPtr in_, c_int len);

	/*
	* Basic parsing Interfaces
	*/
#if LIBXML_SAX1_ENABLED
	[CLink] public static extern xmlDocPtr xmlParseDoc(xmlChar* cur);
	[CLink] public static extern xmlDocPtr xmlParseFile(char* filename);
	[CLink] public static extern xmlDocPtr xmlParseMemory(char* buffer, c_int size);
#endif /* LIBXML_SAX1_ENABLED */ 

	[CLink, Obsolete("")] public static extern c_int xmlSubstituteEntitiesDefault(c_int val);
	[CLink, Obsolete("")] public static extern c_int xmlThrDefSubstituteEntitiesDefaultValue(c_int v);
	[CLink] public static extern c_int xmlKeepBlanksDefault(c_int val);
	[CLink, Obsolete("")] public static extern c_int xmlThrDefKeepBlanksDefaultValue(c_int v);
	[CLink] public static extern void xmlStopParser(xmlParserCtxtPtr ctxt);
	[CLink, Obsolete("")] public static extern c_int xmlPedanticParserDefault(c_int val);
	[CLink, Obsolete("")] public static extern c_int xmlThrDefPedanticParserDefaultValue(c_int v);
	[CLink, Obsolete("")] public static extern c_int xmlLineNumbersDefault(c_int val);
	[CLink, Obsolete("")] public static extern c_int xmlThrDefLineNumbersDefaultValue(c_int v);
	[CLink, Obsolete("")] public static extern c_int xmlThrDefDoValidityCheckingDefaultValue(c_int v);
	[CLink, Obsolete("")] public static extern c_int xmlThrDefGetWarningsDefaultValue(c_int v);
	[CLink, Obsolete("")] public static extern c_int xmlThrDefLoadExtDtdDefaultValue(c_int v);
	[CLink, Obsolete("")] public static extern c_int xmlThrDefParserDebugEntities(c_int v);

#if LIBXML_SAX1_ENABLED
	/*
	* Recovery mode
	*/
	[CLink, Obsolete("")] public static extern xmlDocPtr xmlRecoverDoc(xmlChar* cur);
	[CLink, Obsolete("")] public static extern xmlDocPtr xmlRecoverMemory(char* buffer, c_int size);
	[CLink, Obsolete("")] public static extern xmlDocPtr xmlRecoverFile(char* filename);
#endif /* LIBXML_SAX1_ENABLED */

	/*
	* Less common routines and SAX interfaces
	*/
	[CLink] public static extern c_int xmlParseDocument(xmlParserCtxtPtr ctxt);
	[CLink, Obsolete("")] public static extern c_int xmlParseExtParsedEnt(xmlParserCtxtPtr ctxt);

#if LIBXML_SAX1_ENABLED
	[CLink, Obsolete("")] public static extern c_int xmlSAXUserParseFile(xmlSAXHandlerPtr sax, void *user_data, char* filename);
	[CLink, Obsolete("")] public static extern c_int xmlSAXUserParseMemory(xmlSAXHandlerPtr sax, void *user_data, char* buffer, c_int size);
	[CLink, Obsolete("")] public static extern xmlDocPtr xmlSAXParseDoc(xmlSAXHandlerPtr sax, xmlChar* cur, c_int recovery);
	[CLink, Obsolete("")] public static extern xmlDocPtr xmlSAXParseMemory(xmlSAXHandlerPtr sax, char* buffer, c_int size, c_int recovery);
	[CLink, Obsolete("")] public static extern xmlDocPtr xmlSAXParseMemoryWithData (xmlSAXHandlerPtr sax, char* buffer, c_int size, c_int recovery, void *data);
	[CLink, Obsolete("")] public static extern xmlDocPtr xmlSAXParseFile(xmlSAXHandlerPtr sax, char* filename, c_int recovery);
	[CLink, Obsolete("")] public static extern xmlDocPtr xmlSAXParseFileWithData(xmlSAXHandlerPtr sax, char* filename, c_int recovery, void *data);
	[CLink, Obsolete("")] public static extern xmlDocPtr xmlSAXParseEntity(xmlSAXHandlerPtr sax, char* filename);
	[CLink, Obsolete("")] public static extern xmlDocPtr xmlParseEntity(char* filename);
#endif /* LIBXML_SAX1_ENABLED */

#if LIBXML_VALID_ENABLED
	[CLink] public static extern xmlDtdPtr xmlCtxtParseDtd(xmlParserCtxtPtr ctxt, xmlParserInputPtr input, xmlChar* ExternalID, xmlChar* SystemID);
	[CLink] public static extern c_int xmlCtxtValidateDocument(xmlParserCtxtPtr ctxt, xmlDocPtr doc);
	[CLink] public static extern c_int xmlCtxtValidateDtd(xmlParserCtxtPtr ctxt, xmlDocPtr doc, xmlDtdPtr dtd);
	[CLink, Obsolete("")] public static extern xmlDtdPtr xmlSAXParseDTD(xmlSAXHandlerPtr sax, xmlChar* ExternalID, xmlChar* SystemID);
	[CLink] public static extern xmlDtdPtr xmlParseDTD(xmlChar* ExternalID, xmlChar* SystemID);
	[CLink] public static extern xmlDtdPtr xmlIOParseDTD(xmlSAXHandlerPtr sax, xmlParserInputBufferPtr input, xmlCharEncoding enc);
#endif /* LIBXML_VALID_ENABLE */

#if LIBXML_SAX1_ENABLED
	[CLink] public static extern c_int xmlParseBalancedChunkMemory(xmlDocPtr doc, xmlSAXHandlerPtr sax, void *user_data, c_int depth, xmlChar* string, xmlNodePtr *lst);
#endif /* LIBXML_SAX1_ENABLED */

	[CLink] public static extern xmlParserErrors xmlParseInNodeContext(xmlNodePtr node, char* data, c_int datalen, c_int options, xmlNodePtr *lst);

#if LIBXML_SAX1_ENABLED
	[CLink] public static extern c_int xmlParseBalancedChunkMemoryRecover(xmlDocPtr doc, xmlSAXHandlerPtr sax, void *user_data, c_int depth, xmlChar* string, xmlNodePtr *lst, c_int recover);
	[CLink, Obsolete("")] public static extern c_int xmlParseExternalEntity(xmlDocPtr doc, xmlSAXHandlerPtr sax, void *user_data, c_int depth, xmlChar* URL, xmlChar* ID, xmlNodePtr *lst);
#endif /* LIBXML_SAX1_ENABLED */

	[CLink] public static extern c_int xmlParseCtxtExternalEntity(xmlParserCtxtPtr ctx, xmlChar* URL, xmlChar* ID, xmlNodePtr *lst);

	/*
	* Parser contexts handling.
	*/
	[CLink] public static extern xmlParserCtxtPtr xmlNewParserCtxt();
	[CLink] public static extern xmlParserCtxtPtr xmlNewSAXParserCtxt(xmlSAXHandler *sax, void *userData);
	[CLink] public static extern c_int xmlInitParserCtxt(xmlParserCtxtPtr ctxt);
	[CLink] public static extern void xmlClearParserCtxt(xmlParserCtxtPtr ctxt);
	[CLink] public static extern void xmlFreeParserCtxt(xmlParserCtxtPtr ctxt);
  
#if LIBXML_SAX1_ENABLED
	[CLink, Obsolete("")] public static extern void xmlSetupParserForBuffer(xmlParserCtxtPtr ctxt, xmlChar* buffer, char* filename);
#endif /* LIBXML_SAX1_ENABLED */
	[CLink] public static extern xmlParserCtxtPtr xmlCreateDocParserCtxt(xmlChar* cur);

#if LIBXML_LEGACY_ENABLED
	/*
	* Reading/setting optional parsing features.
	*/
	[CLink, Obsolete("")] public static extern c_int xmlGetFeaturesList(c_int *len, char* *result);
	[CLink, Obsolete("")] public static extern c_int xmlGetFeature(xmlParserCtxtPtr ctxt, char* name, void *result);
	[CLink, Obsolete("")] public static extern c_int xmlSetFeature(xmlParserCtxtPtr ctxt, char* name, void *value);
#endif /* LIBXML_LEGACY_ENABLED */

#if LIBXML_PUSH_ENABLED
	/*
	* Interfaces for the Push mode.
	*/
	[CLink] public static extern xmlParserCtxtPtr xmlCreatePushParserCtxt(xmlSAXHandlerPtr sax, void *user_data, char* chunk, c_int size, char* filename);
	[CLink] public static extern c_int xmlParseChunk(xmlParserCtxtPtr ctxt, char* chunk, c_int size, c_int terminate);
#endif /* LIBXML_PUSH_ENABLED */

	/*
	* Special I/O mode.
	*/

	[CLink] public static extern xmlParserCtxtPtr xmlCreateIOParserCtxt(xmlSAXHandlerPtr sax, void *user_data, xmlInputReadCallback   ioread, xmlInputCloseCallback  ioclose, void *ioctx, xmlCharEncoding enc);

	[CLink] public static extern xmlParserInputPtr xmlNewIOInputStream(xmlParserCtxtPtr ctxt, xmlParserInputBufferPtr input, xmlCharEncoding enc);

	/*
	* Node infos.
	*/
	[CLink, Obsolete("")] public static extern xmlParserNodeInfo* xmlParserFindNodeInfo(xmlParserCtxtPtr ctxt, xmlNodePtr node);
	[CLink, Obsolete("")] public static extern void xmlInitNodeInfoSeq(xmlParserNodeInfoSeqPtr seq);
	[CLink, Obsolete("")] public static extern void xmlClearNodeInfoSeq(xmlParserNodeInfoSeqPtr seq);
	[CLink, Obsolete("")] public static extern c_ulong xmlParserFindNodeInfoIndex(xmlParserNodeInfoSeqPtr seq, xmlNodePtr node);
	[CLink, Obsolete("")] public static extern void xmlParserAddNodeInfo(xmlParserCtxtPtr ctxt, xmlParserNodeInfoPtr info);

	/*
	* External entities handling actually implemented in xmlIO.
	*/

	[CLink] public static extern void xmlSetExternalEntityLoader(xmlExternalEntityLoader f);
	[CLink] public static extern xmlExternalEntityLoader xmlGetExternalEntityLoader();
	[CLink] public static extern xmlParserInputPtr xmlLoadExternalEntity(char* URL, char* ID, xmlParserCtxtPtr ctxt);

	[CLink, Obsolete("")] public static extern c_long xmlByteConsumed(xmlParserCtxtPtr ctxt);

	/*
	* New set of simpler/more flexible APIs
	*/
	/**
	* xmlParserOption:
	*
	* This is the set of XML parser options that can be passed down
	* to the xmlReadDoc() and similar calls.
	*/
	public enum xmlParserOption  : c_int
	{
		XML_PARSE_RECOVER	= 1<<0,	/* recover on errors */
		XML_PARSE_NOENT	= 1<<1,	/* substitute entities */
		XML_PARSE_DTDLOAD	= 1<<2,	/* load the external subset */
		XML_PARSE_DTDATTR	= 1<<3,	/* default DTD attributes */
		XML_PARSE_DTDVALID	= 1<<4,	/* validate with the DTD */
		XML_PARSE_NOERROR	= 1<<5,	/* suppress error reports */
		XML_PARSE_NOWARNING	= 1<<6,	/* suppress warning reports */
		XML_PARSE_PEDANTIC	= 1<<7,	/* pedantic error reporting */
		XML_PARSE_NOBLANKS	= 1<<8,	/* remove blank nodes */
		XML_PARSE_SAX1	= 1<<9,	/* use the SAX1 interface internally */
		XML_PARSE_XINCLUDE	= 1<<10,/* Implement XInclude substitution  */
		XML_PARSE_NONET	= 1<<11,/* Forbid network access */
		XML_PARSE_NODICT	= 1<<12,/* Do not reuse the context dictionary */
		XML_PARSE_NSCLEAN	= 1<<13,/* remove redundant namespaces declarations */
		XML_PARSE_NOCDATA	= 1<<14,/* merge CDATA as text nodes */
		XML_PARSE_NOXINCNODE= 1<<15,/* do not generate XINCLUDE START/END nodes */
		XML_PARSE_COMPACT   = 1<<16,/* compact small text nodes; no modification of the tree allowed afterwards (will possibly crash if you try to modify the tree) */
		XML_PARSE_OLD10	= 1<<17,/* parse using XML-1.0 before update 5 */
		XML_PARSE_NOBASEFIX = 1<<18,/* do not fixup XINCLUDE xml:base uris */
		XML_PARSE_HUGE      = 1<<19,/* relax any hardcoded limit from the parser */
		XML_PARSE_OLDSAX    = 1<<20,/* parse using SAX2 interface before 2.7.0 */
		XML_PARSE_IGNORE_ENC= 1<<21,/* ignore internal document encoding hint */
		XML_PARSE_BIG_LINES = 1<<22,/* Store big lines numbers in text PSVI field */
		/* since 2.13.0 */
		XML_PARSE_NO_XXE    = 1<<23,/* disable loading of external content */
		/* since 2.14.0 */
		XML_PARSE_UNZIP          = 1<<24,/* allow compressed content */
		XML_PARSE_NO_SYS_CATALOG = 1<<25,/* disable global system catalog */
		XML_PARSE_CATALOG_PI     = 1<<26 /* allow catalog PIs */
	} ;

	[CLink] public static extern void xmlCtxtReset(xmlParserCtxtPtr ctxt);
	[CLink] public static extern c_int xmlCtxtResetPush(xmlParserCtxtPtr ctxt, char* chunk, c_int size, char* filename, char* encoding);
	[CLink] public static extern c_int xmlCtxtGetOptions(xmlParserCtxtPtr ctxt);
	[CLink] public static extern c_int xmlCtxtSetOptions(xmlParserCtxtPtr ctxt, c_int options);
	[CLink] public static extern c_int xmlCtxtUseOptions(xmlParserCtxtPtr ctxt, c_int options);
	[CLink] public static extern void * xmlCtxtGetPrivate(xmlParserCtxtPtr ctxt);
	[CLink] public static extern void xmlCtxtSetPrivate(xmlParserCtxtPtr ctxt, void *priv);
	[CLink] public static extern void * xmlCtxtGetCatalogs(xmlParserCtxtPtr ctxt);
	[CLink] public static extern void xmlCtxtSetCatalogs(xmlParserCtxtPtr ctxt, void *catalogs);
	[CLink] public static extern xmlDictPtr xmlCtxtGetDict(xmlParserCtxtPtr ctxt);
	[CLink] public static extern void xmlCtxtSetDict(xmlParserCtxtPtr ctxt, xmlDictPtr);
	[CLink] public static extern xmlChar*  xmlCtxtGetVersion(xmlParserCtxtPtr ctxt);
	[CLink] public static extern xmlChar*  xmlCtxtGetDeclaredEncoding(xmlParserCtxtPtr ctxt);
	[CLink] public static extern c_int xmlCtxtGetStandalone(xmlParserCtxtPtr ctxt);
	[CLink] public static extern c_int xmlCtxtGetStatus(xmlParserCtxtPtr ctxt);
	[CLink] public static extern void xmlCtxtSetErrorHandler(xmlParserCtxtPtr ctxt, xmlStructuredErrorFunc handler, void *data);
	[CLink] public static extern void xmlCtxtSetResourceLoader(xmlParserCtxtPtr ctxt, xmlResourceLoader loader, void *vctxt);
	[CLink] public static extern void xmlCtxtSetCharEncConvImpl(xmlParserCtxtPtr ctxt, xmlCharEncConvImpl impl, void *vctxt);
	[CLink] public static extern void xmlCtxtSetMaxAmplification(xmlParserCtxtPtr ctxt, c_uint maxAmpl);
	[CLink] public static extern xmlDocPtr xmlReadDoc(xmlChar* cur, char* URL, char* encoding, c_int options);
	[CLink] public static extern xmlDocPtr xmlReadFile(char* URL, char* encoding, c_int options);
	[CLink] public static extern xmlDocPtr xmlReadMemory(char* buffer, c_int size, char* URL, char* encoding, c_int options);
	[CLink] public static extern xmlDocPtr xmlReadFd(c_int fd, char* URL, char* encoding, c_int options);
	[CLink] public static extern xmlDocPtr xmlReadIO(xmlInputReadCallback ioread, xmlInputCloseCallback ioclose, void *ioctx, char* URL, char* encoding, c_int options);
	[CLink] public static extern xmlDocPtr xmlCtxtParseDocument(xmlParserCtxtPtr ctxt, xmlParserInputPtr input);
	[CLink] public static extern xmlNodePtr xmlCtxtParseContent(xmlParserCtxtPtr ctxt, xmlParserInputPtr input, xmlNodePtr node, c_int hasTextDecl);
	[CLink] public static extern xmlDocPtr xmlCtxtReadDoc(xmlParserCtxtPtr ctxt, xmlChar* cur, char* URL, char* encoding, c_int options);
	[CLink] public static extern xmlDocPtr xmlCtxtReadFile(xmlParserCtxtPtr ctxt, char* filename, char* encoding, c_int options);
	[CLink] public static extern xmlDocPtr xmlCtxtReadMemory(xmlParserCtxtPtr ctxt, char* buffer, c_int size, char* URL, char* encoding, c_int options);
	[CLink] public static extern xmlDocPtr xmlCtxtReadFd(xmlParserCtxtPtr ctxt, c_int fd, char* URL, char* encoding, c_int options);
	[CLink] public static extern xmlDocPtr xmlCtxtReadIO(xmlParserCtxtPtr ctxt, xmlInputReadCallback ioread, xmlInputCloseCallback ioclose, void *ioctx, char* URL, char* encoding, c_int options);

	/**
	* New input API
	*/

	const c_int XML_INPUT_BUF_STATIC		        = 1 << 1;
	const c_int XML_INPUT_BUF_ZERO_TERMINATED	  = 1 << 2;
	const c_int XML_INPUT_UNZIP                 = 1 << 3;
	const c_int XML_INPUT_NETWORK               = 1 << 4;

	[CLink] public static extern c_int xmlNewInputFromUrl(char* url, c_int flags, xmlParserInputPtr *out_);
	[CLink] public static extern xmlParserInputPtr xmlNewInputFromMemory(char* url, void *mem, size_t size, c_int flags);
	[CLink] public static extern xmlParserInputPtr xmlNewInputFromString(char* url, char* str, c_int flags);
	[CLink] public static extern xmlParserInputPtr xmlNewInputFromFd(char* url, c_int fd, c_int flags);
	[CLink] public static extern xmlParserInputPtr xmlNewInputFromIO(char* url, xmlInputReadCallback ioRead, xmlInputCloseCallback ioClose, void *ioCtxt, c_int flags);
	[CLink] public static extern c_int xmlInputSetEncodingHandler(xmlParserInputPtr input, xmlCharEncodingHandlerPtr handler);

	/*
	* Library wide options
	*/
	/**
	* xmlFeature:
	*
	* Used to examine the existence of features that can be enabled
	* or disabled at compile-time.
	* They used to be called XML_FEATURE_xxx but this clashed with Expat
	*/
	public enum xmlFeature  : c_int
	{
		XML_WITH_THREAD = 1,
		XML_WITH_TREE = 2,
		XML_WITH_OUTPUT = 3,
		XML_WITH_PUSH = 4,
		XML_WITH_READER = 5,
		XML_WITH_PATTERN = 6,
		XML_WITH_WRITER = 7,
		XML_WITH_SAX1 = 8,
		XML_WITH_FTP = 9,
		XML_WITH_HTTP = 10,
		XML_WITH_VALID = 11,
		XML_WITH_HTML = 12,
		XML_WITH_LEGACY = 13,
		XML_WITH_C14N = 14,
		XML_WITH_CATALOG = 15,
		XML_WITH_XPATH = 16,
		XML_WITH_XPTR = 17,
		XML_WITH_XINCLUDE = 18,
		XML_WITH_ICONV = 19,
		XML_WITH_ISO8859X = 20,
		XML_WITH_UNICODE = 21,
		XML_WITH_REGEXP = 22,
		XML_WITH_AUTOMATA = 23,
		XML_WITH_EXPR = 24,
		XML_WITH_SCHEMAS = 25,
		XML_WITH_SCHEMATRON = 26,
		XML_WITH_MODULES = 27,
		XML_WITH_DEBUG = 28,
		XML_WITH_DEBUG_MEM = 29,
		XML_WITH_DEBUG_RUN = 30, /* unused */
		XML_WITH_ZLIB = 31,
		XML_WITH_ICU = 32,
		XML_WITH_LZMA = 33,
		XML_WITH_NONE = 99999 /* just to be sure of allocation size */
	}

	[CLink] public static extern c_int xmlHasFeature(xmlFeature feature);
}