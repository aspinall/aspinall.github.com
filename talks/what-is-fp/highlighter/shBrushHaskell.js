/**
 * SyntaxHighlighter
 * http://alexgorbatchev.com/SyntaxHighlighter
 *
 * SyntaxHighlighter is donationware. If you are using it, please donate.
 * http://alexgorbatchev.com/SyntaxHighlighter/donate.html
 *
 * @version
 * 3.0.83 (July 02 2010)
 * 
 * @copyright
 * Copyright (C) 2004-2010 Alex Gorbatchev.
 *
 * @license
 * Dual licensed under the MIT and GPL licenses.
 */
;(function()
{
	// CommonJS
	typeof(require) != 'undefined' ? SyntaxHighlighter = require('shCore').SyntaxHighlighter : null;

	function Brush()
	{
		var keywords = 'as case class data default deriving do else foreign hiding if import in '
			+ 'infix infixl infixr instance let module newtype of qualified then type where';

		this.regexList = [
			{ regex: new RegExp("\\b([\\d]+(\\.[\\d]+)?)\\b", 'gi'),	css: 'value' },
			{ regex: new RegExp("--.+", 'gm'), 				css: 'comments' },
			{ regex: SyntaxHighlighter.regexLib.doubleQuotedString,		css: 'string' },
			{ regex: SyntaxHighlighter.regexLib.singleQuotedString,		css: 'string' },
			{ regex: new RegExp(this.getKeywords(keywords),	'gm'),		css: 'keyword' }
			];
	};

	Brush.prototype	= new SyntaxHighlighter.Highlighter();
	Brush.aliases	= ['hs', 'haskell'];

	SyntaxHighlighter.brushes.Haskell = Brush;

	// CommonJS
	typeof(exports) != 'undefined' ? exports.Brush = Brush : null;
})();
