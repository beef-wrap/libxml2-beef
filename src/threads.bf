/**
 * Summary: interfaces for thread handling
 * Description: set of generic threading related routines
 *              should work with pthreads, Windows native or TLS threads
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
	* xmlMutex are a simple mutual exception locks.
	*/
	[CRepr]
	public struct xmlMutex;
	typealias xmlMutexPtr = xmlMutex*;

	/*
	* xmlRMutex are reentrant mutual exception locks.
	*/
	public struct xmlRMutex;
	typealias xmlRMutexPtr = xmlRMutex*;

	[CLink] public static extern int xmlCheckThreadLocalStorage();

	[CLink] public static extern xmlMutexPtr xmlNewMutex();
	[CLink] public static extern void xmlMutexLock(xmlMutexPtr tok);
	[CLink] public static extern void xmlMutexUnlock(xmlMutexPtr tok);
	[CLink] public static extern void xmlFreeMutex(xmlMutexPtr tok);

	[CLink] public static extern xmlRMutexPtr xmlNewRMutex();
	[CLink] public static extern void xmlRMutexLock(xmlRMutexPtr tok);
	[CLink] public static extern void xmlRMutexUnlock(xmlRMutexPtr tok);
	[CLink] public static extern void xmlFreeRMutex(xmlRMutexPtr tok);

	/*
	* Library wide APIs.
	*/

	[CLink, Obsolete("")] public static extern void xmlInitThreads();
	[CLink] public static extern void xmlLockLibrary();
	[CLink] public static extern void xmlUnlockLibrary();
	[CLink, Obsolete("")] public static extern int xmlGetThreadId();
	[CLink, Obsolete("")] public static extern int xmlIsMainThread();
	[CLink, Obsolete("")] public static extern void xmlCleanupThreads();

	/** DOC_DISABLE */
	// #if LIBXML_THREAD_ENABLED && _WIN32 && LIBXML_STATIC_FOR_DLL
	// 	int xmlDllMain(void *hinstDLL, c_ulong fdwReason, void *lpvReserved);
	// #endif
	/** DOC_ENABLE */
}