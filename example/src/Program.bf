using System;
using System.Collections;
using System.Diagnostics;
using System.IO;
using static libxml2.libxml2;

namespace example;

static class Program
{
	/**
	 * processNode:
	 * @reader: the xmlReader
	 *
	 * Dump information about the current node
	 */
	static void
		processNode(xmlTextReaderPtr reader)
	{
		xmlChar* name;
		xmlChar* value;

		name = xmlTextReaderConstName(reader);

		/*if (name == null)
			name = "--";*/

		value = xmlTextReaderConstValue(reader);


		Debug.WriteLine($"{xmlTextReaderDepth(reader)} {xmlTextReaderNodeType(reader)} {StringView((.)name)} {xmlTextReaderIsEmptyElement(reader)} {xmlTextReaderHasValue(reader)}");

		if (value == null)
			Debug.WriteLine("");
		else
		{
			if (xmlStrlen(value) > 40)
				Debug.WriteLine($" {StringView((.)value)}...\n", value);
			else
				Debug.WriteLine($" {StringView((.)value)}\n", value);
		}
	}

	/**
	 * streamFile:
	 * @filename: the file name to parse
	 *
	 * Parse and print information about an XML file.
	 */
	static void
		streamFile(char8* filename)
	{
		xmlTextReaderPtr reader;
		int ret;

		reader = xmlReaderForFile(filename, null, 0);
		if (reader != null)
		{
			ret = xmlTextReaderRead(reader);
			while (ret == 1)
			{
				processNode(reader);
				ret = xmlTextReaderRead(reader);
			}
			xmlFreeTextReader(reader);
			if (ret != 0)
			{
				Debug.WriteLine($"{filename} : failed to parse\n");
			}
		} else
		{
			Debug.WriteLine($"Unable to open {filename}\n");
		}
	}


	static int Main(params String[] args)
	{
		streamFile("test3.xml");

		return 0;
	}
}