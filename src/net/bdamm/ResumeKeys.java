package net.bdamm;

import org.jdom.*;
import org.jdom.input.*;
import org.jdom.output.*;
import org.jdom.filter.*;

import java.text.*;
import java.util.*;
import java.io.*;

/**
 * Selects appropriate information into my resume based on keys.
 * Given a set of keys, makes a resume based on that.
 *
 * @author Ben Damm, bdamm@bdamm.net
 */
// TODO
// Make the key stripping mechanism manipulate the tree instead of
// just dropping elements when printing the tree out.
//
public class ResumeKeys
{
	public static void main( String args[] )
		throws Exception
	{
		if( args.length < 2 )
		{
			System.out.println( "Usage: java ResumeKeys <infile> <outfile> {<key> }" );
			return;
		}
		SAXBuilder builder = new SAXBuilder();

		String inFile = args[0];
		String outFile = args[1];

		Document doc = builder.build( inFile );

		Set keys = new HashSet();

		// The third
		for( int i = 2; i < args.length; ++i )
		{
			keys.add( args[i] );
		}

		Set allKeys = getAllKeys( doc );
		Iterator allI = allKeys.iterator();
		System.out.print( "Available keys: " );
		while( allI.hasNext() )
		{
			System.out.print( allI.next() );
			if( allI.hasNext() )
				System.out.print( ", " );
		}
		System.out.println();

		Iterator i = keys.iterator();
		while( i.hasNext() )
		{
			System.out.println( "Resume Key: " + i.next() );
		}

		// The "format" object actually does all the work of stripping
		// the keys out, by simply not printing them.  Yes, it's ugly,
		// but this is supposed to be a one-shot program.
		XMLOutputter output = new MyFormat( keys );

		output.output( doc, new FileOutputStream( outFile ) );
	}

	private static Set getAllKeys( Document doc )
	{
		Set set = new TreeSet();
		List elts = getAllElements( doc );

		Iterator eltsI = elts.iterator();
		while( eltsI.hasNext() )
		{
			Element elt = (Element)eltsI.next();
			String keysVal = elt.getAttributeValue( "keys" );
			if( keysVal != null )
			{
				CommaIterator ci = new CommaIterator( keysVal );
				set.addAll( ci.makeSet() );
			}
		}

		return set;
	}

	/**
	 * Returns a list containing all elements in a document.  Works by
	 * recursively walking the document.
	 * */
	private static List getAllElements( Document doc )
	{
		List list = new LinkedList();
		getAllElements( doc.getRootElement(), list );

		return list;
	}

	private static Filter elementFilter = new ElementFilter();
	private static void getAllElements( Element elt, List list )
	{
		list.add( elt );

		// Now, for each child, do this
		List kids = elt.getContent( elementFilter );
		
		Iterator iter = kids.iterator();
		while( iter.hasNext() )
		{
			Element kid = (Element)iter.next();
			getAllElements( kid, list );
			//System.err.println( elt.getClass().getName() );
		}
	}
}

class CommaIterator implements Iterator
{
	StringTokenizer tokens;
	public CommaIterator( String in )
	{
		tokens = new StringTokenizer( in, "," );
	}

	public void remove()
	{
		throw new UnsupportedOperationException("oops" );
	}

	public boolean hasNext()
	{
		return tokens.hasMoreTokens();
	}

	public Object next()
	{
		return tokens.nextToken();
	}

	/**
	 * Takes the remaining elements in the list and makes a set out of
	 * them.
	 * */
	public Set makeSet()
	{
		Set set = new HashSet();
		while( hasNext() )
		{
			String aKey = (String)next();
			set.add( aKey );
		}
		return set;
	}
}


class MyFormat extends XMLOutputter
{
	// Date format to use when adding new bookmarks
	//private final SimpleDateFormat isoDate = new SimpleDateFormat( "yyyy-MM-dd" );

	// Set to make sure there are no colliding IDs
	//private Set ids = new HashSet();
	
	// Keys to filter on
	private Set resKeys;

	public MyFormat( Set keys )
	{
		this.resKeys = keys;
		//setNewlines( true );
		//setLineSeparator( "\n" );
		setIndent( "\t" );
	}

	protected void printElement( Element elt, Writer out, int level, NamespaceStack namespace )
		throws IOException
	{
		String keysValue = elt.getAttributeValue( "keys" );
		if( keysValue != null )
		{
			// It has a keys attribute.
			// 1) Break the keys up into a set         _
			// 2) Perform a set intersection: eltKeys | |  resKeys
			// 3) If the resulting set is empty, do not print the
			//    attribute.
			//
			CommaIterator tokens = new CommaIterator( keysValue );
			Set eltKeys = tokens.makeSet();

			// Intersection of sets
			eltKeys.retainAll( resKeys );

			if( eltKeys.isEmpty() ) // No corresponding keys
			{
				//System.out.println( "Not printing: " + elt.getText() );
				//System.out.println( "With keys: " + keysValue );

				return; // Don't print the element.
			}
		}

		// The element either has no keys attribute, or contains at
		// least one key that is in the specification.
		super.printElement( elt, out, level, namespace );
	}

	/** Dysfunctional */
	public static void test()
	{
		Element rootElt = new Element("foo");

		Document rootDoc = new Document();
		rootDoc.setRootElement( rootElt );
	}
}

