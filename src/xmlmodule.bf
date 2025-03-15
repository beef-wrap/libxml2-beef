/*
 * Summary: dynamic module loading
 * Description: basic API for dynamic module loading, used by
 *              libexslt added in 2.6.17
 *
 * Copy: See Copyright for the status of this software.
 *
 * Author: Joel W. Reed
 */


using System;
using System.Interop;

namespace libxml2;

#if LIBXML_MODULES_ENABLED

extension libxml2
{
	/**
	 * xmlModulePtr:
	 *
	 * A handle to a dynamically loaded module
	 */
	public struct xmlModule;
	typealias xmlModulePtr = xmlModule*;

	/**
	 * xmlModuleOption:
	 *
	 * enumeration of options that can be passed down to xmlModuleOpen()
	 */
	public enum xmlModuleOption
	{
		XML_MODULE_LAZY = 1, /* lazy binding */
		XML_MODULE_LOCAL = 2 /* local binding */
	}

	[CLink, Obsolete("")] public static extern xmlModulePtr xmlModuleOpen(char* filename, c_int options);
	[CLink, Obsolete("")] public static extern c_int xmlModuleSymbol(xmlModulePtr module, char* name, void** result);
	[CLink, Obsolete("")] public static extern c_int xmlModuleClose(xmlModulePtr module);
	[CLink, Obsolete("")] public static extern c_int xmlModuleFree(xmlModulePtr module);
}

#endif /* LIBXML_MODULES_ENABLED */ 
